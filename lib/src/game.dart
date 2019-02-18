import 'dart:math';

import 'package:meta/meta.dart';
import 'dart:collection';

import 'package:nyanya_rocket_base/src/board.dart';
import 'package:nyanya_rocket_base/src/entity.dart';
import 'package:nyanya_rocket_base/src/protocol/game_server.pb.dart';
import 'package:nyanya_rocket_base/src/tile.dart';

typedef MouseEatenCallback = void Function(Mouse mouse, Cat cat);
typedef EntityInPitCallback = void Function(Entity entity, int x, int y);
typedef EntityInRocketCallback = void Function(Entity entity, int x, int y);
typedef ArrowExpiredCallback = void Function(Arrow arrow, int x, int y);

enum GameEvent {
  None,
  MouseMania,
  CatMania,
  SpeedUp,
  SlowDown,
  PlaceAgain,
  CatAttack,
  MouseMonopoly,
}

enum GeneratorPolicy {
  Regular,
  MouseMania,
  CatAttack,
}

class Game {
  List<int> _scores = List.filled(4, 0, growable: false);
  Board board = Board();
  SplayTreeMap<int, Entity> entities = SplayTreeMap();
  Random rng = Random();
  GameEvent currentEvent = GameEvent.None;
  int _livingCats = 0;

  MouseEatenCallback onMouseEaten;
  EntityInPitCallback onEntityInPit;
  EntityInRocketCallback onEntityInRocket;
  ArrowExpiredCallback onArrowExpiry;

  Game();

  Game.fromJson(Map<String, dynamic> parsedJson) {
    board = Board.fromJson(parsedJson['board']);
    entities = SplayTreeMap.from(parsedJson['entities'].map<int, Entity>(
        (String id, dynamic entity) =>
            MapEntry<int, Entity>(int.parse(id), Entity.fromJson(entity))));
  }

  Game.copy(Game from) {}

  Map<String, dynamic> toJson() => {
        'board': board.toJson(),
        'entities': entities.map((int id, Entity entity) =>
            MapEntry<String, dynamic>(id.toString(), entity.toJson())),
      };

  Game.fromProtocolGame(ProtocolGame gameState) {
    board = Board.fromPbBoard(gameState.board);

    gameState.entities.forEach((ProtocolEntity entity) {
      int newKey = (entities.lastKey() ?? 0) + 1;
      entities[newKey] = Entity.fromPbEntity(entity);
    });

    _scores = gameState.scores;
  }

  ProtocolGame toGameState() {
    ProtocolGame g = ProtocolGame();

    g.board = board.toPbBoard();
    _scores.forEach((int score) => g.scores.add(score));
    entities
        .forEach((int, Entity entity) => g.entities.add(entity.toPbEntity()));

    return g;
  }

  int scoreOf(PlayerColor player) => _scores[player.index];

  void tickEntities() {
    moveEntities();

    List<Cat> cats = List();
    entities.forEach((int i, Entity e) {
      if (e is Cat) {
        cats.add(e);
      }
    });

    SplayTreeMap<int, Entity> newEntities = SplayTreeMap();

    entities.forEach((int i, Entity e) {
      bool dead = false;
      if (e is Mouse) {
        for (Cat cat in cats) {
          if (colliding(e, cat)) {
            dead = true;

            if (onMouseEaten != null) {
              onMouseEaten(e, cat);
            }
            break;
          }
        }
      }

      if (!dead) {
        newEntities[i] = e;
      }
    });

    entities = newEntities;
  }

  void tickTiles() {
    for (int x = 0; x < Board.width; x++) {
      for (int y = 0; y < Board.height; y++) {
        board.tiles[x][y] = updateTile(x, y, board.tiles[x][y]);
      }
    }
  }

  Tile updateTile(int x, int y, Tile tile) {
    switch (tile.runtimeType) {
      case Arrow:
        Arrow arrow = tile as Arrow;

        if (arrow.expiration <= 1) {
          if (onArrowExpiry != null) {
            onArrowExpiry(arrow, x, y);
          }
        }

        return arrow.withExpiration(arrow.expiration - 1);
        break;

      case Generator:
        Generator generator = tile as Generator;
        generate(x, y, generator.direction);
        return tile;
        break;

      case Empty:
      case Pit:
      case Rocket:
      default:
        return tile;
        break;
    }
  }

  void generate(int x, int y, Direction direction) {
    if (entities.length >= 200) {
      return;
    }

    // 5 good for mouse mania
    // 2 for regular
    if (rng.nextInt(100) < 2) {
      int newKey = (entities.lastKey() ?? 0) + 1;

      if (rng.nextInt(100) < 2) {
        entities[newKey] =
            GoldenMouse(position: BoardPosition.centered(x, y, direction));
      } else {
        entities[newKey] =
            Mouse(position: BoardPosition.centered(x, y, direction));
      }
    }
  }

