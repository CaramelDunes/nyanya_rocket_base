import 'dart:async';
import 'dart:io';

import '../board.dart';
import '../tile.dart';
import '../state/multiplayer_game_state.dart';
import '../protocol/game_state.pb.dart' as protocol;
import '../protocol/messages.pb.dart';
import 'capsule_socket.dart';

typedef GameUpdateCallback = void Function(MultiplayerGameState game);
typedef PlayerRegister = void Function(PlayerColor assignedColor);
typedef PlayerNicknames = void Function(List<String> nicknames);

class ClientSocket extends CapsuleSocket {
  final InternetAddress serverAddress;
  final int serverPort;
  final String nickname;
  final int ticket;

  final GameUpdateCallback onGameUpdate;
  final PlayerRegister onPlayerRegister;
  final PlayerNicknames onPlayerNicknames;

  int _serverSequenceNumber = -1;

  Timer? _pingTimer;

  ClientSocket(
      {required this.serverAddress,
      required this.serverPort,
      required this.nickname,
      required this.onGameUpdate,
      required this.onPlayerRegister,
      required this.onPlayerNicknames,
      this.ticket = 0})
      : super();

  @override
  void dispose() {
    _pingTimer?.cancel();

    super.dispose();
  }

  @override
  void onSocketReady() {
    RegisterMessage registerMessage = RegisterMessage()..nickname = nickname;

    registerMessage..ticket = ticket;

    Capsule capsule = Capsule()..register = registerMessage;

    sendCapsule(capsule, serverAddress, serverPort, true);

    _pingTimer = Timer.periodic(Duration(seconds: 1), (_) {
      _sendPing();
    });
  }

  void sendArrowRequest(int x, int y, Direction direction) {
    Capsule capsule = Capsule();
    capsule.placeArrow = PlaceArrowMessage()
      ..x = x
      ..y = y
      ..direction = protocol.Direction.values[direction.index];

    sendCapsule(capsule, serverAddress, serverPort, true);
  }

  @override
  void handleCapsule(InternetAddress address, int port, Capsule capsule) {
    if (!CapsuleSocket.isSequenceNumberGreaterThan(
        capsule.sequenceNumber, _serverSequenceNumber)) {
      // Outdated message, skip
      return;
    }

    _serverSequenceNumber = capsule.sequenceNumber;

    if (capsule.hasGameState()) {
      onGameUpdate(
          MultiplayerGameState.fromProtocolGameState(capsule.gameState));
    } else if (capsule.hasRegisterSuccess()) {
      RegisterSuccessMessage registerSuccessMessage = capsule.registerSuccess;

      onPlayerRegister(
          PlayerColor.values[registerSuccessMessage.givenColor.value]);
    } else if (capsule.hasPlayerNicknames()) {
      PlayerNicknamesMessage playerNicknamesMessage = capsule.playerNicknames;

      onPlayerNicknames(playerNicknamesMessage.nicknames);
    }
  }

  void _sendPing() {
    Capsule capsule = Capsule();
    capsule.ping = PingMessage();

    capsule.ping..ticket = ticket;

    sendCapsule(capsule, serverAddress, serverPort, true);
  }
}
