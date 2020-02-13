import 'dart:io';

import 'package:meta/meta.dart';
import 'package:nyanya_rocket_base/src/server_socket.dart';

import 'board.dart';
import 'game.dart';
import 'multiplayer_game_ticker.dart';
import 'tile.dart';

class ArrowPosition {
  final int x;
  final int y;

  ArrowPosition(this.x, this.y);
}

class GameServer extends MultiplayerGameTicker {
  final int nbPlayer;
  int _playerCount = 0;

  ServerSocket _socket;
  bool _forceSendNextTick = false;

  GameServer(
      {@required Board board,
      @required this.nbPlayer,
      int port = 43210,
      Set<int> tickets})
      : super(Game()..board = board) {
    running = false;
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
    _forceSendNextTick = placeArrow(x, y, playerColor, direction);
  }

  void _handlePlayerJoin() {
    _playerCount++;
    running = _playerCount >= nbPlayer;
  }
}
