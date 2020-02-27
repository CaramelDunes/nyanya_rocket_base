import '../../state/multiplayer_game_state.dart';
import '../../board.dart';
import '../../entity.dart';
import '../../simulators/game_simulator.dart';

mixin MultiplayerGenerator on GameSimulator<MultiplayerGameState> {
  @override
  Entity generate(
      Direction direction, int x, int y, MultiplayerGameState gameState) {
    if (gameState.mice.length + gameState.cats.length >= 108) {
      return null;
    }

    BoardPosition position = BoardPosition.centered(x, y, direction);

    switch (gameState.currentEvent) {
      case GameEvent.MouseMania:
        if (gameState.rng.nextDouble() <= 0.05) {
          if (gameState.rng.nextDouble() <= 0.01) {
            return GoldenMouse(position: position);
          } else {
            return Mouse(position: position);
          }
        }
        break;

      case GameEvent.CatMania:
        if (gameState.rng.nextDouble() <= 0.02) {
          if (gameState.cats.length < 4) {
            return Cat(position: position);
          }
        }
        break;

      case GameEvent.None:
      default:
        if (gameState.rng.nextDouble() <= 0.015) {
          if (gameState.cats.isEmpty) {
            return Cat(position: position);
          }

          if (gameState.rng.nextDouble() <= 0.01) {
            if (gameState.mice
                    .indexWhere((element) => element is SpecialMouse) !=
                -1) {
              return GoldenMouse(position: position);
            } else {
              return SpecialMouse(position: position);
            }
          } else {
            return Mouse(position: position);
          }
        }
        break;
    }

    return null;
  }
}
