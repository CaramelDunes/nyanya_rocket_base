import 'tile.dart';
import 'protocol/game_state.pb.dart' as protocol;

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
  static const int centerStep = maxStep ~/ 2;

  final int x;
  final int y;
  final int step; // Between 0 and maxStep
  final Direction direction;

  const BoardPosition(this.x, this.y, this.direction, this.step)
      : assert(0 <= step && step <= maxStep),
        assert(-1 <= x && x <= Board.width),
        assert(-1 <= y && y <= Board.height);

  const BoardPosition.centered(int x, int y, Direction direction)
      : this(x, y, direction, centerStep);

  BoardPosition.copy(BoardPosition e) : this(e.x, e.y, e.direction, e.step);

  BoardPosition.fromJson(Map<String, dynamic> parsedJson)
      : this.centered(parsedJson['x'], parsedJson['y'],
            Direction.values[parsedJson['direction']]);

  BoardPosition withDirection(Direction newDirection) =>
      BoardPosition(x, y, newDirection, step);

  Map<String, dynamic> toJson() =>
      {'x': x, 'y': y, 'direction': direction.index};
}

class Board {
  static const int width = 12;
  static const int height = 9;

  List<List<Tile>> tiles = List.generate(
      12, (_) => List.generate(9, (_) => Empty(), growable: false),
      growable: false);
  List<List<Wall>> walls =
      List.generate(12, (_) => List.filled(9, Wall.None), growable: false);

  Board();

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

  factory Board.fromProtocolBoard(protocol.Board board) {
    Board b = Board();

    for (int x = 0; x < Board.width; x++) {
      for (int y = 0; y < Board.height; y++) {
        b.tiles[x][y] = Tile.fromProtocolTile(board.tiles[x * height + y]);
        b.walls[x][y] = Wall.values[board.walls[x * height + y].value];
      }
    }

    return b;
  }

  protocol.Board toProtocolBoard() {
    protocol.Board b = protocol.Board();

    for (int x = 0; x < Board.width; x++) {
      for (int y = 0; y < Board.height; y++) {
        b.tiles.add(tiles[x][y].toProtocolTile());
        b.walls.add(protocol.Wall.values[walls[x][y].index]);
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

  bool hasWall(Direction direction, int x, int y) {
    // Warp tile
    if (x == -1 || x == Board.width || y == -1 || y == Board.height) {
      return false;
    }

    switch (direction) {
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

  void setWall(int x, int y, Direction direction, [bool set = true]) {
    switch (direction) {
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
}
