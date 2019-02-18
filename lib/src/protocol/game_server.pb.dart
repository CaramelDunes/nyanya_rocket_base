///
//  Generated code. Do not modify.
//  source: game_server.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

// ignore: UNUSED_SHOWN_NAME
import 'dart:core' show int, bool, double, String, List, Map, override;

import 'package:protobuf/protobuf.dart' as $pb;

import 'game_server.pbenum.dart';

export 'game_server.pbenum.dart';

class PlaceArrowMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('PlaceArrowMessage')
    ..a<int>(1, 'x', $pb.PbFieldType.OU3)
    ..a<int>(2, 'y', $pb.PbFieldType.OU3)
    ..e<ProtocolDirection>(3, 'direction', $pb.PbFieldType.OE, ProtocolDirection.RIGHT, ProtocolDirection.valueOf, ProtocolDirection.values)
    ..hasRequiredFields = false
  ;

  PlaceArrowMessage() : super();
  PlaceArrowMessage.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  PlaceArrowMessage.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  PlaceArrowMessage clone() => new PlaceArrowMessage()..mergeFromMessage(this);
  PlaceArrowMessage copyWith(void Function(PlaceArrowMessage) updates) => super.copyWith((message) => updates(message as PlaceArrowMessage));
  $pb.BuilderInfo get info_ => _i;
  static PlaceArrowMessage create() => new PlaceArrowMessage();
  PlaceArrowMessage createEmptyInstance() => create();
  static $pb.PbList<PlaceArrowMessage> createRepeated() => new $pb.PbList<PlaceArrowMessage>();
  static PlaceArrowMessage getDefault() => _defaultInstance ??= create()..freeze();
  static PlaceArrowMessage _defaultInstance;
  static void $checkItem(PlaceArrowMessage v) {
    if (v is! PlaceArrowMessage) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  int get x => $_get(0, 0);
  set x(int v) { $_setUnsignedInt32(0, v); }
  bool hasX() => $_has(0);
  void clearX() => clearField(1);

  int get y => $_get(1, 0);
  set y(int v) { $_setUnsignedInt32(1, v); }
  bool hasY() => $_has(1);
  void clearY() => clearField(2);

  ProtocolDirection get direction => $_getN(2);
  set direction(ProtocolDirection v) { setField(3, v); }
  bool hasDirection() => $_has(2);
  void clearDirection() => clearField(3);
}

class RegisterMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('RegisterMessage')
    ..aOS(1, 'nickname')
    ..hasRequiredFields = false
  ;

  RegisterMessage() : super();
  RegisterMessage.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RegisterMessage.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RegisterMessage clone() => new RegisterMessage()..mergeFromMessage(this);
  RegisterMessage copyWith(void Function(RegisterMessage) updates) => super.copyWith((message) => updates(message as RegisterMessage));
  $pb.BuilderInfo get info_ => _i;
  static RegisterMessage create() => new RegisterMessage();
  RegisterMessage createEmptyInstance() => create();
  static $pb.PbList<RegisterMessage> createRepeated() => new $pb.PbList<RegisterMessage>();
  static RegisterMessage getDefault() => _defaultInstance ??= create()..freeze();
  static RegisterMessage _defaultInstance;
  static void $checkItem(RegisterMessage v) {
    if (v is! RegisterMessage) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  String get nickname => $_getS(0, '');
  set nickname(String v) { $_setString(0, v); }
  bool hasNickname() => $_has(0);
  void clearNickname() => clearField(1);
}

class RegisterSuccessMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('RegisterSuccessMessage')
    ..e<ProtocolPlayerColor>(1, 'givenColor', $pb.PbFieldType.OE, ProtocolPlayerColor.BLUE, ProtocolPlayerColor.valueOf, ProtocolPlayerColor.values)
    ..aOS(2, 'nickname')
    ..hasRequiredFields = false
  ;

  RegisterSuccessMessage() : super();
  RegisterSuccessMessage.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  RegisterSuccessMessage.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  RegisterSuccessMessage clone() => new RegisterSuccessMessage()..mergeFromMessage(this);
  RegisterSuccessMessage copyWith(void Function(RegisterSuccessMessage) updates) => super.copyWith((message) => updates(message as RegisterSuccessMessage));
  $pb.BuilderInfo get info_ => _i;
  static RegisterSuccessMessage create() => new RegisterSuccessMessage();
  RegisterSuccessMessage createEmptyInstance() => create();
  static $pb.PbList<RegisterSuccessMessage> createRepeated() => new $pb.PbList<RegisterSuccessMessage>();
  static RegisterSuccessMessage getDefault() => _defaultInstance ??= create()..freeze();
  static RegisterSuccessMessage _defaultInstance;
  static void $checkItem(RegisterSuccessMessage v) {
    if (v is! RegisterSuccessMessage) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  ProtocolPlayerColor get givenColor => $_getN(0);
  set givenColor(ProtocolPlayerColor v) { setField(1, v); }
  bool hasGivenColor() => $_has(0);
  void clearGivenColor() => clearField(1);

  String get nickname => $_getS(1, '');
  set nickname(String v) { $_setString(1, v); }
  bool hasNickname() => $_has(1);
  void clearNickname() => clearField(2);
}

