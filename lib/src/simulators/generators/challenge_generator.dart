import 'dart:math';

import '../../state/game_state.dart';
import '../../board.dart';
import '../../entity.dart';
import '../../simulators/game_simulator.dart';

mixin ChallengeGenerator on GameSimulator<GameState> {
  // We could use ExposedRandom for consistency with multiplayer but use Random
  // for web support.
  final Random _rng = Random();

  Entity? generate(Direction direction, int x, int y, GameState gameState) {
    // TODO: Maybe move condition to GameSimulator (see MultiplayerGenerator)
    if (gameState.mice.length >= 100) {
      return null;
    }

    BoardPosition position = BoardPosition.centered(x, y, direction);

    if (_rng.nextDouble() <= 0.0375) {
      if (gameState.cats.isEmpty) {
        return Cat(position: position);
      }

      return Mouse(position: position);
    }

    return null;
  }
}
