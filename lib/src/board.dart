import 'package:nyanya_rocket_base/src/tile.dart';

enum Direction {
  Right,
  Up,
  Left,
  Down,
}

enum GameEvent {
  MouseMania,
  CatMania,
  SpeedUp,
  SlowDown,
  PlaceAgain,
  CatAttack,
  MouseMonopoly,
}

enum Wall {
  None,
  Right,
  Down,
  RightDown,
}

class Board {
  static const int width = 12;
  static const int height = 9;

  List<List<Tile>> tiles = List();

  final List<Wall> walls =
      List(width * height + width + height); // TODO Better representation

  Board() {
    for (int i = 0; i < width; i++) {
      tiles.add(List());

      for (int j = 0; j < height; j++) {
        tiles.last.add(Empty());
      }
    }

    for (int i = 0; i < walls.length; i++) {
      walls[i] = Wall.None;
    }
  }

  Board.copy(Board b) {
    Board();

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        tiles[i][j] = b.tiles[i][j];
      }
    }

    for (int i = 0; i < walls.length; i++) {
      walls[i] = b.walls[i];
    }
  }

  bool hasLeftWall(int x, int y) {
    return walls[y * width + x - 1].index & Wall.Right.index > 0;
  }

  bool hasRightWall(int x, int y) {
    return walls[y * width + x].index & Wall.Right.index > 0;
  }

  bool hasDownWall(int x, int y) {
    return walls[y * width + x].index & Wall.Down.index > 0;
  }

  bool hasUpWall(int x, int y) {
    return walls[(y - 1) * width + x].index & Wall.Down.index > 0;
  }

  bool hasWall(Direction dir, int x, int y) {
    switch (dir) {
      case Direction.Right:
        return hasRightWall(x, y);
        break;
      case Direction.Up:
        return hasRightWall(x, y);
        break;

      case Direction.Left:
        return hasRightWall(x, y);
        break;

      case Direction.Down:
        return hasRightWall(x, y);
        break;

      default:
        return false;
        break;
    }
  }
}
