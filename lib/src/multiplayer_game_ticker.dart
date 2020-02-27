import 'package:meta/meta.dart';
import 'board.dart';
import 'entity.dart';
import 'game_ticker.dart';
import 'multiplayer/game_server.dart';
import 'simulators/multiplayer_game_simulator.dart';
import 'state/multiplayer_game_state.dart';
import 'tile.dart';

class MultiplayerGameTicker extends GameTicker<MultiplayerGameState> {
  int _eventTickDuration = 0;

  GameEvent _scheduledEvent = GameEvent.None;
  PlayerColor _eventOrigin;

  final List<List<ArrowPosition>> placedArrows =
      List.generate(4, (_) => List(), growable: false);

  MultiplayerGameTicker(MultiplayerGameState game)
      : super(game, MultiplayerGameSimulator());

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
      _scheduledEvent =
          GameEvent.values[game.rng.nextInt(GameEvent.values.length - 1) + 1];
      _eventOrigin = (game.board.tiles[x][y] as Rocket).player;
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
        game.mice.clear();
        game.cats.clear();
        break;

      case GameEvent.MouseMania:
        game.cats.clear();
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
        for (int i = 0; i < Board.width; i++) {
          for (int j = 0; j < Board.height; j++) {
            if (game.board.tiles[i][j] is Rocket) {
              Rocket r = game.board.tiles[i][j] as Rocket;

              if (r.player != _eventOrigin) {
                game.cats.add(Cat(
                    position: BoardPosition.centered(i, j, Direction.Down)));
              }
            }
          }
        }

        _eventTickDuration = 1; // 10 seconds
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

        _eventTickDuration = 1; // 10 seconds
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
        game.cats.clear();
        game.mice.clear();
        break;

      case GameEvent.MouseMania:
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
