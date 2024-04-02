import '../state/multiplayer_game_state.dart';
import 'generators/multiplayer_generator.dart';
import 'game_simulator.dart';

class MultiplayerGameSimulator extends GameSimulator<MultiplayerGameState>
    with MultiplayerGenerator {
  GameEvent _nextGameEvent = GameEvent.None;

  @override
  void update(MultiplayerGameState gameState) {
    if (gameState.currentEvent == GameEvent.SpeedUp) {
      speed = GameSpeed.Fast;
    } else if (gameState.currentEvent == GameEvent.SlowDown) {
      speed = GameSpeed.Slow;
    } else {
      speed = GameSpeed.Normal;
    }

    super.update(gameState);
  }

  @override
  void tick(MultiplayerGameState gameState) {
    if (gameState.pauseUntil >= gameState.tickCount) {
      gameState.tickCount++;
    } else {
      super.tick(gameState);
    }

    _nextGameEvent = GameEvent
        .values[gameState.rng.nextInt(GameEvent.values.length - 1) + 1];
  }

  void fastForward(MultiplayerGameState gameState, int howManyTicks) {
    for (int i = 0; i < howManyTicks; i++) {
      tick(gameState);
    }
  }

  GameEvent get nextGameEvent => _nextGameEvent;
}
