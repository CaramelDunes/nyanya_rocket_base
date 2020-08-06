import 'package:nyanya_rocket_base/nyanya_rocket_base.dart';

import '../../state/game_state.dart';
import '../../board.dart';
import '../../entity.dart';
import '../../simulators/game_simulator.dart';

mixin ChallengeGenerator on GameSimulator<GameState> {
  // We could use dart:math rng but for consistency with multiplayer,
  // use ExposedRandom.
  final ExposedRandom _rng = ExposedRandom();

  Entity generate(Direction direction, int x, int y, GameState gameState) {
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