class ProtocolTile extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('ProtocolTile')
    ..e<ProtocolTileType>(1, 'type', $pb.PbFieldType.OE, ProtocolTileType.EMPTY, ProtocolTileType.valueOf, ProtocolTileType.values)
    ..e<ProtocolDirection>(2, 'direction', $pb.PbFieldType.OE, ProtocolDirection.RIGHT, ProtocolDirection.valueOf, ProtocolDirection.values)
    ..e<ProtocolPlayerColor>(3, 'owner', $pb.PbFieldType.OE, ProtocolPlayerColor.BLUE, ProtocolPlayerColor.valueOf, ProtocolPlayerColor.values)
    ..aOB(4, 'damagedOrDeparted')
    ..hasRequiredFields = false
  ;

  ProtocolTile() : super();
  ProtocolTile.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ProtocolTile.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ProtocolTile clone() => new ProtocolTile()..mergeFromMessage(this);
  ProtocolTile copyWith(void Function(ProtocolTile) updates) => super.copyWith((message) => updates(message as ProtocolTile));
  $pb.BuilderInfo get info_ => _i;
  static ProtocolTile create() => new ProtocolTile();
  ProtocolTile createEmptyInstance() => create();
  static $pb.PbList<ProtocolTile> createRepeated() => new $pb.PbList<ProtocolTile>();
  static ProtocolTile getDefault() => _defaultInstance ??= create()..freeze();
  static ProtocolTile _defaultInstance;
  static void $checkItem(ProtocolTile v) {
    if (v is! ProtocolTile) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  ProtocolTileType get type => $_getN(0);
  set type(ProtocolTileType v) { setField(1, v); }
  bool hasType() => $_has(0);
  void clearType() => clearField(1);

  ProtocolDirection get direction => $_getN(1);
  set direction(ProtocolDirection v) { setField(2, v); }
  bool hasDirection() => $_has(1);
  void clearDirection() => clearField(2);

  ProtocolPlayerColor get owner => $_getN(2);
  set owner(ProtocolPlayerColor v) { setField(3, v); }
  bool hasOwner() => $_has(2);
  void clearOwner() => clearField(3);

  bool get damagedOrDeparted => $_get(3, false);
  set damagedOrDeparted(bool v) { $_setBool(3, v); }
  bool hasDamagedOrDeparted() => $_has(3);
  void clearDamagedOrDeparted() => clearField(4);
}

class ProtocolBoard extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('ProtocolBoard')
    ..pp<ProtocolWall>(1, 'walls', $pb.PbFieldType.PE, ProtocolWall.$checkItem, null, ProtocolWall.valueOf, ProtocolWall.values)
    ..pp<ProtocolTile>(2, 'tiles', $pb.PbFieldType.PM, ProtocolTile.$checkItem, ProtocolTile.create)
    ..hasRequiredFields = false
  ;

  ProtocolBoard() : super();
  ProtocolBoard.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ProtocolBoard.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ProtocolBoard clone() => new ProtocolBoard()..mergeFromMessage(this);
  ProtocolBoard copyWith(void Function(ProtocolBoard) updates) => super.copyWith((message) => updates(message as ProtocolBoard));
  $pb.BuilderInfo get info_ => _i;
  static ProtocolBoard create() => new ProtocolBoard();
  ProtocolBoard createEmptyInstance() => create();
  static $pb.PbList<ProtocolBoard> createRepeated() => new $pb.PbList<ProtocolBoard>();
  static ProtocolBoard getDefault() => _defaultInstance ??= create()..freeze();
  static ProtocolBoard _defaultInstance;
  static void $checkItem(ProtocolBoard v) {
    if (v is! ProtocolBoard) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  List<ProtocolWall> get walls => $_getList(0);

  List<ProtocolTile> get tiles => $_getList(1);
}

