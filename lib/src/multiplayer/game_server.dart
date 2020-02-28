import 'dart:io';

import 'package:meta/meta.dart';

import '../board.dart';
import '../state/multiplayer_game_state.dart';
import '../multiplayer_game_ticker.dart';
import '../tile.dart';
import 'server_socket.dart';

class ArrowPosition {
  final int x;
  final int y;

  ArrowPosition(this.x, this.y);
}

class GameServer extends MultiplayerGameTicker {
  final int playerCount;
  int _connectedCount = 0;

  ServerSocket _socket;
  bool _forceSendNextTick = false;

  GameServer(
      {@required Board board,
      @required this.playerCount,
      int port = 43210,
      Set<int> tickets})
      : super(MultiplayerGameState()..board = board) {
    _socket = ServerSocket(
        port: port,
        placeArrowCallback: _onPlaceArrow,
        playerJoinCallback: _handlePlayerJoin,
        tickets: tickets);
  }

  void close() {
    _socket.close();
    super.close();
  }

  @override
  void afterTick() {
    super.afterTick();

    if (game.tickCount % 15 == 0 || _forceSendNextTick) {
      _socket.sendGameState(game);
      _forceSendNextTick = false;
    }
  }

  void _onPlaceArrow(
      int x, int y, Direction direction, PlayerColor playerColor) {
    _forceSendNextTick |= placeArrow(x, y, playerColor, direction);
  }

  void _handlePlayerJoin() {
    _connectedCount++;
    running = _connectedCount >= playerCount;
  }

  @override
  void installGameEvent(GameEvent event) {
    super.installGameEvent(event);

    _forceSendNextTick = true;
  }
}
