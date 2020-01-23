import 'dart:collection';
import 'dart:math';

import 'package:nyanya_rocket_base/src/board.dart';
import 'package:nyanya_rocket_base/src/entity.dart';
import 'package:nyanya_rocket_base/src/protocol/game_state.pb.dart' as protocol;

import 'package:nyanya_rocket_base/src/tile.dart';
import 'package:nyanya_rocket_base/src/xor_shift.dart';

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
  Challenge,
  MouseMania,
  CatMania,
  MouseMonopoly,
  None,
}

class Game {
  List<int> _scores = List.filled(4, 0, growable: false);
  Board board = Board();
  Queue<Cat> cats = Queue();
  Queue<Mouse> mice = Queue();
  GameEvent currentEvent = GameEvent.None;
  GeneratorPolicy generatorPolicy = GeneratorPolicy.Regular;
  XorShiftState _xorShiftState = XorShiftState.random();
  int _tickCount = 0;

  MouseEatenCallback onMouseEaten;
  EntityInPitCallback onEntityInPit;
  EntityInRocketCallback onEntityInRocket;
  ArrowExpiredCallback onArrowExpiry;

  Game();

  Game.fromJson(Map<String, dynamic> parsedJson) {
    board = Board.fromJson(parsedJson['board']);
    Queue<Entity> entities = Queue.from(parsedJson['entities']
        .map<Entity>((dynamic entity) => Entity.fromJson(entity)));

    entities.forEach((Entity e) {
      if (e is Cat) {
        cats.add(e);
      } else {
        mice.add(e);
      }
    });
  }

  Map<String, dynamic> toJson() => {
        'board': board.toJson(),
        'entities': (cats).map((Entity entity) => entity.toJson()).toList() +
            (mice).map((Entity entity) => entity.toJson()).toList(),
      };

  Game.fromProtocolGame(protocol.Game gameState) {
    board = Board.fromPbBoard(gameState.board);

    gameState.cats.forEach((protocol.Entity entity) {
      cats.add(Entity.fromPbEntity(entity));
    });

    gameState.mice.forEach((protocol.Entity entity) {
      mice.add(Entity.fromPbEntity(entity));
    });

    _scores = gameState.scores;

    currentEvent = GameEvent.values[gameState.event.value];
    _tickCount = gameState.timestamp;
    _xorShiftState.a = gameState.randomState.a;
    _xorShiftState.b = gameState.randomState.b;
    _xorShiftState.c = gameState.randomState.c;
    _xorShiftState.d = gameState.randomState.d;
  }

  protocol.Game toGameState() {
    protocol.Game g = protocol.Game();

    g.board = board.toPbBoard();
    _scores.forEach((int score) => g.scores.add(score));
    cats.forEach((Cat cat) => g.cats.add(cat.toPbEntity()));
    mice.forEach((Mouse mouse) => g.mice.add(mouse.toPbEntity()));

    g.event = protocol.GameEvent.values[currentEvent.index];

    g.timestamp = _tickCount;

    g.randomState = protocol.XorShiftState();
    g.randomState.a = _xorShiftState.a;
    g.randomState.b = _xorShiftState.b;
    g.randomState.c = _xorShiftState.c;
    g.randomState.d = _xorShiftState.d;

    return g;
  }

  int scoreOf(PlayerColor player) => _scores[player.index];

  int get tickCount => _tickCount;

  void tick() {
    _tickEntities();
    _tickTiles();

    _tickCount++;
  }