class ProtocolEntity extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('ProtocolEntity')
    ..e<ProtocolEntityType>(1, 'type', $pb.PbFieldType.OE, ProtocolEntityType.CAT, ProtocolEntityType.valueOf, ProtocolEntityType.values)
    ..a<int>(2, 'x', $pb.PbFieldType.OU3)
    ..a<int>(3, 'y', $pb.PbFieldType.OU3)
    ..a<int>(4, 'step', $pb.PbFieldType.OU3)
    ..e<ProtocolDirection>(5, 'direction', $pb.PbFieldType.OE, ProtocolDirection.RIGHT, ProtocolDirection.valueOf, ProtocolDirection.values)
    ..hasRequiredFields = false
  ;

  ProtocolEntity() : super();
  ProtocolEntity.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ProtocolEntity.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ProtocolEntity clone() => new ProtocolEntity()..mergeFromMessage(this);
  ProtocolEntity copyWith(void Function(ProtocolEntity) updates) => super.copyWith((message) => updates(message as ProtocolEntity));
  $pb.BuilderInfo get info_ => _i;
  static ProtocolEntity create() => new ProtocolEntity();
  ProtocolEntity createEmptyInstance() => create();
  static $pb.PbList<ProtocolEntity> createRepeated() => new $pb.PbList<ProtocolEntity>();
  static ProtocolEntity getDefault() => _defaultInstance ??= create()..freeze();
  static ProtocolEntity _defaultInstance;
  static void $checkItem(ProtocolEntity v) {
    if (v is! ProtocolEntity) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  ProtocolEntityType get type => $_getN(0);
  set type(ProtocolEntityType v) { setField(1, v); }
  bool hasType() => $_has(0);
  void clearType() => clearField(1);

  int get x => $_get(1, 0);
  set x(int v) { $_setUnsignedInt32(1, v); }
  bool hasX() => $_has(1);
  void clearX() => clearField(2);

  int get y => $_get(2, 0);
  set y(int v) { $_setUnsignedInt32(2, v); }
  bool hasY() => $_has(2);
  void clearY() => clearField(3);

  int get step => $_get(3, 0);
  set step(int v) { $_setUnsignedInt32(3, v); }
  bool hasStep() => $_has(3);
  void clearStep() => clearField(4);

  ProtocolDirection get direction => $_getN(4);
  set direction(ProtocolDirection v) { setField(5, v); }
  bool hasDirection() => $_has(4);
  void clearDirection() => clearField(5);
}

class ProtocolGame extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = new $pb.BuilderInfo('ProtocolGame')
    ..a<int>(1, 'timestamp', $pb.PbFieldType.OU3)
    ..a<ProtocolBoard>(2, 'board', $pb.PbFieldType.OM, ProtocolBoard.getDefault, ProtocolBoard.create)
    ..pp<ProtocolEntity>(3, 'entities', $pb.PbFieldType.PM, ProtocolEntity.$checkItem, ProtocolEntity.create)
    ..p<int>(4, 'scores', $pb.PbFieldType.PU3)
    ..hasRequiredFields = false
  ;

  ProtocolGame() : super();
  ProtocolGame.fromBuffer(List<int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ProtocolGame.fromJson(String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ProtocolGame clone() => new ProtocolGame()..mergeFromMessage(this);
  ProtocolGame copyWith(void Function(ProtocolGame) updates) => super.copyWith((message) => updates(message as ProtocolGame));
  $pb.BuilderInfo get info_ => _i;
  static ProtocolGame create() => new ProtocolGame();
  ProtocolGame createEmptyInstance() => create();
  static $pb.PbList<ProtocolGame> createRepeated() => new $pb.PbList<ProtocolGame>();
  static ProtocolGame getDefault() => _defaultInstance ??= create()..freeze();
  static ProtocolGame _defaultInstance;
  static void $checkItem(ProtocolGame v) {
    if (v is! ProtocolGame) $pb.checkItemFailed(v, _i.qualifiedMessageName);
  }

  int get timestamp => $_get(0, 0);
  set timestamp(int v) { $_setUnsignedInt32(0, v); }
  bool hasTimestamp() => $_has(0);
  void clearTimestamp() => clearField(1);

  ProtocolBoard get board => $_getN(1);
  set board(ProtocolBoard v) { setField(2, v); }
  bool hasBoard() => $_has(1);
  void clearBoard() => clearField(2);

  List<ProtocolEntity> get entities => $_getList(2);

  List<int> get scores => $_getList(3);
}

