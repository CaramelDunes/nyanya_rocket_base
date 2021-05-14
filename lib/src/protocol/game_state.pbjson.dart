///
//  Generated code. Do not modify.
//  source: game_state.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;
const Direction$json = const {
  '1': 'Direction',
  '2': const [
    const {'1': 'RIGHT', '2': 0},
    const {'1': 'UP', '2': 1},
    const {'1': 'LEFT', '2': 2},
    const {'1': 'DOWN', '2': 3},
  ],
};

const PlayerColor$json = const {
  '1': 'PlayerColor',
  '2': const [
    const {'1': 'BLUE', '2': 0},
    const {'1': 'RED', '2': 1},
    const {'1': 'GREEN', '2': 2},
    const {'1': 'YELLOW', '2': 3},
  ],
};

const Wall$json = const {
  '1': 'Wall',
  '2': const [
    const {'1': 'NONE', '2': 0},
    const {'1': 'LEFT_ONLY', '2': 1},
    const {'1': 'UP_ONLY', '2': 2},
    const {'1': 'LEFT_UP', '2': 3},
  ],
};

const TileType$json = const {
  '1': 'TileType',
  '2': const [
    const {'1': 'EMPTY', '2': 0},
    const {'1': 'ARROW', '2': 1},
    const {'1': 'PIT', '2': 2},
    const {'1': 'ROCKET', '2': 3},
    const {'1': 'GENERATOR', '2': 4},
  ],
};

const EntityType$json = const {
  '1': 'EntityType',
  '2': const [
    const {'1': 'CAT', '2': 0},
    const {'1': 'MOUSE', '2': 1},
    const {'1': 'GOLDEN_MOUSE', '2': 2},
    const {'1': 'SPECIAL_MOUSE', '2': 3},
  ],
};

const GameEvent$json = const {
  '1': 'GameEvent',
  '2': const [
    const {'1': 'NO_EVENT', '2': 0},
    const {'1': 'MOUSE_MANIA', '2': 1},
    const {'1': 'CAT_MANIA', '2': 2},
    const {'1': 'SPEED_UP', '2': 3},
    const {'1': 'SLOW_DOWN', '2': 4},
    const {'1': 'PLACE_AGAIN', '2': 5},
    const {'1': 'CAT_ATTACK', '2': 6},
    const {'1': 'MOUSE_MONOPOLY', '2': 7},
    const {'1': 'EVERYBODY_MOVE', '2': 8},
  ],
};

const Tile$json = const {
  '1': 'Tile',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.TileType', '10': 'type'},
    const {'1': 'direction', '3': 2, '4': 1, '5': 14, '6': '.Direction', '10': 'direction'},
    const {'1': 'owner', '3': 3, '4': 1, '5': 14, '6': '.PlayerColor', '10': 'owner'},
    const {'1': 'damagedOrDeparted', '3': 4, '4': 1, '5': 8, '10': 'damagedOrDeparted'},
    const {'1': 'expiration', '3': 5, '4': 1, '5': 13, '10': 'expiration'},
  ],
};

const Board$json = const {
  '1': 'Board',
  '2': const [
    const {'1': 'walls', '3': 1, '4': 3, '5': 14, '6': '.Wall', '10': 'walls'},
    const {'1': 'tiles', '3': 2, '4': 3, '5': 11, '6': '.Tile', '10': 'tiles'},
  ],
};

const Entity$json = const {
  '1': 'Entity',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.EntityType', '10': 'type'},
    const {'1': 'x', '3': 2, '4': 1, '5': 13, '10': 'x'},
    const {'1': 'y', '3': 3, '4': 1, '5': 13, '10': 'y'},
    const {'1': 'step', '3': 4, '4': 1, '5': 13, '10': 'step'},
    const {'1': 'direction', '3': 5, '4': 1, '5': 14, '6': '.Direction', '10': 'direction'},
  ],
};

const GameState$json = const {
  '1': 'GameState',
  '2': const [
    const {'1': 'tickCount', '3': 1, '4': 1, '5': 13, '10': 'tickCount'},
    const {'1': 'pauseUntil', '3': 2, '4': 1, '5': 13, '10': 'pauseUntil'},
    const {'1': 'eventEnd', '3': 3, '4': 1, '5': 13, '10': 'eventEnd'},
    const {'1': 'board', '3': 4, '4': 1, '5': 11, '6': '.Board', '10': 'board'},
    const {'1': 'cats', '3': 5, '4': 3, '5': 11, '6': '.Entity', '10': 'cats'},
    const {'1': 'mice', '3': 6, '4': 3, '5': 11, '6': '.Entity', '10': 'mice'},
    const {'1': 'scores', '3': 7, '4': 3, '5': 13, '10': 'scores'},
    const {'1': 'rngState', '3': 8, '4': 1, '5': 4, '10': 'rngState'},
    const {'1': 'event', '3': 9, '4': 1, '5': 14, '6': '.GameEvent', '10': 'event'},
  ],
};