  Entity applyTileEffect(Entity e) {
    Tile tile = board.tiles[e.position.x][e.position.y];

    switch (tile.runtimeType) {
      case Pit:
        if (onEntityInPit != null) {
          onEntityInPit(e, e.position.x, e.position.y);
        }
        return null;
        break;

      case Rocket:
        Rocket rocket = tile as Rocket;

        if (!rocket.departed) {
          if (e is Cat) {
            _scores[rocket.player.index] -= _scores[rocket.player.index] ~/ 3;
          } else if (e is GoldenMouse) {
            _scores[rocket.player.index] += 50;
          } else if (e is SpecialMouse) {
            // TODO Handle game events
            _scores[rocket.player.index]++;
          } else if (e is Mouse) {
            _scores[rocket.player.index]++;
          }

          if (onEntityInRocket != null) {
            onEntityInRocket(e, e.position.x, e.position.y);
          }
        } else {
          if (onEntityInPit != null) {
            onEntityInPit(e, e.position.x, e.position.y);
          }
        }
        return null;
        break;

      case Arrow:
        Arrow arrow = tile as Arrow;

        if (e.position.step == BoardPosition.maxStep ~/ 2) {
          // Head-on collision with cat
          if (e is Cat &&
              (e.position.direction.index + 2) % 4 == arrow.direction.index) {
            board.tiles[e.position.x][e.position.y] = arrow.damaged();
          }

          e.position = e.position.withDirection(arrow.direction);
        }
        return e;
        break;

      default:
        return e;
        break;
    }
  }

  void moveEntities() {
    SplayTreeMap<int, Entity> newEntities = SplayTreeMap();

    entities.forEach((int i, Entity e) {
      Entity ne = applyTileEffect(e);

      if (ne != null) {
        ne.position = moveTick(ne.position, ne.moveSpeed());
        newEntities[i] = ne;
      }
    });

    entities = newEntities;
  }

  BoardPosition moveTick(BoardPosition e, int moveSpeed) {
    int x = e.x;
    int y = e.y;
    Direction front = e.direction;
    int step = e.step;
    bool trapped = false;

    if (e.step == BoardPosition.maxStep / 2) {
      Direction left = Direction.values[(front.index + 1) % 4];
      Direction back = Direction.values[(front.index + 2) % 4];
      Direction right = Direction.values[(front.index + 3) % 4];

      bool frontWall = board.hasWall(front, e.x, e.y);
      bool leftWall = board.hasWall(left, e.x, e.y);
      bool backWall = board.hasWall(back, e.x, e.y);
      bool rightWall = board.hasWall(right, e.x, e.y);

      if (!frontWall) {
      } else if (!rightWall) {
        front = right;
      } else if (!leftWall) {
        front = left;
      } else if (!backWall) {
        front = back;
      } else {
        trapped = true;
      }
    }

    if (!trapped) {
      // If the entity is trapped it shall not move

      step = step + moveSpeed; // FIXME

      if (step == BoardPosition.maxStep) {
        switch (front) {
          case Direction.Right:
            x++;
            if (x == Board.width) {
              x = 0;
            }
            break;

          case Direction.Up:
            y--;
            if (y == -1) {
              y = Board.height - 1;
            }
            break;

          case Direction.Left:
            x--;
            if (x == -1) {
              x = Board.width - 1;
            }
            break;

          case Direction.Down:
            y++;
            if (y == Board.height) {
              y = 0;
            }
            break;

          default:
            break;
        }

        step = 0;
      }
    }

    return BoardPosition(x, y, front, step);
  }

  double xBlend(Entity entity) {
    double xBlend = entity.position.x.toDouble();

    switch (entity.position.direction) {
      case Direction.Right:
        xBlend += entity.position.step / BoardPosition.maxStep;
        break;

      case Direction.Left:
        xBlend += (BoardPosition.maxStep - entity.position.step) /
            BoardPosition.maxStep;
        break;

      default:
        xBlend += 0.5;
        break;
    }

    return xBlend;
  }

  double yBlend(Entity entity) {
    double yBlend = entity.position.y.toDouble();

    switch (entity.position.direction) {
      case Direction.Up:
        yBlend += (BoardPosition.maxStep - entity.position.step) /
            BoardPosition.maxStep;
        break;

      case Direction.Down:
        yBlend += entity.position.step / BoardPosition.maxStep;
        break;

      default:
        yBlend += 0.5;
        break;
    }

    return yBlend;
  }

  bool colliding(Entity a, Entity b) {
    double axBlend = xBlend(a);
    double ayBlend = yBlend(a);

    double bxBlend = xBlend(b);
    double byBlend = yBlend(b);

    double dist = pow(axBlend - bxBlend, 2) + pow(ayBlend - byBlend, 2);

    if (dist <= 0.25) {
      return true;
    }

    return false;
  }
}
