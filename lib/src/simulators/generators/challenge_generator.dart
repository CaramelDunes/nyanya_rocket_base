import '../../state/game_state.dart';
import '../../board.dart';
import '../../entity.dart';
import '../../simulators/game_simulator.dart';
import '../../xor_shift.dart';

mixin ChallengeGenerator on GameSimulator<GameState> {
  // We could use dart:math rng but for consistency with multiplayer,
  // use XorShift.
  XorShiftState _rngState = XorShiftState.random();

  Entity generate(Direction direction, int x, int y, GameState gameState) {
    // TODO: Move condition to GameSimulator
    if (gameState.mice.length + gameState.cats.length >= 108) {
      return null;
    }

    BoardPosition position = BoardPosition.centered(x, y, direction);

    if (_rngState.nextInt(100) < 2) {
      if (gameState.cats.isEmpty) {
        return Cat(position: position);
      }

      return Mouse(position: position);
    }

    return null;
  }
}
