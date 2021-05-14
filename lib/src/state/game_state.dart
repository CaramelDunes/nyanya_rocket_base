import '../board.dart';
import '../entity.dart';
import '../tile.dart';

class GameState {
  int tickCount = 0;
  List<int> scores = List.filled(4, 0, growable: false);
  Board board = Board();
  List<Cat> cats = [];
  List<Mouse> mice = [];

  GameState();

  GameState.fromJson(Map<String, dynamic> parsedJson) {
    board = Board.fromJson(parsedJson['board']);
    List<Entity> entities = List.from(parsedJson['entities']
        .map<Entity>((dynamic entity) => Entity.fromJson(entity)));

    entities.forEach((Entity e) {
      if (e is Cat) {
        cats.add(e);
      } else if (e is Mouse) {
        mice.add(e);
      } else {
        // TODO
      }
    });
  }

  GameState copy() {
    return GameState()
      ..tickCount = tickCount
      ..scores = List.of(scores)
      ..board = Board.copy(board)
      ..mice = List.of(mice.map((mouse) => mouse.copy()))
      ..cats = List.of(cats.map((cat) => cat.copy()));
  }

  Map<String, dynamic> toJson() => {
        'board': board.toJson(),
        'entities': (cats).map((Entity entity) => entity.toJson()).toList() +
            (mice).map((Entity entity) => entity.toJson()).toList(),
      };

  int scoreOf(PlayerColor playerColor) {
    return scores[playerColor.index];
  }

  @override
  bool operator ==(dynamic other) {
    if (runtimeType != other.runtimeType) return false;
    return false;
  }
}
