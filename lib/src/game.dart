import 'dart:math';

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

enum GeneratorPolicy { Regular, Challenge, MouseMania, CatMania, MouseMonopoly }

class Game {
  List<int> _scores = List.filled(4, 0, growable: false);
  Board board = Board();
  Queue<Entity> entities = Queue();
  GameEvent currentEvent = GameEvent.None;
  GeneratorPolicy generatorPolicy = GeneratorPolicy.Regular;
  Random _rng = Random();
  int _livingCats = 0;

  MouseEatenCallback onMouseEaten;
  EntityInPitCallback onEntityInPit;
  EntityInRocketCallback onEntityInRocket;
  ArrowExpiredCallback onArrowExpiry;

  Game();

  Game.fromJson(Map<String, dynamic> parsedJson) {
    board = Board.fromJson(parsedJson['board']);
    entities = Queue.from(parsedJson['entities']
        .map<Entity>((dynamic entity) => Entity.fromJson(entity)));
  }

  Map<String, dynamic> toJson() => {
        'board': board.toJson(),
        'entities': entities.map((Entity entity) => entity.toJson()).toList(),
      };

  Game.fromProtocolGame(ProtocolGame gameState) {
    board = Board.fromPbBoard(gameState.board);

    gameState.entities.forEach((ProtocolEntity entity) {
      entities.add(Entity.fromPbEntity(entity));
    });

    _scores = gameState.scores;

    currentEvent = GameEvent.values[gameState.event.value];
  }

  ProtocolGame toGameState() {
    ProtocolGame g = ProtocolGame();

    g.board = board.toPbBoard();
    _scores.forEach((int score) => g.scores.add(score));
    entities.forEach((Entity entity) => g.entities.add(entity.toPbEntity()));

    g.event = ProtocolGameEvent.values[currentEvent.index];

    return g;
  }

  int scoreOf(PlayerColor player) => _scores[player.index];

  void tick() {
    _tickEntities();
    _tickTiles();
  }

  void _tickEntities() {
    _moveEntities();

    Queue<Cat> cats = Queue();
    entities.forEach((Entity e) {
      if (e is Cat) {
        cats.add(e);
      }
    });

    Queue<Entity> newEntities = Queue();

    entities.forEach((Entity e) {
      bool dead = false;
      if (e is Mouse) {
        for (Cat cat in cats) {
          if (_colliding(e, cat)) {
            dead = true;

            if (onMouseEaten != null) {
              onMouseEaten(e, cat);
            }

            break;
          }
        }
      }

      if (!dead) {
        newEntities.add(e);
      }
    });

    entities = newEntities;
  }

  void _tickTiles() {
    for (int x = 0; x < Board.width; x++) {
      for (int y = 0; y < Board.height; y++) {
        board.tiles[x][y] = _updateTile(x, y, board.tiles[x][y]);
      }
    }
  }

  Tile _updateTile(int x, int y, Tile tile) {
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
        Entity e = _generate(generator.direction, x, y);

        if (e != null) {
          entities.add(e);
        }
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

  Entity _generate(Direction direction, int x, int y) {
    if (entities.length >= 150) {
      return null;
    }

    BoardPosition position = BoardPosition.centered(x, y, direction);

    switch (generatorPolicy) {
      case GeneratorPolicy.Regular:
        if (_rng.nextInt(100) < 2) {
          if (_livingCats <= 0) {
            _livingCats++;
            return Cat(position: position);
          }

          if (_rng.nextInt(100) == 1) {
            return GoldenMouse(position: position);
          } else if (_rng.nextInt(100) == 2) {
            return SpecialMouse(position: position);
          } else {
            return Mouse(position: position);
          }
        }
        break;

      case GeneratorPolicy.MouseMania:
        if (_rng.nextInt(100) < 5) {
          if (_rng.nextInt(100) < 1) {
            return GoldenMouse(position: position);
          } else {
            return Mouse(position: position);
          }
        }
        break;

      case GeneratorPolicy.CatMania:
        if (_rng.nextInt(100) < 2) {
          if (_livingCats < 4) {
            _livingCats++;
            return Cat(position: position);
          }
        }
        break;

      case GeneratorPolicy.Challenge:
        if (_rng.nextInt(100) < 2) {
          if (_livingCats <= 0) {
            _livingCats++;
            return Cat(position: position);
          }

          return Mouse(position: position);
        }
        break;

      default:
        break;
    }

    return null;
  }

  Entity _applyTileEffect(Entity e) {
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
          } else {
            // Special and Regular mice
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

  void _moveEntities() {
    Queue<Entity> newEntities = Queue();

    entities.forEach((Entity e) {
      Entity ne = _applyTileEffect(e);

      if (ne != null) {
        ne.position = _moveTick(ne.position, ne.moveSpeed());
        newEntities.add(ne);
      } else if (e is Cat) {
        _livingCats--;
      }
    });

    entities = newEntities;
  }

  BoardPosition _moveTick(BoardPosition e, int moveSpeed) {
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

  double _xBlend(Entity entity) {
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

  double _yBlend(Entity entity) {
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

  bool _colliding(Entity a, Entity b) {
    double axBlend = _xBlend(a);
    double ayBlend = _yBlend(a);

    double bxBlend = _xBlend(b);
    double byBlend = _yBlend(b);

    double dist = pow(axBlend - bxBlend, 2) + pow(ayBlend - byBlend, 2);

    if (dist <= 0.25) {
      return true;
    }

    return false;
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    return false;
  }
}