  void _tickEntities() {
    _moveEntities();

    Queue<Mouse> newMice = Queue();

    mice.forEach((Mouse mouse) {
      bool dead = false;
      for (Cat cat in cats) {
        if (_colliding(mouse, cat)) {
          dead = true;

          if (onMouseEaten != null) {
            onMouseEaten(mouse, cat);
          }

          break;
        }
      }

      if (!dead) {
        newMice.add(mouse);
      }
    });

    mice = newMice;
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
          if (e is Cat) {
            cats.add(e);
          } else {
            mice.add(e);
          }
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
    if (mice.length + cats.length >= 108) {
      return null;
    }

    BoardPosition position = BoardPosition.centered(x, y, direction);

    switch (generatorPolicy) {
      case GeneratorPolicy.Regular:
        if (nextXorShiftInt(_xorShiftState, 1000) < 20) {
          if (cats.isEmpty) {
            return Cat(position: position);
          }

          if (nextXorShiftInt(_xorShiftState, 1000) >= 20) {
            return Mouse(position: position);
          } else if (nextXorShiftInt(_xorShiftState, 1000) >= 10) {
            return GoldenMouse(position: position);
          } else {
            return SpecialMouse(position: position);
          }
        }
        break;

      case GeneratorPolicy.MouseMania:
        if (nextXorShiftInt(_xorShiftState, 100) < 5) {
          if (nextXorShiftInt(_xorShiftState, 100) < 1) {
            return GoldenMouse(position: position);
          } else {
            return Mouse(position: position);
          }
        }
        break;

      case GeneratorPolicy.CatMania:
        if (nextXorShiftInt(_xorShiftState, 100) < 2) {
          if (cats.length < 4) {
            return Cat(position: position);
          }
        }
        break;

      case GeneratorPolicy.Challenge:
        if (nextXorShiftInt(_xorShiftState, 100) < 2) {
          if (cats.isEmpty) {
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

  Entity _applyTileEffect(Entity e, List<BoardPosition> pendingArrowDeletions) {
    // Warp tile
    if (e.position.y < 0 ||
        e.position.y == Board.height ||
        e.position.x < 0 ||
        e.position.x == Board.width) {
      return e;
    }

    Tile tile = board.tiles[e.position.x][e.position.y];

    switch (tile.runtimeType) {
      case Pit:
        if (onEntityInPit != null) {
          onEntityInPit(e, e.position.x, e.position.y);
        }
        return null;
        break;

      case Rocket:
        if (e.position.step != BoardPosition.centerStep) return e;
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

        if (e.position.step == BoardPosition.centerStep) {
          // Head-on collision with cat
          if (e is Cat &&
              (e.position.direction.index + 2) % 4 == arrow.direction.index) {
            switch (arrow.halfTurnPower) {
              case ArrowHalfTurnPower.ZeroCat:
                return e;
                break;

              case ArrowHalfTurnPower.OneCat:
                board.tiles[e.position.x][e.position.y] =
                    arrow.withHalfTurnPower(ArrowHalfTurnPower.ZeroCat);
                pendingArrowDeletions.add(BoardPosition.centered(
                    e.position.x, e.position.y, Direction.Right));
                break;

              case ArrowHalfTurnPower.TwoCats:
                board.tiles[e.position.x][e.position.y] =
                    arrow.withHalfTurnPower(ArrowHalfTurnPower.OneCat);
                break;
            }
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
    Queue<Mouse> newMice = Queue();
    List<BoardPosition> pendingArrowDeletions = List();

    mice.forEach((Mouse e) {
      Entity ne = _applyTileEffect(e, pendingArrowDeletions);

      if (ne != null) {
        ne.position = _moveTick(ne.position, ne.moveSpeed());
        newMice.add(ne);
      }
    });

    mice = newMice;

    Queue<Cat> newCats = Queue();

    cats.forEach((Cat e) {
      Entity ne = _applyTileEffect(e, pendingArrowDeletions);

      if (ne != null) {
        ne.position = _moveTick(ne.position, ne.moveSpeed());
        newCats.add(ne);
      }
    });

    cats = newCats;

    pendingArrowDeletions.forEach((BoardPosition p) {
      board.tiles[p.x][p.y] = Empty();
    });
  }

  BoardPosition _moveTick(BoardPosition e, int moveSpeed) {
    int x = e.x;
    int y = e.y;
    Direction front = e.direction;
    int step = e.step;
    bool trapped = false;

    if (e.step == BoardPosition.centerStep) {
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

    // If the entity is trapped it shall not move
    if (!trapped) {
      step += moveSpeed;

      if (step == BoardPosition.maxStep) {
        switch (front) {
          case Direction.Right:
            x++;
            if (x == Board.width) {
              x = -1;
            }
            break;

          case Direction.Up:
            y--;
            if (y == -1) {
              y = Board.height;
            }
            break;

          case Direction.Left:
            x--;
            if (x == -1) {
              x = Board.width;
            }
            break;

          case Direction.Down:
            y++;
            if (y == Board.height) {
              y = -1;
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

    if (dist <= 1 / 9) {
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
