import 'dart:async';

import 'package:meta/meta.dart';

import 'entity.dart';
import 'simulators/game_simulator.dart';
import 'state/game_state.dart';
import 'tile.dart';

class GameTicker<T extends GameState> {
  static const Duration updatePeriod = Duration(microseconds: 16667);
  static const int updateFrequency = 60;

  static const Duration _clockPeriod = Duration(microseconds: 8334);

  T _game;
  final GameSimulator gameSimulator;

  late Timer _updateTimer;
  DateTime _previousClock = DateTime.now();
  Duration _timeAccumulator = Duration.zero;

  bool running = false;

  GameTicker(this._game, this.gameSimulator) {
    gameSimulator.onMouseEaten = onMouseEaten;
    gameSimulator.onEntityInPit = onEntityInPit;
    gameSimulator.onEntityInRocket = onEntityInRocket;
    gameSimulator.onArrowExpiry = onArrowExpiry;

    _updateTimer = Timer.periodic(_clockPeriod, (_) {
      DateTime now = DateTime.now();
      Duration delta = now.difference(_previousClock);
      _previousClock = now;
      _timeAccumulator += delta;

      while (_timeAccumulator >= GameTicker.updatePeriod) {
        _timeAccumulator -= GameTicker.updatePeriod;
        update();
      }
    });
  }

  T get game => _game;

  set gameState(T g) {
    _game = g;
  }

  @protected
  void beforeUpdate() {}

  @protected
  void afterUpdate() {}

  void update() {
    if (running) {
      beforeUpdate();

      gameSimulator.update(_game);

      afterUpdate();
    }
  }

  @mustCallSuper
  void dispose() {
    _updateTimer.cancel();
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
