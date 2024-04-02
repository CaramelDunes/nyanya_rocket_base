import '../board.dart';
import '../state/multiplayer_game_state.dart';
import '../multiplayer_game_ticker.dart';
import '../tile.dart';
import '../game_ticker.dart';
import 'server_socket.dart';

typedef GameEndCallback = void Function(List<int> scores);

class GameServer extends MultiplayerGameTicker {
  final int playerCount;
  final int endNumberOfTick;
  final GameEndCallback? onGameEnd;

  int _connectedCount = 0;
  late ServerSocket _socket;
  bool _forceSendNextTick = false;

  GameServer(
      {required Board board,
      required this.playerCount,
      required Duration gameDuration,
      this.onGameEnd,
      int port = 43210,
      Set<int>? tickets})
      : endNumberOfTick = (gameDuration.inMicroseconds /
                GameTicker.updatePeriod.inMicroseconds *
                2)
            .round(),
        super(MultiplayerGameState()..board = board) {
    _socket = ServerSocket(
        port: port,
        onPlaceArrow: _onPlaceArrow,
        onPlayerJoin: _handlePlayerJoin,
        tickets: tickets);
  }

  @override
  void dispose() {
    _socket.dispose();

    super.dispose();
  }

  @override
  void afterUpdate() {
    super.afterUpdate();

    if (game.tickCount >= endNumberOfTick) {
      running = false;
      onGameEnd?.call(game.scores);
    }

    if (game.tickCount % 60 == 0 || _forceSendNextTick) {
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
