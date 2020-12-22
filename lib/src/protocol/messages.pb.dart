///
//  Generated code. Do not modify.
//  source: messages.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'game_state.pb.dart' as $0;

import 'game_state.pbenum.dart' as $0;

class PlaceArrowMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PlaceArrowMessage', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'x', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'y', $pb.PbFieldType.OU3)
    ..e<$0.Direction>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: $0.Direction.RIGHT, valueOf: $0.Direction.valueOf, enumValues: $0.Direction.values)
    ..hasRequiredFields = false
  ;

  PlaceArrowMessage._() : super();
  factory PlaceArrowMessage() => create();
  factory PlaceArrowMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlaceArrowMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlaceArrowMessage clone() => PlaceArrowMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlaceArrowMessage copyWith(void Function(PlaceArrowMessage) updates) => super.copyWith((message) => updates(message as PlaceArrowMessage)) as PlaceArrowMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PlaceArrowMessage create() => PlaceArrowMessage._();
  PlaceArrowMessage createEmptyInstance() => create();
  static $pb.PbList<PlaceArrowMessage> createRepeated() => $pb.PbList<PlaceArrowMessage>();
  @$core.pragma('dart2js:noInline')
  static PlaceArrowMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlaceArrowMessage>(create);
  static PlaceArrowMessage? _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RegisterMessage', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nickname')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ticket', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  RegisterMessage._() : super();
  factory RegisterMessage() => create();
  factory RegisterMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RegisterMessage clone() => RegisterMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RegisterMessage copyWith(void Function(RegisterMessage) updates) => super.copyWith((message) => updates(message as RegisterMessage)) as RegisterMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegisterMessage create() => RegisterMessage._();
  RegisterMessage createEmptyInstance() => create();
  static $pb.PbList<RegisterMessage> createRepeated() => $pb.PbList<RegisterMessage>();
  @$core.pragma('dart2js:noInline')
  static RegisterMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterMessage>(create);
  static RegisterMessage? _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RegisterSuccessMessage', createEmptyInstance: create)
    ..e<$0.PlayerColor>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'givenColor', $pb.PbFieldType.OE, protoName: 'givenColor', defaultOrMaker: $0.PlayerColor.BLUE, valueOf: $0.PlayerColor.valueOf, enumValues: $0.PlayerColor.values)
    ..hasRequiredFields = false
  ;

  RegisterSuccessMessage._() : super();
  factory RegisterSuccessMessage() => create();
  factory RegisterSuccessMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RegisterSuccessMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RegisterSuccessMessage clone() => RegisterSuccessMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RegisterSuccessMessage copyWith(void Function(RegisterSuccessMessage) updates) => super.copyWith((message) => updates(message as RegisterSuccessMessage)) as RegisterSuccessMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RegisterSuccessMessage create() => RegisterSuccessMessage._();
  RegisterSuccessMessage createEmptyInstance() => create();
  static $pb.PbList<RegisterSuccessMessage> createRepeated() => $pb.PbList<RegisterSuccessMessage>();
  @$core.pragma('dart2js:noInline')
  static RegisterSuccessMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RegisterSuccessMessage>(create);
  static RegisterSuccessMessage? _defaultInstance;

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
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PlayerNicknamesMessage', createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nicknames')
    ..hasRequiredFields = false
  ;

  PlayerNicknamesMessage._() : super();
  factory PlayerNicknamesMessage() => create();
  factory PlayerNicknamesMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PlayerNicknamesMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PlayerNicknamesMessage clone() => PlayerNicknamesMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PlayerNicknamesMessage copyWith(void Function(PlayerNicknamesMessage) updates) => super.copyWith((message) => updates(message as PlayerNicknamesMessage)) as PlayerNicknamesMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PlayerNicknamesMessage create() => PlayerNicknamesMessage._();
  PlayerNicknamesMessage createEmptyInstance() => create();
  static $pb.PbList<PlayerNicknamesMessage> createRepeated() => $pb.PbList<PlayerNicknamesMessage>();
  @$core.pragma('dart2js:noInline')
  static PlayerNicknamesMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PlayerNicknamesMessage>(create);
  static PlayerNicknamesMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get nicknames => $_getList(0);
}

class PingMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PingMessage', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ticket', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  PingMessage._() : super();
  factory PingMessage() => create();
  factory PingMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PingMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PingMessage clone() => PingMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PingMessage copyWith(void Function(PingMessage) updates) => super.copyWith((message) => updates(message as PingMessage)) as PingMessage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PingMessage create() => PingMessage._();
  PingMessage createEmptyInstance() => create();
  static $pb.PbList<PingMessage> createRepeated() => $pb.PbList<PingMessage>();
  @$core.pragma('dart2js:noInline')
  static PingMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PingMessage>(create);
  static PingMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get ticket => $_getIZ(0);
  @$pb.TagNumber(1)
  set ticket($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTicket() => $_has(0);
  @$pb.TagNumber(1)
  void clearTicket() => clearField(1);
}

enum Capsule_Payload {
  gameState, 
  placeArrow, 
  register, 
  registerSuccess, 
  playerNicknames, 
  ping, 
  notSet
}

class Capsule extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Capsule_Payload> _Capsule_PayloadByTag = {
    3 : Capsule_Payload.gameState,
    4 : Capsule_Payload.placeArrow,
    5 : Capsule_Payload.register,
    6 : Capsule_Payload.registerSuccess,
    7 : Capsule_Payload.playerNicknames,
    8 : Capsule_Payload.ping,
    0 : Capsule_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Capsule', createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6, 7, 8])
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'protocolId', $pb.PbFieldType.OU3, protoName: 'protocolId')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequenceNumber', $pb.PbFieldType.OU3, protoName: 'sequenceNumber')
    ..aOM<$0.GameState>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'gameState', protoName: 'gameState', subBuilder: $0.GameState.create)
    ..aOM<PlaceArrowMessage>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'placeArrow', protoName: 'placeArrow', subBuilder: PlaceArrowMessage.create)
    ..aOM<RegisterMessage>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'register', subBuilder: RegisterMessage.create)
    ..aOM<RegisterSuccessMessage>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'registerSuccess', protoName: 'registerSuccess', subBuilder: RegisterSuccessMessage.create)
    ..aOM<PlayerNicknamesMessage>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playerNicknames', protoName: 'playerNicknames', subBuilder: PlayerNicknamesMessage.create)
    ..aOM<PingMessage>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ping', subBuilder: PingMessage.create)
    ..hasRequiredFields = false
  ;

  Capsule._() : super();
  factory Capsule() => create();
  factory Capsule.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Capsule.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Capsule clone() => Capsule()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Capsule copyWith(void Function(Capsule) updates) => super.copyWith((message) => updates(message as Capsule)) as Capsule; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Capsule create() => Capsule._();
  Capsule createEmptyInstance() => create();
  static $pb.PbList<Capsule> createRepeated() => $pb.PbList<Capsule>();
  @$core.pragma('dart2js:noInline')
  static Capsule getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Capsule>(create);
  static Capsule? _defaultInstance;

  Capsule_Payload whichPayload() => _Capsule_PayloadByTag[$_whichOneof(0)]!;
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

  @$pb.TagNumber(8)
  PingMessage get ping => $_getN(7);
  @$pb.TagNumber(8)
  set ping(PingMessage v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasPing() => $_has(7);
  @$pb.TagNumber(8)
  void clearPing() => clearField(8);
  @$pb.TagNumber(8)
  PingMessage ensurePing() => $_ensure(7);
}

