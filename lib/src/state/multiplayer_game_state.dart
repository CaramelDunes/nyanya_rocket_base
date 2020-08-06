import 'package:fixnum/fixnum.dart';

import '../board.dart';
import '../entity.dart';
import '../exposed_random.dart';
import '../protocol/game_state.pb.dart' as protocol;

import 'game_state.dart';

enum GameEvent {
  None,
  MouseMania,
  CatMania,
  SpeedUp,
  SlowDown,
  PlaceAgain,
  CatAttack,
  MouseMonopoly,
  EverybodyMove
}

class MultiplayerGameState extends GameState {
  GameEvent currentEvent = GameEvent.None;
  ExposedRandom _rng = ExposedRandom();
  int pauseUntil = 0;
  int eventEnd = 0;

  MultiplayerGameState() : super();

  MultiplayerGameState.fromProtocolGameState(protocol.GameState gameState) {
    board = Board.fromProtocolBoard(gameState.board);

    gameState.cats.forEach((protocol.Entity entity) {
      cats.add(Entity.fromProtocolEntity(entity));
    });

    gameState.mice.forEach((protocol.Entity entity) {
      mice.add(Entity.fromProtocolEntity(entity));
    });

    scores = gameState.scores;

    currentEvent = GameEvent.values[gameState.event.value];
    tickCount = gameState.tickCount;
    pauseUntil = gameState.pauseUntil;
    eventEnd = gameState.eventEnd;

    _rng = ExposedRandom.withState(gameState.rngState.toInt());
  }

  protocol.GameState toProtocolGameState() {
    protocol.GameState g = protocol.GameState();

    g.board = board.toProtocolBoard();
    scores.forEach((int score) => g.scores.add(score));
    cats.forEach((Cat cat) => g.cats.add(cat.toProtocolEntity()));
    mice.forEach((Mouse mouse) => g.mice.add(mouse.toProtocolEntity()));

    g.event = protocol.GameEvent.values[currentEvent.index];

    g.tickCount = tickCount;
    g.pauseUntil = pauseUntil;
    g.eventEnd = eventEnd;

    g.rngState = Int64.fromInts(_rng.state >> 32, _rng.state);

    return g;
  }

  ExposedRandom get rng => _rng;
}

int gameEventDurationSeconds(GameEvent event) {
  switch (event) {
    case GameEvent.CatMania:
    case GameEvent.MouseMania:
    case GameEvent.SpeedUp:
    case GameEvent.SlowDown:
      return 10;
      break;

    // TODO Handle 'instantaneous' events properly
    case GameEvent.MouseMonopoly:
    case GameEvent.CatAttack:
    case GameEvent.PlaceAgain:
    case GameEvent.EverybodyMove:
    case GameEvent.None:
    default:
      return 0;
      break;
  }
}

int gameEventPauseDurationSeconds(GameEvent event) {
  switch (event) {
    case GameEvent.CatMania:
    case GameEvent.MouseMania:
    case GameEvent.SpeedUp:
    case GameEvent.SlowDown:
      return 3;
      break;

    // TODO Handle 'instantaneous' events properly
    case GameEvent.MouseMonopoly:
    case GameEvent.CatAttack:
    case GameEvent.EverybodyMove:
      return 3 + 2;
      break;

    case GameEvent.PlaceAgain:
      return 3 + 3;
      break;

    case GameEvent.None:
    default:
      return 0;
      break;
  }
}
