import 'dart:io';
import 'dart:typed_data';

import 'package:meta/meta.dart';

import '../protocol/messages.pb.dart';

abstract class CapsuleSocket {
  static const int protocolId = 0x1ba51999;
  static const int redundancyCount = 5;

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
    return s1 > s2;
  }

  @protected
  void sendCapsule(
      Capsule capsule, InternetAddress address, int port, bool sendCopies) {
    if (_socket == null) {
      print('Caught trying to send a message before socket is ready!');
      return;
    }

    capsule.protocolId = protocolId;
    capsule.sequenceNumber = _mySequenceNumber;
    Uint8List payload = capsule.writeToBuffer();

    int copies = sendCopies ? redundancyCount : 1;
    for (int i = 0; i < copies; i++) {
      _socket.send(payload, address, port);
    }

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
        Capsule capsule;

        try {
          capsule = Capsule.fromBuffer(buffer);
        } catch (e) {
          print('[WARN] Received bogus message: $e');
          return;
        }

        if (capsule.protocolId == protocolId) {
          handleCapsule(packet.address, packet.port, capsule);
        } else {
          print('Received invalid protocol id!');
        }
      }
    }
  }
}
