import 'dart:collection';
import 'dart:io';

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
  bool operator ==(Object other) =>
      other is _AddressPort &&
      other.port == port &&
      other.address.toString() == address.toString();

  @override
  int get hashCode {
    return port + address.toString().hashCode << 16;
  }
}

class _ConnectionInfo {
  final PlayerColor playerColor;
  final String nickname;
  int sequenceNumber = 0;

  _ConnectionInfo(this.playerColor, this.nickname);
}

typedef VoidCallback = void Function();
typedef PlaceArrow = void Function(
    int x, int y, Direction direction, PlayerColor playerColor);

class ServerSocket extends CapsuleSocket {
  final Set<int>? tickets;
  final PlaceArrow onPlaceArrow;
  final VoidCallback onPlayerJoin;

  // TODO Federate in a class.
  final HashMap<_AddressPort, _ConnectionInfo> _connections = HashMap();
  final HashMap<int, _AddressPort> _ticketsToConnection = HashMap();

  ServerSocket(
      {required int port,
      required this.onPlaceArrow,
      required this.onPlayerJoin,
      this.tickets})
      : super(boundPort: port);

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

    _connections.values.forEach((_ConnectionInfo info) {
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

    switch (capsule.whichPayload()) {
      case Capsule_Payload.ping:
        // Connection switching is only supported with tickets.
        if (tickets != null && !_connections.containsKey(key)) {
          int ticket = capsule.ping.ticket;

          // If player has a valid ticket.
          if (_ticketsToConnection.containsKey(ticket)) {
            _AddressPort old = _ticketsToConnection[ticket]!;
            _ConnectionInfo? playerConnectionInfo = _connections[old];

            // Discard if ping message is outdated or connection info
            // could not be found (shouldn't happen here).
            if (playerConnectionInfo == null ||
                !CapsuleSocket.isSequenceNumberGreaterThan(
                    capsule.sequenceNumber,
                    playerConnectionInfo.sequenceNumber)) {
              return;
            }

            // Update player IP address and port.
            _ticketsToConnection[ticket] = key;
            _connections[key] = _connections.remove(old)!;
          }
        }
        break;

      case Capsule_Payload.register:
        if (!_connections.containsKey(key)) {
          if (capsule.sequenceNumber != 0) {
            print('Received non-zero sequence id in a registration packet.');
            return;
          }

          RegisterMessage registerMessage = capsule.register;

          // If tickets have been specified, they are required
          if (tickets != null) {
            if (registerMessage.hasTicket() &&
                tickets!.contains(registerMessage.ticket)) {
              // Burn ticket
              tickets!.remove(registerMessage.ticket);
              print('Ticket ${registerMessage.ticket} burned.');
            } else {
              print('Wrong ticket received!');
              return;
            }
          }

          _connections[key] = _ConnectionInfo(
              PlayerColor.values[_connections.length],
              registerMessage.nickname);
          _ticketsToConnection[registerMessage.ticket] = key;

          print('New player ${registerMessage.nickname}');

          RegisterSuccessMessage reply = RegisterSuccessMessage()
            ..givenColor =
                _connections[key]!.playerColor.toProtocolPlayerColor();

          Capsule response = Capsule()..registerSuccess = reply;
          sendCapsule(response, key.address, key.port, true);

          // Notify everyone
          _sendNicknames();

          onPlayerJoin();
        }
        break;

      case Capsule_Payload.placeArrow:
        _ConnectionInfo? playerConnectionInfo = _connections[key];

        if (playerConnectionInfo != null &&
            CapsuleSocket.isSequenceNumberGreaterThan(
                capsule.sequenceNumber, playerConnectionInfo.sequenceNumber)) {
          playerConnectionInfo.sequenceNumber = capsule.sequenceNumber;

          PlaceArrowMessage placeArrowMessage = capsule.placeArrow;

          onPlaceArrow(
              placeArrowMessage.x,
              placeArrowMessage.y,
              Direction.values[placeArrowMessage.direction.value],
              playerConnectionInfo.playerColor);
        }
        break;

      case Capsule_Payload.gameState:
      case Capsule_Payload.registerSuccess:
      case Capsule_Payload.playerNicknames:
      case Capsule_Payload.notSet:
        break;
    }
  }
}
