import 'dart:math';

import 'package:meta/meta.dart';
import 'package:nyanya_rocket_base/nyanya_rocket_base.dart';

class MultiplayerGameTicker extends GameTicker {
  Random _rng = Random();

  int _eventTickDuration = 0;

  GameEvent _scheduledEvent = GameEvent.None;

  final List<List<ArrowPosition>> placedArrows =
      List.generate(4, (_) => List(), growable: false);

  MultiplayerGameTicker(Game game) : super(game);

  bool placeArrow(int x, int y, PlayerColor player, Direction direction) {
    if (running && game.board.tiles[x][y] is Empty) {
      int count = 0;
      ArrowPosition last;
      int lastExpiration = Arrow.defaultExpiration;

      for (int i = 0; i < Board.width; i++) {
        // TODO Get rid of that ugly thing
        for (int j = 0; j < Board.height; j++) {
          if (game.board.tiles[i][j] is Arrow) {
            Arrow arrow = game.board.tiles[i][j] as Arrow;
            if (player == arrow.player) {
              count++;

              if (arrow.expiration < lastExpiration) {
                last = ArrowPosition(i, j);
                lastExpiration = arrow.expiration;
              }
            }
          }
        }
      }

      if (count >= 3) {
        game.board.tiles[last.x][last.y] = Empty();
      }

      game.board.tiles[x][y] = Arrow(player: player, direction: direction);
      placedArrows[player.index].add(ArrowPosition(x, y));

      return true;
    }

    return false;
  }

  @override
  void onEntityInRocket(Entity entity, int x, int y) {
    if (entity is SpecialMouse) {
      _rng.nextInt(GameEvent.values.length);
      _scheduledEvent = GameEvent.values[_rng.nextInt(GameEvent.values.length)];
    }
  }

  @override
  @mustCallSuper
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
        // TODO Get rid of that ugly thing
        for (int i = 0; i < Board.width; i++) {
          for (int j = 0; j < Board.height; j++) {
            if (game.board.tiles[i][j] is Arrow) {
              game.board.tiles[i][j] = Empty();
            }
          }
        }

        placedArrows.forEach((List<ArrowPosition> list) => list.clear());
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
