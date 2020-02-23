///
//  Generated code. Do not modify.
//  source: game_state.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'game_state.pbenum.dart';

export 'game_state.pbenum.dart';

class Tile extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Tile', createEmptyInstance: create)
    ..e<TileType>(1, 'type', $pb.PbFieldType.OE, defaultOrMaker: TileType.EMPTY, valueOf: TileType.valueOf, enumValues: TileType.values)
    ..e<Direction>(2, 'direction', $pb.PbFieldType.OE, defaultOrMaker: Direction.RIGHT, valueOf: Direction.valueOf, enumValues: Direction.values)
    ..e<PlayerColor>(3, 'owner', $pb.PbFieldType.OE, defaultOrMaker: PlayerColor.BLUE, valueOf: PlayerColor.valueOf, enumValues: PlayerColor.values)
    ..aOB(4, 'damagedOrDeparted', protoName: 'damagedOrDeparted')
    ..hasRequiredFields = false
  ;

  Tile._() : super();
  factory Tile() => create();
  factory Tile.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tile.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Tile clone() => Tile()..mergeFromMessage(this);
  Tile copyWith(void Function(Tile) updates) => super.copyWith((message) => updates(message as Tile));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tile create() => Tile._();
  Tile createEmptyInstance() => create();
  static $pb.PbList<Tile> createRepeated() => $pb.PbList<Tile>();
  @$core.pragma('dart2js:noInline')
  static Tile getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tile>(create);
  static Tile _defaultInstance;

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
}

class Board extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Board', createEmptyInstance: create)
    ..pc<Wall>(1, 'walls', $pb.PbFieldType.PE, valueOf: Wall.valueOf, enumValues: Wall.values)
    ..pc<Tile>(2, 'tiles', $pb.PbFieldType.PM, subBuilder: Tile.create)
    ..hasRequiredFields = false
  ;

  Board._() : super();
  factory Board() => create();
  factory Board.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Board.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Board clone() => Board()..mergeFromMessage(this);
  Board copyWith(void Function(Board) updates) => super.copyWith((message) => updates(message as Board));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Board create() => Board._();
  Board createEmptyInstance() => create();
  static $pb.PbList<Board> createRepeated() => $pb.PbList<Board>();
  @$core.pragma('dart2js:noInline')
  static Board getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Board>(create);
  static Board _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Wall> get walls => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<Tile> get tiles => $_getList(1);
}

class Entity extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Entity', createEmptyInstance: create)
    ..e<EntityType>(1, 'type', $pb.PbFieldType.OE, defaultOrMaker: EntityType.CAT, valueOf: EntityType.valueOf, enumValues: EntityType.values)
    ..a<$core.int>(2, 'x', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, 'y', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, 'step', $pb.PbFieldType.OU3)
    ..e<Direction>(5, 'direction', $pb.PbFieldType.OE, defaultOrMaker: Direction.RIGHT, valueOf: Direction.valueOf, enumValues: Direction.values)
    ..hasRequiredFields = false
  ;

  Entity._() : super();
  factory Entity() => create();
  factory Entity.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Entity.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Entity clone() => Entity()..mergeFromMessage(this);
  Entity copyWith(void Function(Entity) updates) => super.copyWith((message) => updates(message as Entity));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Entity create() => Entity._();
  Entity createEmptyInstance() => create();
  static $pb.PbList<Entity> createRepeated() => $pb.PbList<Entity>();
  @$core.pragma('dart2js:noInline')
  static Entity getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Entity>(create);
  static Entity _defaultInstance;

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

class XorShiftState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('XorShiftState', createEmptyInstance: create)
    ..a<$core.int>(1, 'a', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, 'b', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, 'c', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, 'd', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  XorShiftState._() : super();
  factory XorShiftState() => create();
  factory XorShiftState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory XorShiftState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  XorShiftState clone() => XorShiftState()..mergeFromMessage(this);
  XorShiftState copyWith(void Function(XorShiftState) updates) => super.copyWith((message) => updates(message as XorShiftState));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static XorShiftState create() => XorShiftState._();
  XorShiftState createEmptyInstance() => create();
  static $pb.PbList<XorShiftState> createRepeated() => $pb.PbList<XorShiftState>();
  @$core.pragma('dart2js:noInline')
  static XorShiftState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<XorShiftState>(create);
  static XorShiftState _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get a => $_getIZ(0);
  @$pb.TagNumber(1)
  set a($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasA() => $_has(0);
  @$pb.TagNumber(1)
  void clearA() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get b => $_getIZ(1);
  @$pb.TagNumber(2)
  set b($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasB() => $_has(1);
  @$pb.TagNumber(2)
  void clearB() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get c => $_getIZ(2);
  @$pb.TagNumber(3)
  set c($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasC() => $_has(2);
  @$pb.TagNumber(3)
  void clearC() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get d => $_getIZ(3);
  @$pb.TagNumber(4)
  set d($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasD() => $_has(3);
  @$pb.TagNumber(4)
  void clearD() => clearField(4);
}

class GameState extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GameState', createEmptyInstance: create)
    ..a<$core.int>(1, 'tickCount', $pb.PbFieldType.OU3, protoName: 'tickCount')
    ..aOM<Board>(2, 'board', subBuilder: Board.create)
    ..pc<Entity>(3, 'cats', $pb.PbFieldType.PM, subBuilder: Entity.create)
    ..pc<Entity>(4, 'mice', $pb.PbFieldType.PM, subBuilder: Entity.create)
    ..p<$core.int>(5, 'scores', $pb.PbFieldType.PU3)
    ..aOM<XorShiftState>(6, 'rngState', protoName: 'rngState', subBuilder: XorShiftState.create)
    ..e<GameEvent>(7, 'event', $pb.PbFieldType.OE, defaultOrMaker: GameEvent.NO_EVENT, valueOf: GameEvent.valueOf, enumValues: GameEvent.values)
    ..hasRequiredFields = false
  ;

  GameState._() : super();
  factory GameState() => create();
  factory GameState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GameState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  GameState clone() => GameState()..mergeFromMessage(this);
  GameState copyWith(void Function(GameState) updates) => super.copyWith((message) => updates(message as GameState));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GameState create() => GameState._();
  GameState createEmptyInstance() => create();
  static $pb.PbList<GameState> createRepeated() => $pb.PbList<GameState>();
  @$core.pragma('dart2js:noInline')
  static GameState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GameState>(create);
  static GameState _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get tickCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set tickCount($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTickCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearTickCount() => clearField(1);

  @$pb.TagNumber(2)
  Board get board => $_getN(1);
  @$pb.TagNumber(2)
  set board(Board v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasBoard() => $_has(1);
  @$pb.TagNumber(2)
  void clearBoard() => clearField(2);
  @$pb.TagNumber(2)
  Board ensureBoard() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<Entity> get cats => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<Entity> get mice => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<$core.int> get scores => $_getList(4);

  @$pb.TagNumber(6)
  XorShiftState get rngState => $_getN(5);
  @$pb.TagNumber(6)
  set rngState(XorShiftState v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasRngState() => $_has(5);
  @$pb.TagNumber(6)
  void clearRngState() => clearField(6);
  @$pb.TagNumber(6)
  XorShiftState ensureRngState() => $_ensure(5);

  @$pb.TagNumber(7)
  GameEvent get event => $_getN(6);
  @$pb.TagNumber(7)
  set event(GameEvent v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasEvent() => $_has(6);
  @$pb.TagNumber(7)
  void clearEvent() => clearField(7);
}

