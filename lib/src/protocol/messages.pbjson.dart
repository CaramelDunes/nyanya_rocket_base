///
//  Generated code. Do not modify.
//  source: messages.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const PlaceArrowMessage$json = const {
  '1': 'PlaceArrowMessage',
  '2': const [
    const {'1': 'x', '3': 1, '4': 1, '5': 13, '10': 'x'},
    const {'1': 'y', '3': 2, '4': 1, '5': 13, '10': 'y'},
    const {'1': 'direction', '3': 3, '4': 1, '5': 14, '6': '.Direction', '10': 'direction'},
  ],
};

const RegisterMessage$json = const {
  '1': 'RegisterMessage',
  '2': const [
    const {'1': 'nickname', '3': 1, '4': 1, '5': 9, '10': 'nickname'},
    const {'1': 'ticket', '3': 2, '4': 1, '5': 13, '10': 'ticket'},
  ],
};

const RegisterSuccessMessage$json = const {
  '1': 'RegisterSuccessMessage',
  '2': const [
    const {'1': 'givenColor', '3': 1, '4': 1, '5': 14, '6': '.PlayerColor', '10': 'givenColor'},
  ],
};

const PlayerNicknamesMessage$json = const {
  '1': 'PlayerNicknamesMessage',
  '2': const [
    const {'1': 'nicknames', '3': 1, '4': 3, '5': 9, '10': 'nicknames'},
  ],
};

const Capsule$json = const {
  '1': 'Capsule',
  '2': const [
    const {'1': 'protocolId', '3': 1, '4': 1, '5': 13, '10': 'protocolId'},
    const {'1': 'sequenceNumber', '3': 2, '4': 1, '5': 13, '10': 'sequenceNumber'},
    const {'1': 'gameState', '3': 3, '4': 1, '5': 11, '6': '.GameState', '9': 0, '10': 'gameState'},
    const {'1': 'placeArrow', '3': 4, '4': 1, '5': 11, '6': '.PlaceArrowMessage', '9': 0, '10': 'placeArrow'},
    const {'1': 'register', '3': 5, '4': 1, '5': 11, '6': '.RegisterMessage', '9': 0, '10': 'register'},
    const {'1': 'registerSuccess', '3': 6, '4': 1, '5': 11, '6': '.RegisterSuccessMessage', '9': 0, '10': 'registerSuccess'},
    const {'1': 'playerNicknames', '3': 7, '4': 1, '5': 11, '6': '.PlayerNicknamesMessage', '9': 0, '10': 'playerNicknames'},
  ],
  '8': const [
    const {'1': 'payload'},
  ],
};

