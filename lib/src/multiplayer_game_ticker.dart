import 'package:meta/meta.dart';
import 'board.dart';
import 'entity.dart';
import 'game_ticker.dart';
import 'multiplayer/game_server.dart';
import 'simulators/multiplayer_game_simulator.dart';
import 'state/multiplayer_game_state.dart';
import 'tile.dart';

// Reference behaviors:
// Mouse Monopoly: https://youtu.be/eHWSrXzEV1I?t=613
// Cat Mania: https://youtu.be/eHWSrXzEV1I?t=626

// Everybody Move: https://youtu.be/eHWSrXzEV1I?t=716
// Blue -> Yellow -> Green -> Red
// https://youtu.be/eHWSrXzEV1I?t=835
// Blue -> Green -> Red -> Yellow
// https://youtu.be/eHWSrXzEV1I?t=1180
// Blue -> Yellow -> Green -> Red
// https://youtu.be/eHWSrXzEV1I?t=1234
// Blue <-> Red, Yellow <-> Green
// Blue -> Red -> Green -> Yellow
// Blue -> Red -> Yellow -> Green

// Mouse Mania: https://youtu.be/eHWSrXzEV1I?t=722
// Speed Up: https://youtu.be/eHWSrXzEV1I?t=735
// Place Arrows Again: https://youtu.be/eHWSrXzEV1I?t=755
// Slow Down: https://youtu.be/eHWSrXzEV1I?t=824

class MultiplayerGameTicker extends GameTicker<MultiplayerGameState> {
  int _eventTickDuration = 0;

  GameEvent _scheduledEvent = GameEvent.None;
  PlayerColor _eventOrigin;
  GameEvent _nextEvent = GameEvent.None;

  final List<List<ArrowPosition>> placedArrows =
      List.generate(4, (_) => List(), growable: false);

  MultiplayerGameTicker(MultiplayerGameState game)
      : super(game, MultiplayerGameSimulator());

  bool placeArrow(int x, int y, PlayerColor player, Direction direction) {
    if (running && game.board.tiles[x][y] is Empty) {
      int count = 0;
      ArrowPosition last;
      int lastExpiration = 1 << 32;

      // TODO Get rid of that ugly thing
      for (int i = 0; i < Board.width; i++) {
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
      _scheduledEvent = _nextEvent;
      _eventOrigin = (game.board.tiles[x][y] as Rocket).player;
    }
  }

  @override
  @mustCallSuper
  void afterTick() {
    if (_eventTickDuration > 1) {
      _eventTickDuration--;
    } else if (_eventTickDuration == 1) {
      uninstallGameEvent();
    }

    if (_scheduledEvent != GameEvent.None) {
      uninstallGameEvent();
      installGameEvent(_scheduledEvent);
      _scheduledEvent = GameEvent.None;
    }

    super.afterTick();
    _nextEvent =
        GameEvent.values[game.rng.nextInt(GameEvent.values.length - 1) + 1];
  }

  @protected
  @mustCallSuper
  void installGameEvent(GameEvent event) {
    game.pauseTicks = GameTicker.durationInTicks(
        Duration(seconds: 3)); // Animation duration = 3s

    _eventTickDuration = GameTicker.durationInTicks(Duration(seconds: 10));

    switch (event) {
      case GameEvent.CatMania:
        game.mice.clear();
        game.cats.clear();
        break;

      case GameEvent.MouseMania:
        game.cats.clear();
        break;

      case GameEvent.SpeedUp:
        _eventTickDuration = GameTicker.durationInTicks(Duration(seconds: 8));
        break;

      case GameEvent.SlowDown:
        _eventTickDuration = GameTicker.durationInTicks(Duration(seconds: 8));
        break;

      case GameEvent.MouseMonopoly:
        _eventTickDuration = 1;

        // Cash-in all mice on board
        game.mice.forEach((mouse) {
          if (mouse is GoldenMouse) {
            game.scores[_eventOrigin.index] += 50;
          } else {
            game.scores[_eventOrigin.index]++;
          }
        });

        game.mice.clear();
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

        _eventTickDuration = 1;
        break;

      case GameEvent.PlaceAgain:
        // Players got 3 seconds to place arrows.
        game.pauseTicks += GameTicker.durationInTicks(Duration(seconds: 3));

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

      case GameEvent.EverybodyMove:
        // Players got 2 seconds to see where their rocket is.
        game.pauseTicks += GameTicker.durationInTicks(Duration(seconds: 2));

        List<ArrowPosition> rocketPositions = List.filled(4, null);

        for (int i = 0; i < Board.width; i++) {
          for (int j = 0; j < Board.height; j++) {
            if (game.board.tiles[i][j] is Rocket) {
              rocketPositions[(game.board.tiles[i][j] as Rocket).player.index] =
                  ArrowPosition(i, j);
            }
          }
        }

        assert(rocketPositions[0] != null &&
            rocketPositions[1] != null &&
            rocketPositions[2] != null &&
            rocketPositions[3] != null);

        var derangement = List.of(rocketPositions);

        while (!_isDerangement(rocketPositions, derangement)) {
          derangement.shuffle(game.rng);
        }

        for (int i = 0; i < 4; i++) {
          ArrowPosition pos = derangement[i];
          game.board.tiles[pos.x][pos.y] =
              Rocket(player: PlayerColor.values[i]);
        }

        _eventTickDuration = 1;
        break;

      case GameEvent.None:
        break;
    }

    game.currentEvent = event;
  }

  @protected
  @mustCallSuper
  void uninstallGameEvent() {
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
        break;

      case GameEvent.SlowDown:
        break;

      case GameEvent.MouseMonopoly:
        break;

      case GameEvent.PlaceAgain:
        break;

      case GameEvent.EverybodyMove:
        break;

      case GameEvent.None:
        break;
    }

    game.currentEvent = GameEvent.None;
  }
}

bool _isDerangement(List a, List b) {
  assert(a.length == b.length);

  for (int i = 0; i < a.length; i++) {
    if (a[i] == b[i]) return false;
  }

  return true;
}
