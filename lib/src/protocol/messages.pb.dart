///
//  Generated code. Do not modify.
//  source: messages.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'game_state.pb.dart' as $0;

import 'game_state.pbenum.dart' as $0;

class PlaceArrowMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PlaceArrowMessage', createEmptyInstance: create)
    ..a<$core.int>(1, 'x', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, 'y', $pb.PbFieldType.OU3)
    ..e<$0.Direction>(3, 'direction', $pb.PbFieldType.OE, defaultOrMaker: $0.Direction.RIGHT, valueOf: $0.Direction.valueOf, enumValues: $0.Direction.values)
    ..hasRequiredFields = false
  ;

  PlaceArrowMessage._() : super();
  factory PlaceArrowMessage() => create();
  factory PlaceArrowMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlaceArrowMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PlaceArrowMessage clone() => PlaceArrowMessage()..mergeFromMessage(this);
  PlaceArrowMessage copyWith(void Function(PlaceArrowMessage) updates) => super.copyWith((message) => updates(message as PlaceArrowMessage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PlaceArrowMessage create() => PlaceArrowMessage._();
  PlaceArrowMessage createEmptyInstance() => create();
  static $pb.PbList<PlaceArrowMessage> createRepeated() => $pb.PbList<PlaceArrowMessage>();
  @$core.pragma('dart2js:noInline')
  static PlaceArrowMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlaceArrowMessage>(create);
  static PlaceArrowMessage _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get x => $_getIZ(0);
  @$pb.TagNumber(1)
  set x($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasX() => $_has(0);
  @$pb.TagNumber(1)
  void clearX() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get y => $_getIZ(1);
  @$pb.TagNumber(2)
  set y($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasY() => $_has(1);
  @$pb.TagNumber(2)
  void clearY() => clearField(2);

  @$pb.TagNumber(3)
  $0.Direction get direction => $_getN(2);
  @$pb.TagNumber(3)
  set direction($0.Direction v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDirection() => $_has(2);
  @$pb.TagNumber(3)
  void clearDirection() => clearField(3);
}

class RegisterMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RegisterMessage', createEmptyInstance: create)
    ..aOS(1, 'nickname')
    ..a<$core.int>(2, 'ticket', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  RegisterMessage._() : super();
  factory RegisterMessage() => create();
  factory RegisterMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RegisterMessage clone() => RegisterMessage()..mergeFromMessage(this);
  RegisterMessage copyWith(void Function(RegisterMessage) updates) => super.copyWith((message) => updates(message as RegisterMessage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegisterMessage create() => RegisterMessage._();
  RegisterMessage createEmptyInstance() => create();
  static $pb.PbList<RegisterMessage> createRepeated() => $pb.PbList<RegisterMessage>();
  @$core.pragma('dart2js:noInline')
  static RegisterMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterMessage>(create);
  static RegisterMessage _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get nickname => $_getSZ(0);
  @$pb.TagNumber(1)
  set nickname($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNickname() => $_has(0);
  @$pb.TagNumber(1)
  void clearNickname() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get ticket => $_getIZ(1);
  @$pb.TagNumber(2)
  set ticket($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTicket() => $_has(1);
  @$pb.TagNumber(2)
  void clearTicket() => clearField(2);
}

class RegisterSuccessMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('RegisterSuccessMessage', createEmptyInstance: create)
    ..e<$0.PlayerColor>(1, 'givenColor', $pb.PbFieldType.OE, protoName: 'givenColor', defaultOrMaker: $0.PlayerColor.BLUE, valueOf: $0.PlayerColor.valueOf, enumValues: $0.PlayerColor.values)
    ..hasRequiredFields = false
  ;

  RegisterSuccessMessage._() : super();
  factory RegisterSuccessMessage() => create();
  factory RegisterSuccessMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterSuccessMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  RegisterSuccessMessage clone() => RegisterSuccessMessage()..mergeFromMessage(this);
  RegisterSuccessMessage copyWith(void Function(RegisterSuccessMessage) updates) => super.copyWith((message) => updates(message as RegisterSuccessMessage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegisterSuccessMessage create() => RegisterSuccessMessage._();
  RegisterSuccessMessage createEmptyInstance() => create();
  static $pb.PbList<RegisterSuccessMessage> createRepeated() => $pb.PbList<RegisterSuccessMessage>();
  @$core.pragma('dart2js:noInline')
  static RegisterSuccessMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterSuccessMessage>(create);
  static RegisterSuccessMessage _defaultInstance;

  @$pb.TagNumber(1)
  $0.PlayerColor get givenColor => $_getN(0);
  @$pb.TagNumber(1)
  set givenColor($0.PlayerColor v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGivenColor() => $_has(0);
  @$pb.TagNumber(1)
  void clearGivenColor() => clearField(1);
}

class PlayerNicknamesMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('PlayerNicknamesMessage', createEmptyInstance: create)
    ..pPS(1, 'nicknames')
    ..hasRequiredFields = false
  ;

  PlayerNicknamesMessage._() : super();
  factory PlayerNicknamesMessage() => create();
  factory PlayerNicknamesMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayerNicknamesMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  PlayerNicknamesMessage clone() => PlayerNicknamesMessage()..mergeFromMessage(this);
  PlayerNicknamesMessage copyWith(void Function(PlayerNicknamesMessage) updates) => super.copyWith((message) => updates(message as PlayerNicknamesMessage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PlayerNicknamesMessage create() => PlayerNicknamesMessage._();
  PlayerNicknamesMessage createEmptyInstance() => create();
  static $pb.PbList<PlayerNicknamesMessage> createRepeated() => $pb.PbList<PlayerNicknamesMessage>();
  @$core.pragma('dart2js:noInline')
  static PlayerNicknamesMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerNicknamesMessage>(create);
  static PlayerNicknamesMessage _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get nicknames => $_getList(0);
}

enum Capsule_Payload {
  gameState, 
  placeArrow, 
  register, 
  registerSuccess, 
  playerNicknames, 
  notSet
}

class Capsule extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Capsule_Payload> _Capsule_PayloadByTag = {
    3 : Capsule_Payload.gameState,
    4 : Capsule_Payload.placeArrow,
    5 : Capsule_Payload.register,
    6 : Capsule_Payload.registerSuccess,
    7 : Capsule_Payload.playerNicknames,
    0 : Capsule_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Capsule', createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6, 7])
    ..a<$core.int>(1, 'protocolId', $pb.PbFieldType.OU3, protoName: 'protocolId')
    ..a<$core.int>(2, 'sequenceNumber', $pb.PbFieldType.OU3, protoName: 'sequenceNumber')
    ..aOM<$0.GameState>(3, 'gameState', protoName: 'gameState', subBuilder: $0.GameState.create)
    ..aOM<PlaceArrowMessage>(4, 'placeArrow', protoName: 'placeArrow', subBuilder: PlaceArrowMessage.create)
    ..aOM<RegisterMessage>(5, 'register', subBuilder: RegisterMessage.create)
    ..aOM<RegisterSuccessMessage>(6, 'registerSuccess', protoName: 'registerSuccess', subBuilder: RegisterSuccessMessage.create)
    ..aOM<PlayerNicknamesMessage>(7, 'playerNicknames', protoName: 'playerNicknames', subBuilder: PlayerNicknamesMessage.create)
    ..hasRequiredFields = false
  ;

  Capsule._() : super();
  factory Capsule() => create();
  factory Capsule.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Capsule.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Capsule clone() => Capsule()..mergeFromMessage(this);
  Capsule copyWith(void Function(Capsule) updates) => super.copyWith((message) => updates(message as Capsule));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Capsule create() => Capsule._();
  Capsule createEmptyInstance() => create();
  static $pb.PbList<Capsule> createRepeated() => $pb.PbList<Capsule>();
  @$core.pragma('dart2js:noInline')
  static Capsule getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Capsule>(create);
  static Capsule _defaultInstance;

  Capsule_Payload whichPayload() => _Capsule_PayloadByTag[$_whichOneof(0)];
  void clearPayload() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.int get protocolId => $_getIZ(0);
  @$pb.TagNumber(1)
  set protocolId($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProtocolId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProtocolId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get sequenceNumber => $_getIZ(1);
  @$pb.TagNumber(2)
  set sequenceNumber($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSequenceNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearSequenceNumber() => clearField(2);

  @$pb.TagNumber(3)
  $0.GameState get gameState => $_getN(2);
  @$pb.TagNumber(3)
  set gameState($0.GameState v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasGameState() => $_has(2);
  @$pb.TagNumber(3)
  void clearGameState() => clearField(3);
  @$pb.TagNumber(3)
  $0.GameState ensureGameState() => $_ensure(2);

  @$pb.TagNumber(4)
  PlaceArrowMessage get placeArrow => $_getN(3);
  @$pb.TagNumber(4)
  set placeArrow(PlaceArrowMessage v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPlaceArrow() => $_has(3);
  @$pb.TagNumber(4)
  void clearPlaceArrow() => clearField(4);
  @$pb.TagNumber(4)
  PlaceArrowMessage ensurePlaceArrow() => $_ensure(3);

  @$pb.TagNumber(5)
  RegisterMessage get register => $_getN(4);
  @$pb.TagNumber(5)
  set register(RegisterMessage v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasRegister() => $_has(4);
  @$pb.TagNumber(5)
  void clearRegister() => clearField(5);
  @$pb.TagNumber(5)
  RegisterMessage ensureRegister() => $_ensure(4);

  @$pb.TagNumber(6)
  RegisterSuccessMessage get registerSuccess => $_getN(5);
  @$pb.TagNumber(6)
  set registerSuccess(RegisterSuccessMessage v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasRegisterSuccess() => $_has(5);
  @$pb.TagNumber(6)
  void clearRegisterSuccess() => clearField(6);
  @$pb.TagNumber(6)
  RegisterSuccessMessage ensureRegisterSuccess() => $_ensure(5);

  @$pb.TagNumber(7)
  PlayerNicknamesMessage get playerNicknames => $_getN(6);
  @$pb.TagNumber(7)
  set playerNicknames(PlayerNicknamesMessage v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasPlayerNicknames() => $_has(6);
  @$pb.TagNumber(7)
  void clearPlayerNicknames() => clearField(7);
  @$pb.TagNumber(7)
  PlayerNicknamesMessage ensurePlayerNicknames() => $_ensure(6);
}

