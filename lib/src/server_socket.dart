import 'dart:collection';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:nyanya_rocket_base/src/capsule_socket.dart';

import 'board.dart';
import 'game.dart';
import 'tile.dart';
import 'protocol/game_state.pb.dart' as protocol;
import 'protocol/messages.pb.dart';

class AddressPort {
  final InternetAddress address;
  final int port;

  AddressPort(this.address, this.port);

  @override
  bool operator ==(dynamic other) =>
      other.port == port &&
          other.address.toString() == address.toString();

  @override
  int get hashCode {
    return port + address
        .toString()
        .hashCode << 16;
  }
}

class ConnectionInfo {
  int _sequenceNumber = 0;
  final PlayerColor playerColor;
  final String nickname;

  ConnectionInfo(this.playerColor, this.nickname);

  int get sequenceNumber {
    return _sequenceNumber;
  }

  void incrementSequenceId() {
    _sequenceNumber++;
  }
}

class ServerSocket extends CapsuleSocket {
  final Set<int> tickets;
  final Function(int x, int y, Direction direction, PlayerColor playerColor)
  placeArrowCallback;
  final Function() playerJoinCallback;

  // <AddressPort, SequenceId>
  HashMap<AddressPort, ConnectionInfo> _connections = HashMap();

  ServerSocket({@required int port,
    @required this.placeArrowCallback,
    @required this.playerJoinCallback,
    this.tickets = null})
      : super(port: port);

  void sendGameState(Game game) {
    protocol.Game state = game.toGameState();
    Capsule capsule = Capsule();
    capsule.game = state;

    _connections.keys.forEach(
            (AddressPort key) => sendCapsule(capsule, key.address, key.port));
  }

  @override
  void handleCapsule(InternetAddress address, int port, Capsule capsule) {
    AddressPort key = AddressPort(address, port);
    ConnectionInfo playerSequenceId =
    _connections.containsKey(key) ? _connections[key] : null;

    if (capsule.hasRegister()) {
      if (capsule.sequenceId != 0) {
        print('Received non-zero sequence id in a registration packet.');
        return;
      }

      RegisterMessage registerMessage = capsule.register;

      // If tickets have been specified, they are required
      if (tickets != null) {
        if (registerMessage.hasTicket() &&
            tickets.contains(registerMessage.ticket)) {
          // Burn ticket
          tickets.remove(registerMessage.ticket);
          print('Ticket ${registerMessage.ticket} burned.');
        } else {
          print('Wrong ticket received!');
          return;
        }
      }

      _connections[key] = ConnectionInfo(
          PlayerColor.values[_connections.length], registerMessage.nickname);

      print('New player ${registerMessage.nickname}');

      RegisterSuccessMessage reply = RegisterSuccessMessage()
        ..nickname = registerMessage.nickname
        ..givenColor = _connections[key].playerColor.toProtocolPlayerColor();

      Capsule response = Capsule()
        ..registerSuccess = reply;

      // Notify everyone
      _connections.keys.forEach(
              (AddressPort key) =>
              sendCapsule(response, key.address, key.port));

      playerJoinCallback();
    } else if (playerSequenceId == null ||
        CapsuleSocket.isSequenceNumberGreaterThan(
            playerSequenceId.sequenceNumber, capsule.sequenceId)) {
      return;
    }

    _connections[key].incrementSequenceId();

    if (capsule.hasPlaceArrow()) {
      PlaceArrowMessage placeArrowMessage = capsule.placeArrow;

      placeArrowCallback(
          placeArrowMessage.x,
          placeArrowMessage.y,
          Direction.values[placeArrowMessage.direction.value],
          playerSequenceId.playerColor);
    }
  }
}
