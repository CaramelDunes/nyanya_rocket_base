import 'dart:collection';
import 'dart:io';

import 'package:meta/meta.dart';

import '../board.dart';
import '../state/multiplayer_game_state.dart';
import '../tile.dart';
import '../protocol/game_state.pb.dart' as protocol;
import '../protocol/messages.pb.dart';
import 'capsule_socket.dart';

class _AddressPort {
  final InternetAddress address;
  final int port;

  _AddressPort(this.address, this.port);

  @override
  bool operator ==(dynamic other) =>
      other.port == port && other.address.toString() == address.toString();

  @override
  int get hashCode {
    return port + address.toString().hashCode << 16;
  }
}

class ConnectionInfo {
  final PlayerColor playerColor;
  final String nickname;
  int sequenceNumber = 0;

  ConnectionInfo(this.playerColor, this.nickname);
}

class ServerSocket extends CapsuleSocket {
  final Set<int> tickets;
  final Function(int x, int y, Direction direction, PlayerColor playerColor)
      placeArrowCallback;
  final Function() playerJoinCallback;

  HashMap<_AddressPort, ConnectionInfo> _connections = HashMap();
  HashMap<int, _AddressPort> _ticketsToConnection = HashMap();

  ServerSocket(
      {@required int port,
      @required this.placeArrowCallback,
      @required this.playerJoinCallback,
      this.tickets = null})
      : super(port: port);

  void sendGameState(MultiplayerGameState game) {
    protocol.GameState state = game.toProtocolGameState();
    Capsule capsule = Capsule();
    capsule.gameState = state;

    _connections.keys.forEach((_AddressPort key) =>
        sendCapsule(capsule, key.address, key.port, false));
  }

  void _sendNicknames() {
    PlayerNicknamesMessage playerNicknamesMessage = PlayerNicknamesMessage();
    playerNicknamesMessage.nicknames.addAll(['', '', '', '']);

    _connections.values.forEach((ConnectionInfo info) {
      playerNicknamesMessage.nicknames[info.playerColor.index] = info.nickname;
    });

    Capsule capsule = Capsule();
    capsule.playerNicknames = playerNicknamesMessage;

    _connections.keys.forEach((_AddressPort key) =>
        sendCapsule(capsule, key.address, key.port, true));
  }

  @override
  void handleCapsule(InternetAddress address, int port, Capsule capsule) {
    _AddressPort key = _AddressPort(address, port);
    ConnectionInfo playerConnectionInfo = _connections[key];

    if (tickets != null && capsule.hasPing()) {
      int ticket = capsule.ping.ticket;

      // If player has a valid ticket.
      if (_ticketsToConnection.containsKey(ticket)) {
        _AddressPort old = _ticketsToConnection[ticket];
        playerConnectionInfo = _connections[old];

        // Discard if ping message is outdated.
        if (playerConnectionInfo == null ||
            !CapsuleSocket.isSequenceNumberGreaterThan(
                capsule.sequenceNumber, playerConnectionInfo.sequenceNumber)) {
          return;
        }

        // Update player IP address and port.
        _connections[key] = _connections[old];
        _ticketsToConnection[ticket] = key;
        _connections.remove(old);
      }
    }

    // If this is a registration message and the player hasn't been registered yet, register it
    if (capsule.hasRegister() && playerConnectionInfo == null) {
      if (capsule.sequenceNumber != 0) {
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
        ..givenColor = _connections[key].playerColor.toProtocolPlayerColor();

      Capsule response = Capsule()..registerSuccess = reply;
      sendCapsule(response, key.address, key.port, true);

      // Notify everyone
      _sendNicknames();

      playerJoinCallback();
      _ticketsToConnection[registerMessage.ticket] = key;
      // else if player is registered and message sequence number is less than previously seen, drop message
    } else if (playerConnectionInfo == null ||
        !CapsuleSocket.isSequenceNumberGreaterThan(
            capsule.sequenceNumber, playerConnectionInfo.sequenceNumber)) {
      return;
    }

    _connections[key].sequenceNumber = capsule.sequenceNumber;

    if (capsule.hasPlaceArrow()) {
      PlaceArrowMessage placeArrowMessage = capsule.placeArrow;

      placeArrowCallback(
          placeArrowMessage.x,
          placeArrowMessage.y,
          Direction.values[placeArrowMessage.direction.value],
          playerConnectionInfo.playerColor);
    }
  }
}
