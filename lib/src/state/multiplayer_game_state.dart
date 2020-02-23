import '../board.dart';
import '../entity.dart';
import '../xor_shift.dart';
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
}

class MultiplayerGameState extends GameState {
  GameEvent currentEvent = GameEvent.None;
  XorShiftState _xorShiftState = XorShiftState.random();

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

    _xorShiftState.a = gameState.rngState.a;
    _xorShiftState.b = gameState.rngState.b;
    _xorShiftState.c = gameState.rngState.c;
    _xorShiftState.d = gameState.rngState.d;
  }

  protocol.GameState toProtocolGameState() {
    protocol.GameState g = protocol.GameState();

    g.board = board.toProtocolBoard();
    scores.forEach((int score) => g.scores.add(score));
    cats.forEach((Cat cat) => g.cats.add(cat.toProtocolEntity()));
    mice.forEach((Mouse mouse) => g.mice.add(mouse.toProtocolEntity()));

    g.event = protocol.GameEvent.values[currentEvent.index];

    g.tickCount = tickCount;

    g.rngState = protocol.XorShiftState();
    g.rngState.a = _xorShiftState.a;
    g.rngState.b = _xorShiftState.b;
    g.rngState.c = _xorShiftState.c;
    g.rngState.d = _xorShiftState.d;

    return g;
  }

  int nextXorShiftInt(int max) {
    return _xorShiftState.nextInt(max);
  }
}
