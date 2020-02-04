import 'dart:io';
import 'package:meta/meta.dart';
import 'package:nyanya_rocket_base/src/capsule_socket.dart';

import 'board.dart';
import 'game.dart';
import 'protocol/game_state.pb.dart' as protocol;
import 'protocol/messages.pb.dart';

class ClientSocket extends CapsuleSocket {
  final InternetAddress serverAddress;
  final int port;
  final String nickname;
  final int ticket;
  final Function(Game game) gameCallback;
  final Function(RegisterSuccessMessage registerSuccessMessage)
      playerRegisterSuccessCallback;

  int _serverSequenceId = 0;

  ClientSocket(
      {@required this.serverAddress,
      @required this.port,
      @required this.nickname,
      @required this.gameCallback,
      @required this.playerRegisterSuccessCallback,
      this.ticket = null})
      : super() {}

  @override
  void onSocketReady() {
    print('Socket is ready');
    RegisterMessage registerMessage = RegisterMessage()..nickname = nickname;
    Capsule capsule = Capsule()..register = registerMessage;

    print('sending somwthing');
    sendCapsule(capsule, serverAddress, port);
  }

  void sendArrowRequest(int x, int y, Direction direction) {
    Capsule capsule = Capsule();
    capsule.placeArrow = PlaceArrowMessage()
      ..x = x
      ..y = y
      ..direction = protocol.Direction.values[direction.index];

    sendCapsule(capsule, serverAddress, port, 5);
  }

  @override
  void handleCapsule(InternetAddress address, int port, Capsule capsule) {
    if (!CapsuleSocket.isSequenceNumberGreaterThan(
        capsule.sequenceId, _serverSequenceId)) {
      // Outdated message, skip
      return;
    }

    _serverSequenceId = capsule.sequenceId;

    if (capsule.hasGame()) {
      gameCallback(Game.fromProtocolGame(capsule.game));
    } else if (capsule.hasRegisterSuccess()) {
      RegisterSuccessMessage registerSuccessMessage = capsule.registerSuccess;

      playerRegisterSuccessCallback(registerSuccessMessage);
    }
  }
}
