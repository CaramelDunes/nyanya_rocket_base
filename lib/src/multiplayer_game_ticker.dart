import 'package:meta/meta.dart';
import 'package:nyanya_rocket_base/nyanya_rocket_base.dart';
import 'board.dart';
import 'entity.dart';
import 'game_ticker.dart';
import 'simulators/multiplayer_game_simulator.dart';
import 'state/multiplayer_game_state.dart';
import 'tile.dart';

class ArrowPosition {
  final int x;
  final int y;

  ArrowPosition(this.x, this.y);
}

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
  GameEvent _scheduledEvent = GameEvent.None;
  PlayerColor _eventOrigin;

  final List<List<ArrowPosition>> placedArrows =
      List.generate(4, (_) => List(), growable: false);

  MultiplayerGameTicker(MultiplayerGameState game)
      : super(game, MultiplayerGameSimulator());

  int microTicksPerTick() {
    if (game.currentEvent == GameEvent.SpeedUp)
      return 4;
    else if (game.currentEvent == GameEvent.SlowDown)
      return 1;
    else
      return 2;
  }

  int secondsInTicks(int seconds) {
    return seconds * microTicksPerTick() * 60;
  }

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
      _scheduledEvent =
          (gameSimulator as MultiplayerGameSimulator).nextGameEvent;
      _eventOrigin = (game.board.tiles[x][y] as Rocket).player;
    }
  }

  @override
  @mustCallSuper
  void afterUpdate() {
    if (game.currentEvent != GameEvent.None &&
        game.tickCount >= game.eventEnd) {
      uninstallGameEvent();
    }

    if (_scheduledEvent != GameEvent.None) {
      uninstallGameEvent();
      installGameEvent(_scheduledEvent);
      _scheduledEvent = GameEvent.None;
    }

    super.afterUpdate();
  }

  @protected
  @mustCallSuper
  void installGameEvent(GameEvent event) {
    game.currentEvent = event;

    game.pauseUntil =
        game.tickCount + secondsInTicks(gameEventPauseDurationSeconds(event));
    game.eventEnd =
        game.pauseUntil + secondsInTicks(gameEventDurationSeconds(event));

    switch (event) {
      case GameEvent.CatMania:
        game.mice.clear();
        game.cats.clear();
        break;

      case GameEvent.MouseMania:
        game.cats.clear();
        break;

      case GameEvent.MouseMonopoly:
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

      case GameEvent.EverybodyMove:
        List<PlayerColor> rocketColors = List();
        List<ArrowPosition> rocketPositions = List();

        for (int i = 0; i < Board.width; i++) {
          for (int j = 0; j < Board.height; j++) {
            if (game.board.tiles[i][j] is Rocket) {
              rocketColors.add((game.board.tiles[i][j] as Rocket).player);
              rocketPositions.add(ArrowPosition(i, j));
            }
          }
        }

        if (rocketPositions.length < 2) {
          // Cannot shuffle a one-element list.
          break;
        }

        // Create a copy of current rocket positions.
        List<ArrowPosition> derangement = List.of(rocketPositions);

        do {
          derangement.shuffle(game.rng);
        } while (!_isDerangement(rocketPositions, derangement));

        rocketColors.asMap().forEach((i, color) {
          ArrowPosition pos = derangement[i];
          game.board.tiles[pos.x][pos.y] = Rocket(player: color);
        });
        break;

      case GameEvent.SpeedUp:
      case GameEvent.SlowDown:
      case GameEvent.None:
        break;
    }
  }

  @protected
  @mustCallSuper
  void uninstallGameEvent() {
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
