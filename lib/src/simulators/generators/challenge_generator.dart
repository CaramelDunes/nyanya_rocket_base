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
    // TODO: Maybe move condition to GameSimulator (see MultiplayerGenerator)
    if (gameState.mice.length >= 100) {
      return null;
    }

    BoardPosition position = BoardPosition.centered(x, y, direction);

    if (_rngState.nextInt(1000) <= 38) {
      if (gameState.cats.isEmpty) {
        return Cat(position: position);
      }

      return Mouse(position: position);
    }

    return null;
  }
}
