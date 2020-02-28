///
//  Generated code. Do not modify.
//  source: game_state.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Direction extends $pb.ProtobufEnum {
  static const Direction RIGHT = Direction._(0, 'RIGHT');
  static const Direction UP = Direction._(1, 'UP');
  static const Direction LEFT = Direction._(2, 'LEFT');
  static const Direction DOWN = Direction._(3, 'DOWN');

  static const $core.List<Direction> values = <Direction> [
    RIGHT,
    UP,
    LEFT,
    DOWN,
  ];

  static final $core.Map<$core.int, Direction> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Direction valueOf($core.int value) => _byValue[value];

  const Direction._($core.int v, $core.String n) : super(v, n);
}

class PlayerColor extends $pb.ProtobufEnum {
  static const PlayerColor BLUE = PlayerColor._(0, 'BLUE');
  static const PlayerColor YELLOW = PlayerColor._(1, 'YELLOW');
  static const PlayerColor RED = PlayerColor._(2, 'RED');
  static const PlayerColor GREEN = PlayerColor._(3, 'GREEN');

  static const $core.List<PlayerColor> values = <PlayerColor> [
    BLUE,
    YELLOW,
    RED,
    GREEN,
  ];

  static final $core.Map<$core.int, PlayerColor> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PlayerColor valueOf($core.int value) => _byValue[value];

  const PlayerColor._($core.int v, $core.String n) : super(v, n);
}

class Wall extends $pb.ProtobufEnum {
  static const Wall NONE = Wall._(0, 'NONE');
  static const Wall LEFT_ONLY = Wall._(1, 'LEFT_ONLY');
  static const Wall UP_ONLY = Wall._(2, 'UP_ONLY');
  static const Wall LEFT_UP = Wall._(3, 'LEFT_UP');

  static const $core.List<Wall> values = <Wall> [
    NONE,
    LEFT_ONLY,
    UP_ONLY,
    LEFT_UP,
  ];

  static final $core.Map<$core.int, Wall> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Wall valueOf($core.int value) => _byValue[value];

  const Wall._($core.int v, $core.String n) : super(v, n);
}

class TileType extends $pb.ProtobufEnum {
  static const TileType EMPTY = TileType._(0, 'EMPTY');
  static const TileType ARROW = TileType._(1, 'ARROW');
  static const TileType PIT = TileType._(2, 'PIT');
  static const TileType ROCKET = TileType._(3, 'ROCKET');
  static const TileType GENERATOR = TileType._(4, 'GENERATOR');

  static const $core.List<TileType> values = <TileType> [
    EMPTY,
    ARROW,
    PIT,
    ROCKET,
    GENERATOR,
  ];

  static final $core.Map<$core.int, TileType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TileType valueOf($core.int value) => _byValue[value];

  const TileType._($core.int v, $core.String n) : super(v, n);
}

class EntityType extends $pb.ProtobufEnum {
  static const EntityType CAT = EntityType._(0, 'CAT');
  static const EntityType MOUSE = EntityType._(1, 'MOUSE');
  static const EntityType GOLDEN_MOUSE = EntityType._(2, 'GOLDEN_MOUSE');
  static const EntityType SPECIAL_MOUSE = EntityType._(3, 'SPECIAL_MOUSE');

  static const $core.List<EntityType> values = <EntityType> [
    CAT,
    MOUSE,
    GOLDEN_MOUSE,
    SPECIAL_MOUSE,
  ];

  static final $core.Map<$core.int, EntityType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static EntityType valueOf($core.int value) => _byValue[value];

  const EntityType._($core.int v, $core.String n) : super(v, n);
}

class GameEvent extends $pb.ProtobufEnum {
  static const GameEvent NO_EVENT = GameEvent._(0, 'NO_EVENT');
  static const GameEvent MOUSE_MANIA = GameEvent._(1, 'MOUSE_MANIA');
  static const GameEvent CAT_MANIA = GameEvent._(2, 'CAT_MANIA');
  static const GameEvent SPEED_UP = GameEvent._(3, 'SPEED_UP');
  static const GameEvent SLOW_DOWN = GameEvent._(4, 'SLOW_DOWN');
  static const GameEvent PLACE_AGAIN = GameEvent._(5, 'PLACE_AGAIN');
  static const GameEvent CAT_ATTACK = GameEvent._(6, 'CAT_ATTACK');
  static const GameEvent MOUSE_MONOPOLY = GameEvent._(7, 'MOUSE_MONOPOLY');
  static const GameEvent EVERYBODY_MOVE = GameEvent._(8, 'EVERYBODY_MOVE');

  static const $core.List<GameEvent> values = <GameEvent> [
    NO_EVENT,
    MOUSE_MANIA,
    CAT_MANIA,
    SPEED_UP,
    SLOW_DOWN,
    PLACE_AGAIN,
    CAT_ATTACK,
    MOUSE_MONOPOLY,
    EVERYBODY_MOVE,
  ];

  static final $core.Map<$core.int, GameEvent> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GameEvent valueOf($core.int value) => _byValue[value];

  const GameEvent._($core.int v, $core.String n) : super(v, n);
}

