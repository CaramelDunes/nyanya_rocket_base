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
      case GameEvent.None:
        if (gameState.nextXorShiftInt(1000) < 20) {
          if (gameState.cats.isEmpty) {
            return Cat(position: position);
          }

          if (gameState.nextXorShiftInt(1000) >= 20) {
            return Mouse(position: position);
          } else if (gameState.nextXorShiftInt(1000) >= 10) {
            return GoldenMouse(position: position);
          } else {
            return SpecialMouse(position: position);
          }
        }
        break;

      case GameEvent.MouseMania:
        if (gameState.nextXorShiftInt(1000) < 50) {
          if (gameState.nextXorShiftInt(1000) < 10) {
            return GoldenMouse(position: position);
          } else {
            return Mouse(position: position);
          }
        }
        break;

      case GameEvent.CatMania:
        if (gameState.nextXorShiftInt(1000) < 20) {
          if (gameState.cats.length < 4) {
            return Cat(position: position);
          }
        }
        break;

      default:
        break;
    }

    return null;
  }
}
