///
//  Generated code. Do not modify.
//  source: game_server.proto
///
// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import

const ProtocolDirection$json = const {
  '1': 'ProtocolDirection',
  '2': const [
    const {'1': 'RIGHT', '2': 0},
    const {'1': 'UP', '2': 1},
    const {'1': 'LEFT', '2': 2},
    const {'1': 'DOWN', '2': 3},
  ],
};

const ProtocolPlayerColor$json = const {
  '1': 'ProtocolPlayerColor',
  '2': const [
    const {'1': 'BLUE', '2': 0},
    const {'1': 'YELLOW', '2': 1},
    const {'1': 'RED', '2': 2},
    const {'1': 'GREEN', '2': 3},
  ],
};

const ProtocolWall$json = const {
  '1': 'ProtocolWall',
  '2': const [
    const {'1': 'NONE', '2': 0},
    const {'1': 'LEFT_ONLY', '2': 1},
    const {'1': 'UP_ONLY', '2': 2},
    const {'1': 'LEFT_UP', '2': 3},
  ],
};

const ProtocolTileType$json = const {
  '1': 'ProtocolTileType',
  '2': const [
    const {'1': 'EMPTY', '2': 0},
    const {'1': 'ARROW', '2': 1},
    const {'1': 'PIT', '2': 2},
    const {'1': 'ROCKET', '2': 3},
    const {'1': 'GENERATOR', '2': 4},
  ],
};

const ProtocolEntityType$json = const {
  '1': 'ProtocolEntityType',
  '2': const [
    const {'1': 'CAT', '2': 0},
    const {'1': 'MOUSE', '2': 1},
    const {'1': 'GOLDEN_MOUSE', '2': 2},
    const {'1': 'SPECIAL_MOUSE', '2': 3},
  ],
};

const ProtocolGameEvent$json = const {
  '1': 'ProtocolGameEvent',
  '2': const [
    const {'1': 'NO_EVENT', '2': 0},
    const {'1': 'MOUSE_MANIA', '2': 1},
    const {'1': 'CAT_MANIA', '2': 2},
    const {'1': 'SPEED_UP', '2': 3},
    const {'1': 'SLOW_DOWN', '2': 4},
    const {'1': 'PLACE_AGAIN', '2': 5},
    const {'1': 'CAT_ATTACK', '2': 6},
    const {'1': 'MOUSE_MONOPOLY', '2': 7},
  ],
};

const PlaceArrowMessage$json = const {
  '1': 'PlaceArrowMessage',
  '2': const [
    const {'1': 'x', '3': 1, '4': 1, '5': 13, '10': 'x'},
    const {'1': 'y', '3': 2, '4': 1, '5': 13, '10': 'y'},
    const {'1': 'direction', '3': 3, '4': 1, '5': 14, '6': '.ProtocolDirection', '10': 'direction'},
  ],
};

const RegisterMessage$json = const {
  '1': 'RegisterMessage',
  '2': const [
    const {'1': 'nickname', '3': 1, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

const RegisterSuccessMessage$json = const {
  '1': 'RegisterSuccessMessage',
  '2': const [
    const {'1': 'givenColor', '3': 1, '4': 1, '5': 14, '6': '.ProtocolPlayerColor', '10': 'givenColor'},
    const {'1': 'nickname', '3': 2, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

const ProtocolTile$json = const {
  '1': 'ProtocolTile',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.ProtocolTileType', '10': 'type'},
    const {'1': 'direction', '3': 2, '4': 1, '5': 14, '6': '.ProtocolDirection', '10': 'direction'},
    const {'1': 'owner', '3': 3, '4': 1, '5': 14, '6': '.ProtocolPlayerColor', '10': 'owner'},
    const {'1': 'damagedOrDeparted', '3': 4, '4': 1, '5': 8, '10': 'damagedOrDeparted'},
  ],
};

const ProtocolBoard$json = const {
  '1': 'ProtocolBoard',
  '2': const [
    const {'1': 'walls', '3': 1, '4': 3, '5': 14, '6': '.ProtocolWall', '10': 'walls'},
    const {'1': 'tiles', '3': 2, '4': 3, '5': 11, '6': '.ProtocolTile', '10': 'tiles'},
  ],
};

const ProtocolEntity$json = const {
  '1': 'ProtocolEntity',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.ProtocolEntityType', '10': 'type'},
    const {'1': 'x', '3': 2, '4': 1, '5': 13, '10': 'x'},
    const {'1': 'y', '3': 3, '4': 1, '5': 13, '10': 'y'},
    const {'1': 'step', '3': 4, '4': 1, '5': 13, '10': 'step'},
    const {'1': 'direction', '3': 5, '4': 1, '5': 14, '6': '.ProtocolDirection', '10': 'direction'},
  ],
};

const ProtocolGame$json = const {
  '1': 'ProtocolGame',
  '2': const [
    const {'1': 'timestamp', '3': 1, '4': 1, '5': 13, '10': 'timestamp'},
    const {'1': 'board', '3': 2, '4': 1, '5': 11, '6': '.ProtocolBoard', '10': 'board'},
    const {'1': 'entities', '3': 3, '4': 3, '5': 11, '6': '.ProtocolEntity', '10': 'entities'},
    const {'1': 'scores', '3': 4, '4': 3, '5': 13, '10': 'scores'},
    const {'1': 'event', '3': 5, '4': 1, '5': 14, '6': '.ProtocolGameEvent', '10': 'event'},
  ],
};

