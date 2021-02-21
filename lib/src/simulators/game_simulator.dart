import 'dart:math';
import 'package:meta/meta.dart';

import '../board.dart';
import '../entity.dart';
import '../state/game_state.dart';
import '../tile.dart';

enum GameSpeed { Normal, Fast, Slow }

typedef MouseEatenCallback = void Function(Mouse mouse, Cat cat);
typedef EntityInPitCallback = void Function(Entity entity, int x, int y);
typedef EntityInRocketCallback = void Function(Entity entity, int x, int y);
typedef ArrowExpiredCallback = void Function(Arrow arrow, int x, int y);

abstract class GameSimulator<StateType extends GameState> {
  GameSpeed speed = GameSpeed.Normal;

  MouseEatenCallback? onMouseEaten;
  EntityInPitCallback? onEntityInPit;
  EntityInRocketCallback? onEntityInRocket;
  ArrowExpiredCallback? onArrowExpiry;

  void update(StateType gameState) {
    tick(gameState);

    switch (speed) {
      case GameSpeed.Normal:
        tick(gameState);
        break;

      case GameSpeed.Fast:
        tick(gameState);
        tick(gameState);
        tick(gameState);
        break;

      case GameSpeed.Slow:
        break;
    }
  }

  void departRockets(StateType gameState) {
    for (int x = 0; x < Board.width; x++) {
      for (int y = 0; y < Board.height; y++) {
        if (gameState.board.tiles[x][y] is Rocket) {
          gameState.board.tiles[x][y] = Rocket.departed(
              player: (gameState.board.tiles[x][y] as Rocket).player);
        }
      }
    }
  }

  @protected
  void tick(StateType gameState) {
    _tickEntities(gameState);
    _tickTiles(gameState);

    gameState.tickCount++;
  }

  void _tickEntities(StateType gameState) {
    _moveEntities(gameState);

    List<Mouse> newMice = [];

    gameState.mice.forEach((Mouse mouse) {
      bool dead = false;
      for (Cat cat in gameState.cats) {
        if (_colliding(mouse, cat)) {
          dead = true;
          onMouseEaten?.call(mouse, cat);
          break;
        }
      }

      if (!dead) {
        newMice.add(mouse);
      }
    });

    gameState.mice = newMice;
  }

  void _tickTiles(StateType gameState) {
    for (int x = 0; x < Board.width; x++) {
      for (int y = 0; y < Board.height; y++) {
        gameState.board.tiles[x][y] =
            _updateTile(x, y, gameState.board.tiles[x][y], gameState);
      }
    }
  }

  Tile _updateTile(int x, int y, Tile tile, StateType gameState) {
    switch (tile.runtimeType) {
      case Arrow:
        Arrow arrow = tile as Arrow;

        if (arrow.expiration <= 1) {
          onArrowExpiry?.call(arrow, x, y);
        }

        return arrow.withExpiration(arrow.expiration - 1);

      case Generator:
        Generator generator = tile as Generator;
        Entity? e = generate(generator.direction, x, y, gameState);

        if (e != null) {
          if (e is Cat) {
            gameState.cats.add(e);
          } else if (e is Mouse) {
            gameState.mice.add(e);
          } else {
            throw Exception(); // FIXME
          }
        }
        return tile;

      case Empty:
      case Pit:
      case Rocket:
      default:
        return tile;
    }
  }

  Entity? generate(Direction direction, int x, int y, StateType gameState);

