import 'dart:io';
import 'package:meta/meta.dart';

import '../board.dart';
import '../tile.dart';
import '../state/multiplayer_game_state.dart';
import '../protocol/game_state.pb.dart' as protocol;
import '../protocol/messages.pb.dart';
import 'capsule_socket.dart';

class ClientSocket extends CapsuleSocket {
  final InternetAddress serverAddress;
  final int serverPort;
  final String nickname;
  final int ticket;

  final Function(MultiplayerGameState game) gameStateCallback;
  final Function(PlayerColor assignedColor) playerRegisterSuccessCallback;
  final Function(List<String> nicknames) playerNicknamesCallback;

  int _serverSequenceNumber = -1;

  ClientSocket(
      {@required this.serverAddress,
      @required this.serverPort,
      @required this.nickname,
      @required this.gameStateCallback,
      @required this.playerRegisterSuccessCallback,
      @required this.playerNicknamesCallback,
      this.ticket = null})
      : super();

  @override
  void onSocketReady() {
    RegisterMessage registerMessage = RegisterMessage()
      ..nickname = nickname
      ..ticket = ticket ?? 0;
    Capsule capsule = Capsule()..register = registerMessage;

    sendCapsule(capsule, serverAddress, serverPort, true);
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
      gameStateCallback(
          MultiplayerGameState.fromProtocolGameState(capsule.gameState));
    } else if (capsule.hasRegisterSuccess()) {
      RegisterSuccessMessage registerSuccessMessage = capsule.registerSuccess;

      playerRegisterSuccessCallback(
          PlayerColor.values[registerSuccessMessage.givenColor.value]);
    } else if (capsule.hasPlayerNicknames()) {
      PlayerNicknamesMessage playerNicknamesMessage = capsule.playerNicknames;

      playerNicknamesCallback(playerNicknamesMessage.nicknames);
    }
  }
}
