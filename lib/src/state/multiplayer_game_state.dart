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
  int pauseTicks = 0;

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
    pauseTicks = gameState.pauseTicks;

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
    g.pauseTicks = pauseTicks;

    g.rngState = Int64.fromInts(_rng.state >> 32, _rng.state);

    return g;
  }

  ExposedRandom get rng => _rng;
}
