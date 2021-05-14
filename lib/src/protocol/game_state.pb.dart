///
//  Generated code. Do not modify.
//  source: game_state.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'game_state.pbenum.dart';

export 'game_state.pbenum.dart';

class Tile extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tile', createEmptyInstance: create)
    ..e<TileType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: TileType.EMPTY, valueOf: TileType.valueOf, enumValues: TileType.values)
    ..e<Direction>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: Direction.RIGHT, valueOf: Direction.valueOf, enumValues: Direction.values)
    ..e<PlayerColor>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'owner', $pb.PbFieldType.OE, defaultOrMaker: PlayerColor.BLUE, valueOf: PlayerColor.valueOf, enumValues: PlayerColor.values)
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'damagedOrDeparted', protoName: 'damagedOrDeparted')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiration', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  Tile._() : super();
  factory Tile() => create();
  factory Tile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tile clone() => Tile()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tile copyWith(void Function(Tile) updates) => super.copyWith((message) => updates(message as Tile)) as Tile; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tile create() => Tile._();
  Tile createEmptyInstance() => create();
  static $pb.PbList<Tile> createRepeated() => $pb.PbList<Tile>();
  @$core.pragma('dart2js:noInline')
  static Tile getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tile>(create);
  static Tile? _defaultInstance;

  @$pb.TagNumber(1)
  TileType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(TileType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  Direction get direction => $_getN(1);
  @$pb.TagNumber(2)
  set direction(Direction v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDirection() => $_has(1);
  @$pb.TagNumber(2)
  void clearDirection() => clearField(2);

  @$pb.TagNumber(3)
  PlayerColor get owner => $_getN(2);
  @$pb.TagNumber(3)
  set owner(PlayerColor v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOwner() => $_has(2);
  @$pb.TagNumber(3)
  void clearOwner() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get damagedOrDeparted => $_getBF(3);
  @$pb.TagNumber(4)
  set damagedOrDeparted($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDamagedOrDeparted() => $_has(3);
  @$pb.TagNumber(4)
  void clearDamagedOrDeparted() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get expiration => $_getIZ(4);
  @$pb.TagNumber(5)
  set expiration($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasExpiration() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiration() => clearField(5);
}

class Board extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Board', createEmptyInstance: create)
    ..pc<Wall>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'walls', $pb.PbFieldType.PE, valueOf: Wall.valueOf, enumValues: Wall.values)
    ..pc<Tile>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tiles', $pb.PbFieldType.PM, subBuilder: Tile.create)
    ..hasRequiredFields = false
  ;

  Board._() : super();
  factory Board() => create();
  factory Board.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Board.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Board clone() => Board()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Board copyWith(void Function(Board) updates) => super.copyWith((message) => updates(message as Board)) as Board; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Board create() => Board._();
  Board createEmptyInstance() => create();
  static $pb.PbList<Board> createRepeated() => $pb.PbList<Board>();
  @$core.pragma('dart2js:noInline')
  static Board getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Board>(create);
  static Board? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Wall> get walls => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<Tile> get tiles => $_getList(1);
}

class Entity extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Entity', createEmptyInstance: create)
    ..e<EntityType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: EntityType.CAT, valueOf: EntityType.valueOf, enumValues: EntityType.values)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'step', $pb.PbFieldType.OU3)
    ..e<Direction>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: Direction.RIGHT, valueOf: Direction.valueOf, enumValues: Direction.values)
    ..hasRequiredFields = false
  ;

  Entity._() : super();
  factory Entity() => create();
  factory Entity.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Entity.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Entity clone() => Entity()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Entity copyWith(void Function(Entity) updates) => super.copyWith((message) => updates(message as Entity)) as Entity; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Entity create() => Entity._();
  Entity createEmptyInstance() => create();
  static $pb.PbList<Entity> createRepeated() => $pb.PbList<Entity>();
  @$core.pragma('dart2js:noInline')
  static Entity getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Entity>(create);
  static Entity? _defaultInstance;

  @$pb.TagNumber(1)
  EntityType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(EntityType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get x => $_getIZ(1);
  @$pb.TagNumber(2)
  set x($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasX() => $_has(1);
  @$pb.TagNumber(2)
  void clearX() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get y => $_getIZ(2);
  @$pb.TagNumber(3)
  set y($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasY() => $_has(2);
  @$pb.TagNumber(3)
  void clearY() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get step => $_getIZ(3);
  @$pb.TagNumber(4)
  set step($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStep() => $_has(3);
  @$pb.TagNumber(4)
  void clearStep() => clearField(4);

  @$pb.TagNumber(5)
  Direction get direction => $_getN(4);
  @$pb.TagNumber(5)
  set direction(Direction v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDirection() => $_has(4);
  @$pb.TagNumber(5)
  void clearDirection() => clearField(5);
}

class GameState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GameState', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tickCount', $pb.PbFieldType.OU3, protoName: 'tickCount')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'pauseUntil', $pb.PbFieldType.OU3, protoName: 'pauseUntil')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'eventEnd', $pb.PbFieldType.OU3, protoName: 'eventEnd')
    ..aOM<Board>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'board', subBuilder: Board.create)
    ..pc<Entity>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cats', $pb.PbFieldType.PM, subBuilder: Entity.create)
    ..pc<Entity>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mice', $pb.PbFieldType.PM, subBuilder: Entity.create)
    ..p<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scores', $pb.PbFieldType.PU3)
    ..a<$fixnum.Int64>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rngState', $pb.PbFieldType.OU6, protoName: 'rngState', defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<GameEvent>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'event', $pb.PbFieldType.OE, defaultOrMaker: GameEvent.NO_EVENT, valueOf: GameEvent.valueOf, enumValues: GameEvent.values)
    ..hasRequiredFields = false
  ;

  GameState._() : super();
  factory GameState() => create();
  factory GameState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GameState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GameState clone() => GameState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GameState copyWith(void Function(GameState) updates) => super.copyWith((message) => updates(message as GameState)) as GameState; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GameState create() => GameState._();
  GameState createEmptyInstance() => create();
  static $pb.PbList<GameState> createRepeated() => $pb.PbList<GameState>();
  @$core.pragma('dart2js:noInline')
  static GameState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GameState>(create);
  static GameState? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get tickCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set tickCount($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTickCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearTickCount() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get pauseUntil => $_getIZ(1);
  @$pb.TagNumber(2)
  set pauseUntil($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPauseUntil() => $_has(1);
  @$pb.TagNumber(2)
  void clearPauseUntil() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get eventEnd => $_getIZ(2);
  @$pb.TagNumber(3)
  set eventEnd($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEventEnd() => $_has(2);
  @$pb.TagNumber(3)
  void clearEventEnd() => clearField(3);

  @$pb.TagNumber(4)
  Board get board => $_getN(3);
  @$pb.TagNumber(4)
  set board(Board v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasBoard() => $_has(3);
  @$pb.TagNumber(4)
  void clearBoard() => clearField(4);
  @$pb.TagNumber(4)
  Board ensureBoard() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.List<Entity> get cats => $_getList(4);

  @$pb.TagNumber(6)
  $core.List<Entity> get mice => $_getList(5);

  @$pb.TagNumber(7)
  $core.List<$core.int> get scores => $_getList(6);

  @$pb.TagNumber(8)
  $fixnum.Int64 get rngState => $_getI64(7);
  @$pb.TagNumber(8)
  set rngState($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRngState() => $_has(7);
  @$pb.TagNumber(8)
  void clearRngState() => clearField(8);

  @$pb.TagNumber(9)
  GameEvent get event => $_getN(8);
  @$pb.TagNumber(9)
  set event(GameEvent v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasEvent() => $_has(8);
  @$pb.TagNumber(9)
  void clearEvent() => clearField(9);
}

