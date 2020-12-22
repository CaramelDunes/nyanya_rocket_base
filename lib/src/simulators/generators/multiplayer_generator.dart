import '../../state/multiplayer_game_state.dart';
import '../../board.dart';
import '../../entity.dart';
import '../../simulators/game_simulator.dart';

mixin MultiplayerGenerator on GameSimulator<MultiplayerGameState> {
  @override
  Entity? generate(
      Direction direction, int x, int y, MultiplayerGameState gameState) {
    double firstRandomDouble = gameState.rng.nextDouble();
    double secondRandomDouble = gameState.rng.nextDouble();

    if (gameState.mice.length + gameState.cats.length >= 108) {
      return null;
    }

    BoardPosition position = BoardPosition.centered(x, y, direction);

    switch (gameState.currentEvent) {
      case GameEvent.MouseMania:
        if (firstRandomDouble <= 0.05) {
          if (secondRandomDouble <= 0.01) {
            return GoldenMouse(position: position);
          } else {
            return Mouse(position: position);
          }
        }
        break;

      case GameEvent.CatMania:
        if (firstRandomDouble <= 0.02) {
          if (gameState.cats.length < 4) {
            return Cat(position: position);
          }
        }
        break;

      case GameEvent.None:
      default:
        if (firstRandomDouble <= 0.015) {
          if (gameState.cats.isEmpty) {
            return Cat(position: position);
          }

          if (secondRandomDouble <= 0.01) {
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
