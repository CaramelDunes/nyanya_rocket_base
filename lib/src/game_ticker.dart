import 'dart:async';

import 'package:meta/meta.dart';

import 'board.dart';
import 'entity.dart';
import 'simulators/game_simulator.dart';
import 'state/game_state.dart';
import 'tile.dart';

class GameTicker<T extends GameState> {
  static const Duration tickPeriod = Duration(milliseconds: 16);

  T _game;
  final GameSimulator gameSimulator;

  Timer _timer;

  bool running = false;

  GameTicker(this._game, this.gameSimulator) {
    _timer = Timer.periodic(tickPeriod, _tick);

    gameSimulator.onMouseEaten = onMouseEaten;
    gameSimulator.onEntityInPit = onEntityInPit;
    gameSimulator.onEntityInRocket = onEntityInRocket;
    gameSimulator.onArrowExpiry = onArrowExpiry;
  }

  static int durationInTicks(Duration duration) {
    return (duration.inMilliseconds / tickPeriod.inMilliseconds).floor();
  }

  T get game => _game;

  set gameState(T g) {
    _game = g;
  }

  @protected
  void beforeTick() {}

  @protected
  void afterTick() {}

  void _tick(Timer _) {
    if (running) {
      beforeTick();

      gameSimulator.tick(_game);

      afterTick();
    }
  }

  void departRockets() {
    for (int x = 0; x < Board.width; x++) {
      for (int y = 0; y < Board.height; y++) {
        if (game.board.tiles[x][y] is Rocket) {
          game.board.tiles[x][y] = Rocket.departed(
              player: (game.board.tiles[x][y] as Rocket).player);
        }
      }
    }
  }

  @mustCallSuper
  void close() {
    _timer.cancel();
  }

  @protected
  void onMouseEaten(Mouse mouse, Cat cat) {}

  @protected
  void onEntityInPit(Entity entity, int x, int y) {}

  @protected
  void onEntityInRocket(Entity entity, int x, int y) {}

  @protected
  void onArrowExpiry(Arrow arrow, int x, int y) {}
}
