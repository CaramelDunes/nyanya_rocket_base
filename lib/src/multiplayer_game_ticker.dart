import 'dart:math';

import 'package:meta/meta.dart';
import 'package:nyanya_rocket_base/nyanya_rocket_base.dart';

class MultiplayerGameTicker extends GameTicker {
  Random _rng = Random();

  int _eventTickDuration = 0;

  GameEvent _scheduledEvent = GameEvent.None;

  MultiplayerGameTicker(Game game) : super(game);

  @override
  void onEntityInRocket(Entity entity, int x, int y) {
    if (entity is SpecialMouse) {
      _rng.nextInt(GameEvent.values.length);
      _scheduledEvent = GameEvent.values[_rng.nextInt(GameEvent.values.length)];
    }
  }

  @override
  void afterTick() {
    if (_eventTickDuration > 1) {
      _eventTickDuration--;
    } else if (_eventTickDuration == 1) {
      removeGameEvent();
    }

    if (_scheduledEvent != GameEvent.None) {
      removeGameEvent();
      setGameEvent(_scheduledEvent);
      _scheduledEvent = GameEvent.None;
    }

    super.afterTick();
  }

  @protected
  @mustCallSuper
  void setGameEvent(GameEvent event) {
    pauseFor(Duration(seconds: 2)); // Animation duration
    // TODO Use tick count instead of Duration

    _eventTickDuration = 10 * 60; // 10 seconds

    switch (event) {
      case GameEvent.CatMania:
        game.entities.clear();
        game.generatorPolicy = GeneratorPolicy.CatMania;
        break;

      case GameEvent.MouseMania:
        game.generatorPolicy = GeneratorPolicy.MouseMania;
        break;

      case GameEvent.SpeedUp:
        speed = GameSpeed.Fast;
        break;

      case GameEvent.SlowDown:
        speed = GameSpeed.Slow;
        break;

      case GameEvent.MouseMonopoly:
        _eventTickDuration = 5 * 60; // 5 seconds
        break;

      case GameEvent.CatAttack:
        break;

      case GameEvent.PlaceAgain:
        break;

      case GameEvent.None:
        break;
    }

    game.currentEvent = event;
  }

  @protected
  @mustCallSuper
  void removeGameEvent() {
    _eventTickDuration = 0;

    switch (game.currentEvent) {
      case GameEvent.CatAttack:
        break;

      case GameEvent.CatMania:
        game.entities.clear();
        game.generatorPolicy = GeneratorPolicy.Regular;
        break;

      case GameEvent.MouseMania:
        game.generatorPolicy = GeneratorPolicy.Regular;
        break;

      case GameEvent.SpeedUp:
        speed = GameSpeed.Normal;
        break;

      case GameEvent.SlowDown:
        speed = GameSpeed.Normal;
        break;

      case GameEvent.MouseMonopoly:
        break;

      case GameEvent.PlaceAgain:
        break;

      case GameEvent.None:
        break;
    }

    game.currentEvent = GameEvent.None;
  }
}