  // TODO Generify
  Entity? applyTileEffect(Entity e, List<BoardPosition> pendingArrowDeletions,
      StateType gameState) {
    assert(e.position.step == BoardPosition.centerStep);

    // Warp tile
    if (e.position.y < 0 ||
        e.position.y == Board.height ||
        e.position.x < 0 ||
        e.position.x == Board.width) {
      return e;
    }

    Tile tile = gameState.board.tiles[e.position.x][e.position.y];

    switch (tile.runtimeType) {
      case Pit:
        onEntityInPit?.call(e, e.position.x, e.position.y);
        return null;

      case Rocket:
        Rocket rocket = tile as Rocket;

        if (!rocket.departed) {
          if (e is Cat) {
            gameState.scores[rocket.player.index] -=
                gameState.scores[rocket.player.index] ~/ 3;
          } else if (e is GoldenMouse) {
            gameState.scores[rocket.player.index] += 50;
          } else {
            // Special and Regular mice
            gameState.scores[rocket.player.index]++;
          }

          onEntityInRocket?.call(e, e.position.x, e.position.y);
        } else {
          onEntityInPit?.call(e, e.position.x, e.position.y);
        }
        return null;

      case Arrow:
        Arrow arrow = tile as Arrow;

        // Head-on collision with cat
        if (e is Cat &&
            (e.position.direction.index + 2) % 4 == arrow.direction.index) {
          switch (arrow.halfTurnPower) {
            case ArrowHalfTurnPower.ZeroCat:
              return e;

            case ArrowHalfTurnPower.OneCat:
              gameState.board.tiles[e.position.x][e.position.y] =
                  arrow.withHalfTurnPower(ArrowHalfTurnPower.ZeroCat);
              pendingArrowDeletions.add(BoardPosition.centered(
                  e.position.x, e.position.y, Direction.Right));
              break;

            case ArrowHalfTurnPower.TwoCats:
              gameState.board.tiles[e.position.x][e.position.y] =
                  arrow.withHalfTurnPower(ArrowHalfTurnPower.OneCat);
              break;
          }
        }

        e.position = e.position.withDirection(arrow.direction);
        return e;

      default:
        return e;
    }
  }

  void _moveEntities(StateType gameState) {
    List<Mouse> newMice = [];
    List<BoardPosition> pendingArrowDeletions = [];

    gameState.mice.forEach((Mouse e) {
      e.position = _moveTick(e.position, e.moveSpeed(), gameState);

      Mouse? e2 = e;
      if (e.position.step == BoardPosition.centerStep) {
        e2 = applyTileEffect(e, pendingArrowDeletions, gameState)
            as Mouse?; // FIXME
      }
      if (e2 != null) newMice.add(e2);
    });

    gameState.mice = newMice;

    List<Cat> newCats = [];

    gameState.cats.forEach((Cat e) {
      e.position = _moveTick(e.position, e.moveSpeed(), gameState);

      Cat? e2 = e;
      if (e.position.step == BoardPosition.centerStep) {
        e2 = applyTileEffect(e, pendingArrowDeletions, gameState)
            as Cat?; // FIXME
      }

      if (e2 != null) newCats.add(e2);
    });

    gameState.cats = newCats;

    pendingArrowDeletions.forEach((BoardPosition p) {
      gameState.board.tiles[p.x][p.y] = Empty();
    });
  }

  BoardPosition _moveTick(BoardPosition e, int moveSpeed, StateType gameState) {
    int x = e.x;
    int y = e.y;
    Direction front = e.direction;
    int step = e.step;
    bool trapped = false;

    if (e.step == BoardPosition.centerStep) {
      Direction left = Direction.values[(front.index + 1) % 4];
      Direction back = Direction.values[(front.index + 2) % 4];
      Direction right = Direction.values[(front.index + 3) % 4];

      bool frontWall = gameState.board.hasWall(front, e.x, e.y);
      bool leftWall = gameState.board.hasWall(left, e.x, e.y);
      bool backWall = gameState.board.hasWall(back, e.x, e.y);
      bool rightWall = gameState.board.hasWall(right, e.x, e.y);

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
        // If the entity is moving vertically it is horizontally centered on its
        // column.
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
        // If the entity is moving horizontally it is vertically centered on its
        // row.
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

    num dist = pow(axBlend - bxBlend, 2) + pow(ayBlend - byBlend, 2);

    if (dist <= 1 / 9) {
      return true;
    }

    return false;
  }
}
