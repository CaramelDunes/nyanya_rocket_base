import 'dart:collection';

import 'package:nyanya_rocket_base/src/board.dart';
import 'package:nyanya_rocket_base/src/entity.dart';
import 'package:nyanya_rocket_base/src/tile.dart';

class Game {
  List<int> score = List(4);
  Board board = Board();
  HashMap<int, Entity> entities = HashMap();

  Game() {
    score[PlayerColor.Blue.index] = 0;
    score[PlayerColor.Yellow.index] = 0;
    score[PlayerColor.Red.index] = 0;
    score[PlayerColor.Green.index] = 0;
  }

  int scoreOf(PlayerColor player) => score[player.index];

  void tickEntities() {
    moveEntities();
  }

  Entity applyTileEffect(Entity e) {
    Tile tile = board.tiles[e.movement.x][e.movement.y];

    switch (tile.runtimeType) {
      case Pit:
        return null;
        break;

      case Rocket:
        Rocket rocket = tile as Rocket;

        if (!rocket.departed) {
          if (e is Cat) {
            score[rocket.player.index] -= score[rocket.player.index] ~/ 3;
          } else if (e is GoldenMouse) {
            score[rocket.player.index] += 50;
          } else if (e is SpecialMouse) {
            // TODO Handle game events
            score[rocket.player.index]++;
          } else if (e is Mouse) {
            score[rocket.player.index]++;
          }
        } else // Equivalent to a Pit
        {
          return null;
        }
        break;

      case Arrow:
        Arrow arrow = tile as Arrow;

        if (e.movement.step == EntityMovement.maxStep ~/ 2) {
          // Head-on collision with cat
          if (e is Cat &&
              (e.movement.direction.index + 2) % 4 == arrow.direction.index) {
            board.tiles[e.movement.x][e.movement.y] = arrow.damaged();
          }

          e.movement = e.movement.withDirection(arrow.direction);
        }
        break;
    }
  }

  void moveEntities() {
    entities.forEach((int i, Entity e) {
      entities[i].movement = moveTick(e.movement, (e is Cat ? 2 : 3));
    });
  }

  EntityMovement moveTick(EntityMovement e, int moveSpeed) {
    int x = e.x;
    int y = e.y;
    Direction front = e.direction;
    int step = e.step;
    bool trapped = false;

    if (e.step == EntityMovement.maxStep / 2) {
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

      if (step == EntityMovement.maxStep) {
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

    return EntityMovement(x, y, front, step);
  }
}
