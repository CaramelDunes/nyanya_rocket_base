import '../../board.dart';
import '../../entity.dart';
import '../game_simulator.dart';
import '../../state/game_state.dart';

mixin PuzzleGenerator on GameSimulator<GameState> {
  @override
  Entity generate(Direction direction, int x, int y, GameState gameState) {
    return null;
  }
}
