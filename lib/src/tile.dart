import 'package:meta/meta.dart';
import 'package:nyanya_rocket_base/src/board.dart';
import 'package:nyanya_rocket_base/src/protocol/game_server.pb.dart';

enum TileType {
  Empty,
  Arrow,
  Pit,
  Rocket,
  Generator,
}

class PlayerColor {
  final int index;

  const PlayerColor._internal(this.index);

  @override
  String toString() => 'PlayerColor.$index';

  ProtocolPlayerColor toProtocolPlayerColor() =>
      ProtocolPlayerColor.values[index];

  static const Blue = const PlayerColor._internal(0);
  static const Yellow = const PlayerColor._internal(1);
  static const Red = const PlayerColor._internal(2);
  static const Green = const PlayerColor._internal(3);

  static const List<PlayerColor> values = const <PlayerColor>[
    Blue,
    Yellow,
    Red,
    Green,
  ];
}

abstract class Tile {
  const Tile();

  factory Tile.fromJson(Map<String, dynamic> parsedJson) {
    switch (TileType.values[parsedJson['type']]) {
      case TileType.Empty:
        return Empty();
        break;

      case TileType.Arrow:
        return Arrow.fromJson(parsedJson);
        break;

      case TileType.Pit:
        return Pit();
        break;

      case TileType.Rocket:
        return Rocket.fromJson(parsedJson);
        break;

      case TileType.Generator:
        return Generator.fromJson(parsedJson);
        break;
    }

    return Empty();
  }

  factory Tile.fromPbTile(ProtocolTile tile) {
    Tile t;

    switch (tile.type) {
      case ProtocolTileType.EMPTY:
        t = Empty();
        break;

      case ProtocolTileType.ROCKET:
        t = Rocket(player: PlayerColor.values[tile.owner.value]);
        break;

      case ProtocolTileType.ARROW:
        t = Arrow(
            player: PlayerColor.values[tile.owner.value],
            direction: Direction.values[tile.direction.value]);
        break;

      case ProtocolTileType.GENERATOR:
        t = Generator(direction: Direction.values[tile.direction.value]);
        break;
    }

    return t;
  }

  Map<String, dynamic> toJson();

  ProtocolTile toPbTile();
}

class Empty extends Tile {
  @override
  Map<String, dynamic> toJson() {
    return {
      'type': TileType.Empty.index,
    };
  }

  @override
  ProtocolTile toPbTile() => ProtocolTile()..type = ProtocolTileType.EMPTY;
}

class Arrow extends Tile {
  static const int defaultExpiration = 1200;

  final PlayerColor player;
  final Direction direction;
  final bool full;
  final int expiration; // Default is 10s

  const Arrow(
      {@required this.player,
      @required this.direction,
      this.full = true,
      this.expiration = defaultExpiration});

  const Arrow.notExpirable(
      {@required this.player, @required this.direction, this.full = true})
      : expiration = 600 * 1000000;

  Tile damaged() => full
      ? Arrow(player: this.player, direction: this.direction, full: false)
      : Empty();

  Tile withExpiration(int expiration) => expiration <= 0
      ? Empty()
      : Arrow(
          player: this.player,
          direction: this.direction,
          full: this.full,
          expiration: expiration);

  @override
  Map<String, dynamic> toJson() => {
        'type': TileType.Arrow.index,
        'player': player.index,
        'direction': direction.index,
      };

  Arrow.fromJson(Map<String, dynamic> parsedJson)
      : player = PlayerColor.values[parsedJson['player']],
        direction = Direction.values[parsedJson['direction']],
        full = true,
        expiration = 0;

  @override
  ProtocolTile toPbTile() => ProtocolTile()
    ..type = ProtocolTileType.ARROW
    ..owner = ProtocolPlayerColor.values[player.index]
    ..direction = ProtocolDirection.values[direction.index];
}

class Pit extends Tile {
  @override
  Map<String, dynamic> toJson() {
    return {
      'type': TileType.Pit.index,
    };
  }

  ProtocolTile toPbTile() => ProtocolTile()..type = ProtocolTileType.PIT;
}

class Rocket extends Tile {
  final PlayerColor player;
  final bool departed;

  const Rocket({@required this.player, this.departed = false});

  const Rocket.departed({@required this.player}) : departed = true;

  @override
  Map<String, dynamic> toJson() => {
        'type': TileType.Rocket.index,
        'player': player.index,
      };

  Rocket.fromJson(Map<String, dynamic> parsedJson)
      : player = PlayerColor.values[parsedJson['player']],
        departed = false;

  @override
  ProtocolTile toPbTile() => ProtocolTile()
    ..type = ProtocolTileType.ROCKET
    ..owner = ProtocolPlayerColor.values[player.index];
}

class Generator extends Tile {
  final Direction direction;

  const Generator({@required this.direction});

  @override
  Map<String, dynamic> toJson() => {
        'type': TileType.Generator.index,
        'direction': direction.index,
      };

  Generator.fromJson(Map<String, dynamic> parsedJson)
      : direction = Direction.values[parsedJson['direction']];

  @override
  ProtocolTile toPbTile() => ProtocolTile()
    ..type = ProtocolTileType.GENERATOR
    ..direction = ProtocolDirection.values[direction.index];
}
