import 'package:meta/meta.dart';
import 'board.dart';
import 'protocol/game_state.pb.dart' as protocol;

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

  protocol.PlayerColor toProtocolPlayerColor() =>
      protocol.PlayerColor.values[index];

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

  factory Tile.fromProtocolTile(protocol.Tile tile) {
    Tile t;

    switch (tile.type) {
      case protocol.TileType.EMPTY:
        t = Empty();
        break;

      case protocol.TileType.ROCKET:
        t = Rocket(player: PlayerColor.values[tile.owner.value]);
        break;

      case protocol.TileType.ARROW:
        t = Arrow(
            player: PlayerColor.values[tile.owner.value],
            direction: Direction.values[tile.direction.value],
            halfTurnPower: tile.damagedOrDeparted
                ? ArrowHalfTurnPower.OneCat
                : ArrowHalfTurnPower.TwoCats);
        break;

      case protocol.TileType.GENERATOR:
        t = Generator(direction: Direction.values[tile.direction.value]);
        break;
    }

    return t;
  }

  Map<String, dynamic> toJson();

  protocol.Tile toProtocolTile();
}

class Empty extends Tile {
  @override
  Map<String, dynamic> toJson() {
    return {
      'type': TileType.Empty.index,
    };
  }

  @override
  protocol.Tile toProtocolTile() =>
      protocol.Tile()
        ..type = protocol.TileType.EMPTY;
}

enum ArrowHalfTurnPower { TwoCats, OneCat, ZeroCat }

class Arrow extends Tile {
  static const int defaultExpiration = 1200;

  final PlayerColor player;
  final Direction direction;
  final ArrowHalfTurnPower halfTurnPower;
  final int expiration; // Default is 10s

  const Arrow({@required this.player,
    @required this.direction,
    this.halfTurnPower = ArrowHalfTurnPower.TwoCats,
    this.expiration = defaultExpiration});

  const Arrow.notExpirable({
    @required this.player,
    @required this.direction,
    this.halfTurnPower = ArrowHalfTurnPower.TwoCats,
  }) : expiration = 600 * 1000000;

  Tile withHalfTurnPower(ArrowHalfTurnPower halfTurnPower) =>
      Arrow(
          player: this.player,
          direction: this.direction,
          halfTurnPower: halfTurnPower,
          expiration: this.expiration);

  Tile withExpiration(int expiration) =>
      expiration <= 0
          ? Empty()
          : Arrow(
          player: this.player,
          direction: this.direction,
          halfTurnPower: this.halfTurnPower,
          expiration: expiration);

  @override
  Map<String, dynamic> toJson() =>
      {
        'type': TileType.Arrow.index,
        'player': player.index,
        'direction': direction.index,
      };

  Arrow.fromJson(Map<String, dynamic> parsedJson)
      : player = PlayerColor.values[parsedJson['player']],
        direction = Direction.values[parsedJson['direction']],
        halfTurnPower = ArrowHalfTurnPower.TwoCats,
        expiration = 0;

  @override
  protocol.Tile toProtocolTile() =>
      protocol.Tile()
        ..type = protocol.TileType.ARROW
        ..owner = protocol.PlayerColor.values[player.index]
        ..direction = protocol.Direction.values[direction.index]
        ..damagedOrDeparted = halfTurnPower == ArrowHalfTurnPower.OneCat;
}

class Pit extends Tile {
  @override
  Map<String, dynamic> toJson() {
    return {
      'type': TileType.Pit.index,
    };
  }

  protocol.Tile toProtocolTile() =>
      protocol.Tile()
        ..type = protocol.TileType.PIT;
}

class Rocket extends Tile {
  final PlayerColor player;
  final bool departed;

  const Rocket({@required this.player, this.departed = false});

  const Rocket.departed({@required this.player}) : departed = true;

  @override
  Map<String, dynamic> toJson() =>
      {
        'type': TileType.Rocket.index,
        'player': player.index,
      };

  Rocket.fromJson(Map<String, dynamic> parsedJson)
      : player = PlayerColor.values[parsedJson['player']],
        departed = false;

  @override
  protocol.Tile toProtocolTile() =>
      protocol.Tile()
        ..type = protocol.TileType.ROCKET
        ..owner = protocol.PlayerColor.values[player.index];
}

class Generator extends Tile {
  final Direction direction;

  const Generator({@required this.direction});

  @override
  Map<String, dynamic> toJson() =>
      {
        'type': TileType.Generator.index,
        'direction': direction.index,
      };

  Generator.fromJson(Map<String, dynamic> parsedJson)
      : direction = Direction.values[parsedJson['direction']];

  @override
  protocol.Tile toProtocolTile() =>
      protocol.Tile()
        ..type = protocol.TileType.GENERATOR
        ..direction = protocol.Direction.values[direction.index];
}
