///
//  Generated code. Do not modify.
//  source: game_server.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' show int, dynamic, String, List, Map;
import 'package:protobuf/protobuf.dart' as $pb;

class ProtocolDirection extends $pb.ProtobufEnum {
  static const ProtocolDirection RIGHT = const ProtocolDirection._(0, 'RIGHT');
  static const ProtocolDirection UP = const ProtocolDirection._(1, 'UP');
  static const ProtocolDirection LEFT = const ProtocolDirection._(2, 'LEFT');
  static const ProtocolDirection DOWN = const ProtocolDirection._(3, 'DOWN');

  static const List<ProtocolDirection> values = const <ProtocolDirection> [
    RIGHT,
    UP,
    LEFT,
    DOWN,
  ];

  static final Map<int, ProtocolDirection> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProtocolDirection valueOf(int value) => _byValue[value];

  const ProtocolDirection._(int v, String n) : super(v, n);
}

class ProtocolPlayerColor extends $pb.ProtobufEnum {
  static const ProtocolPlayerColor BLUE = const ProtocolPlayerColor._(0, 'BLUE');
  static const ProtocolPlayerColor YELLOW = const ProtocolPlayerColor._(1, 'YELLOW');
  static const ProtocolPlayerColor RED = const ProtocolPlayerColor._(2, 'RED');
  static const ProtocolPlayerColor GREEN = const ProtocolPlayerColor._(3, 'GREEN');

  static const List<ProtocolPlayerColor> values = const <ProtocolPlayerColor> [
    BLUE,
    YELLOW,
    RED,
    GREEN,
  ];

  static final Map<int, ProtocolPlayerColor> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProtocolPlayerColor valueOf(int value) => _byValue[value];

  const ProtocolPlayerColor._(int v, String n) : super(v, n);
}

class ProtocolWall extends $pb.ProtobufEnum {
  static const ProtocolWall NONE = const ProtocolWall._(0, 'NONE');
  static const ProtocolWall LEFT_ONLY = const ProtocolWall._(1, 'LEFT_ONLY');
  static const ProtocolWall UP_ONLY = const ProtocolWall._(2, 'UP_ONLY');
  static const ProtocolWall LEFT_UP = const ProtocolWall._(3, 'LEFT_UP');

  static const List<ProtocolWall> values = const <ProtocolWall> [
    NONE,
    LEFT_ONLY,
    UP_ONLY,
    LEFT_UP,
  ];

  static final Map<int, ProtocolWall> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProtocolWall valueOf(int value) => _byValue[value];

  const ProtocolWall._(int v, String n) : super(v, n);
}

class ProtocolTileType extends $pb.ProtobufEnum {
  static const ProtocolTileType EMPTY = const ProtocolTileType._(0, 'EMPTY');
  static const ProtocolTileType ARROW = const ProtocolTileType._(1, 'ARROW');
  static const ProtocolTileType PIT = const ProtocolTileType._(2, 'PIT');
  static const ProtocolTileType ROCKET = const ProtocolTileType._(3, 'ROCKET');
  static const ProtocolTileType GENERATOR = const ProtocolTileType._(4, 'GENERATOR');

  static const List<ProtocolTileType> values = const <ProtocolTileType> [
    EMPTY,
    ARROW,
    PIT,
    ROCKET,
    GENERATOR,
  ];

  static final Map<int, ProtocolTileType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProtocolTileType valueOf(int value) => _byValue[value];

  const ProtocolTileType._(int v, String n) : super(v, n);
}

class ProtocolEntityType extends $pb.ProtobufEnum {
  static const ProtocolEntityType CAT = const ProtocolEntityType._(0, 'CAT');
  static const ProtocolEntityType MOUSE = const ProtocolEntityType._(1, 'MOUSE');
  static const ProtocolEntityType GOLDEN_MOUSE = const ProtocolEntityType._(2, 'GOLDEN_MOUSE');
  static const ProtocolEntityType SPECIAL_MOUSE = const ProtocolEntityType._(3, 'SPECIAL_MOUSE');

  static const List<ProtocolEntityType> values = const <ProtocolEntityType> [
    CAT,
    MOUSE,
    GOLDEN_MOUSE,
    SPECIAL_MOUSE,
  ];

  static final Map<int, ProtocolEntityType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProtocolEntityType valueOf(int value) => _byValue[value];

  const ProtocolEntityType._(int v, String n) : super(v, n);
}

class ProtocolGameEvent extends $pb.ProtobufEnum {
  static const ProtocolGameEvent NO_EVENT = const ProtocolGameEvent._(0, 'NO_EVENT');
  static const ProtocolGameEvent MOUSE_MANIA = const ProtocolGameEvent._(1, 'MOUSE_MANIA');
  static const ProtocolGameEvent CAT_MANIA = const ProtocolGameEvent._(2, 'CAT_MANIA');
  static const ProtocolGameEvent SPEED_UP = const ProtocolGameEvent._(3, 'SPEED_UP');
  static const ProtocolGameEvent SLOW_DOWN = const ProtocolGameEvent._(4, 'SLOW_DOWN');
  static const ProtocolGameEvent PLACE_AGAIN = const ProtocolGameEvent._(5, 'PLACE_AGAIN');
  static const ProtocolGameEvent CAT_ATTACK = const ProtocolGameEvent._(6, 'CAT_ATTACK');
  static const ProtocolGameEvent MOUSE_MONOPOLY = const ProtocolGameEvent._(7, 'MOUSE_MONOPOLY');

  static const List<ProtocolGameEvent> values = const <ProtocolGameEvent> [
    NO_EVENT,
    MOUSE_MANIA,
    CAT_MANIA,
    SPEED_UP,
    SLOW_DOWN,
    PLACE_AGAIN,
    CAT_ATTACK,
    MOUSE_MONOPOLY,
  ];

  static final Map<int, ProtocolGameEvent> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProtocolGameEvent valueOf(int value) => _byValue[value];

  const ProtocolGameEvent._(int v, String n) : super(v, n);
}

