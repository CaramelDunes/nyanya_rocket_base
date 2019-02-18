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
  static void $checkItem(ProtocolDirection v) {
    if (v is! ProtocolDirection) $pb.checkItemFailed(v, 'ProtocolDirection');
  }

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
  static void $checkItem(ProtocolPlayerColor v) {
    if (v is! ProtocolPlayerColor) $pb.checkItemFailed(v, 'ProtocolPlayerColor');
  }

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
  static void $checkItem(ProtocolWall v) {
    if (v is! ProtocolWall) $pb.checkItemFailed(v, 'ProtocolWall');
  }

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
  static void $checkItem(ProtocolTileType v) {
    if (v is! ProtocolTileType) $pb.checkItemFailed(v, 'ProtocolTileType');
  }

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
  static void $checkItem(ProtocolEntityType v) {
    if (v is! ProtocolEntityType) $pb.checkItemFailed(v, 'ProtocolEntityType');
  }

  const ProtocolEntityType._(int v, String n) : super(v, n);
}

