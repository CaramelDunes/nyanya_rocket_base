import 'dart:async';

import 'package:meta/meta.dart';

import 'board.dart';
import 'entity.dart';
import 'simulators/game_simulator.dart';
import 'state/game_state.dart';
import 'tile.dart';

enum GameSpeed { Normal, Fast, Slow }

class GameTicker<T extends GameState> {
  static const Duration tickPeriod = Duration(milliseconds: 16);

  T _game;
  final GameSimulator gameSimulator;

  Timer _timer;

  bool running = false;
  GameSpeed speed = GameSpeed.Normal;

  Duration _pauseDuration = Duration.zero;

  GameTicker(this._game, this.gameSimulator) {
    _timer = Timer.periodic(tickPeriod, _tick);

    gameSimulator.onMouseEaten = onMouseEaten;
    gameSimulator.onEntityInPit = onEntityInPit;
    gameSimulator.onEntityInRocket = onEntityInRocket;
    gameSimulator.onArrowExpiry = onArrowExpiry;
  }

  T get game => _game;

  void pauseFor(Duration duration) {
    _pauseDuration = duration;
  }

  bool get paused => _pauseDuration > Duration.zero;

  set gameState(T g) {
    _game = g;
  }

  @protected
  void beforeTick() {}

  @protected
  void afterTick() {}

  void _tick(Timer timer) {
    if (_pauseDuration > Duration.zero) {
      _pauseDuration -= tickPeriod;
      return;
    }

    if (running) {
      beforeTick();

      _game.tick();

      switch (speed) {
        case GameSpeed.Normal:
          gameSimulator.tick(_game);
          break;

        case GameSpeed.Fast:
          gameSimulator.tick(_game);
          gameSimulator.tick(_game);
          gameSimulator.tick(_game);
          break;

        case GameSpeed.Slow:
          break;
      }

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
