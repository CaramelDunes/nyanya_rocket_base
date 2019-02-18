import 'package:nyanya_rocket_base/src/tile.dart';
import 'package:nyanya_rocket_base/src/protocol/game_server.pb.dart';

enum Direction {
  Right,
  Up,
  Left,
  Down,
}

enum Wall {
  None,
  Left,
  Up,
  LeftUp,
}

class BoardPosition {
  static const int maxStep = 60;
  static const int center = maxStep ~/ 2;

  final int x;
  final int y;
  final int step; // Between 0 and maxStep
  final Direction direction;

  const BoardPosition(this.x, this.y, this.direction, this.step);
  const BoardPosition.centered(this.x, this.y, this.direction) : step = center;
  const BoardPosition.entering(this.x, this.y, this.direction) : step = 0;

  BoardPosition.copy(BoardPosition e)
      : x = e.x,
        y = e.y,
        step = e.step,
        direction = e.direction;

  BoardPosition withDirection(Direction newDirection) =>
      BoardPosition(x, y, newDirection, step);

  BoardPosition.fromJson(Map<String, dynamic> parsedJson)
      : x = parsedJson['x'],
        y = parsedJson['y'],
        step = parsedJson['step'],
        direction = Direction.values[parsedJson['direction']];

  Map<String, dynamic> toJson() =>
      {'x': x, 'y': y, 'step': step, 'direction': direction.index};
}

class Board {
  static const int width = 12;
  static const int height = 9;

  List<List<Tile>> tiles = List();
  List<List<Wall>> walls = List();

  Board() {
    for (int i = 0; i < width; i++) {
      tiles.add(List());
      walls.add(List());

      for (int j = 0; j < height; j++) {
        tiles.last.add(Empty());
        walls.last.add(Wall.None);
      }
    }
  }

  factory Board.copy(Board b) {
    Board board = Board();
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        board.tiles[i][j] = b.tiles[i][j];
        board.walls[i][j] = b.walls[i][j];
      }
    }

    return board;
  }

  factory Board.withBorder() {
    Board board = Board();

    for (int x = 0; x < width; x++) {
      board.setUpWall(x, 0);
    }

    for (int y = 0; y < height; y++) {
      board.setLeftWall(0, y);
    }

    return board;
  }

  factory Board.fromJson(Map<String, dynamic> parsedJson) {
    Board b = Board();

    b.tiles = parsedJson['tiles']
        .map<List<Tile>>((dynamic column) => (column as List<dynamic>)
            .map<Tile>((dynamic tile) => Tile.fromJson(tile))
            .toList())
        .toList();
    b.walls = parsedJson['walls']
        .map<List<Wall>>((dynamic column) => (column as List<dynamic>)
            .map<Wall>((dynamic wall) => Wall.values[wall])
            .toList())
        .toList();

    return b;
  }

  Map<String, dynamic> toJson() {
    return {
      'tiles': tiles
          .map((List<Tile> column) =>
              column.map((Tile tile) => tile.toJson()).toList())
          .toList(),
      'walls': walls
          .map((List<Wall> column) =>
              column.map((Wall wall) => wall.index).toList())
          .toList(),
    };
  }

  factory Board.fromPbBoard(ProtocolBoard board) {
    Board b = Board();

    for (int x = 0; x < Board.width; x++) {
      for (int y = 0; y < Board.height; y++) {
        b.tiles[x][y] = Tile.fromPbTile(board.tiles[x * height + y]);
        b.walls[x][y] = Wall.values[board.walls[x * height + y].value];
      }
    }

    return b;
  }

  ProtocolBoard toPbBoard() {
    ProtocolBoard b = ProtocolBoard();

    for (int x = 0; x < Board.width; x++) {
      for (int y = 0; y < Board.height; y++) {
        b.tiles.add(tiles[x][y].toPbTile());
        b.walls.add(ProtocolWall.values[walls[x][y].index]);
      }
    }

    return b;
  }

  bool hasLeftWall(int x, int y) {
    return walls[x][y].index & Wall.Left.index > 0;
  }

  bool hasRightWall(int x, int y) {
    return walls[(x + 1) % width][y].index & Wall.Left.index > 0;
  }

  bool hasDownWall(int x, int y) {
    return walls[x][(y + 1) % height].index & Wall.Up.index > 0;
  }

  bool hasUpWall(int x, int y) {
    return walls[x][y].index & Wall.Up.index > 0;
  }

  void setLeftWall(int x, int y, [bool set = true]) {
    if (set) {
      walls[x][y] = Wall.values[walls[x][y].index | Wall.Left.index];
    } else {
      walls[x][y] = Wall.values[walls[x][y].index & Wall.Up.index];
    }
  }

  void setRightWall(int x, int y, [bool set = true]) {
    if (set) {
      walls[(x + 1) % width][y] =
          Wall.values[walls[(x + 1) % width][y].index | Wall.Left.index];
    } else {
      walls[(x + 1) % width][y] =
          Wall.values[walls[(x + 1) % width][y].index & Wall.Up.index];
    }
  }

  void setDownWall(int x, int y, [bool set = true]) {
    if (set) {
      walls[x][(y + 1) % height] =
          Wall.values[walls[x][(y + 1) % height].index | Wall.Up.index];
    } else {
      walls[x][(y + 1) % height] =
          Wall.values[walls[x][(y + 1) % height].index & Wall.Left.index];
    }
  }

  void setUpWall(int x, int y, [bool set = true]) {
    if (set) {
      walls[x][y] = Wall.values[walls[x][y].index | Wall.Up.index];
    } else {
      walls[x][y] = Wall.values[walls[x][y].index & Wall.Left.index];
    }
  }

  bool hasWall(Direction dir, int x, int y) {
    switch (dir) {
      case Direction.Right:
        return hasRightWall(x, y);
        break;

      case Direction.Up:
        return hasUpWall(x, y);
        break;

      case Direction.Left:
        return hasLeftWall(x, y);
        break;

      case Direction.Down:
        return hasDownWall(x, y);
        break;

      default:
        return false;
        break;
    }
  }

  void setWall(int x, int y, Direction dir, [bool set = true]) {
    switch (dir) {
      case Direction.Right:
        setRightWall(x, y, set);
        break;

      case Direction.Up:
        setUpWall(x, y, set);
        break;

      case Direction.Left:
        setLeftWall(x, y, set);
        break;

      case Direction.Down:
        setDownWall(x, y, set);
        break;

      default:
        break;
    }
  }

  void removeWalls(int x, int y) {
    walls[x][y] = Wall.None;
    setRightWall(x, y, false);
    setDownWall(x, y, false);
  }
}
