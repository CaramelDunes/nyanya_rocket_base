import 'package:nyanya_rocket_base/nyanya_rocket_base.dart';

import '../state/multiplayer_game_state.dart';
import 'generators/multiplayer_generator.dart';
import 'game_simulator.dart';

class MultiplayerGameSimulator extends GameSimulator<MultiplayerGameState>
    with MultiplayerGenerator {
  @override
  void tick(MultiplayerGameState gameState) {
    if (gameState.pauseTicks <= 0) {
      if (gameState.currentEvent == GameEvent.SpeedUp) {
        speed = GameSpeed.Fast;
      } else if (gameState.currentEvent == GameEvent.SlowDown) {
        speed = GameSpeed.Slow;
      } else {
        speed = GameSpeed.Normal;
      }

      super.tick(gameState);
    } else {
      gameState.tickCount++;
      gameState.tickCount++;

      gameState.pauseTicks--;
    }
  }
}
