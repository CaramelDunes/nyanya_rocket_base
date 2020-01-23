import 'dart:io';
import 'dart:typed_data';

import 'package:meta/meta.dart';

import 'protocol/messages.pb.dart';

abstract class CapsuleSocket {
  static const int protocolId = 0x1ba51999;

  int _mySequenceNumber = 0;
  RawDatagramSocket _socket;

  CapsuleSocket({int port = 0}) {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, port)
        .then((RawDatagramSocket socket) {
      _socket = socket;
      _socket.listen(_handleSocketEvent);
      onSocketReady();
      print('Listening on port $port');
    });
  }

  void close() {
    _socket?.close();
  }

  static bool isSequenceNumberGreaterThan(int s1, int s2) {
    return ((s1 > s2) && (s1 - s2 <= 32768)) ||
        ((s1 < s2) && (s2 - s1 > 32768));
  }

  @protected
  void sendCapsule(Capsule capsule, InternetAddress address, int port) {
    if (_socket == null) {
      print('Caught trying to send a message before socket is ready!');
      return;
    }

    capsule.protocolId = protocolId;
    capsule.sequenceId = _mySequenceNumber;
    Uint8List payload = capsule.writeToBuffer();
    _socket.send(payload, address, port);
    _mySequenceNumber += 1;
  }

  @protected
  void onSocketReady() {}

  @protected
  void handleCapsule(InternetAddress address, int port, Capsule capsule);

  void _handleSocketEvent(RawSocketEvent event) {
    if (event == RawSocketEvent.read) {
      Datagram packet = _socket.receive();

      if (packet != null) {
        Uint8List buffer = packet.data;

        if (buffer.length == 0) {
          print('Received packet of size 0');
          return;
        }

        Capsule capsule = Capsule.fromBuffer(buffer);
        handleCapsule(packet.address, packet.port, capsule);
      }
    }
  }
}
