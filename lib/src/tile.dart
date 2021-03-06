import 'board.dart';
import 'protocol/game_state.pb.dart' as protocol;

enum TileType {
  Empty,
  Arrow,
  Pit,
  Rocket,
  Generator,
}

enum PlayerColor {
  Blue,
  Red,
  Green,
  Yellow,
}

extension ProtocolConversion on PlayerColor {
  protocol.PlayerColor toProtocolPlayerColor() =>
      protocol.PlayerColor.values[this.index];
}

abstract class Tile {
  const Tile();

  factory Tile.fromJson(Map<String, dynamic> parsedJson) {
    switch (TileType.values[parsedJson['type']]) {
      case TileType.Empty:
        return Empty();

      case TileType.Arrow:
        return Arrow.fromJson(parsedJson);

      case TileType.Pit:
        return Pit();

      case TileType.Rocket:
        return Rocket.fromJson(parsedJson);

      case TileType.Generator:
        return Generator.fromJson(parsedJson);
    }
  }

  factory Tile.fromProtocolTile(protocol.Tile tile) {
    switch (tile.type) {
      case protocol.TileType.EMPTY:
        return Empty();

      case protocol.TileType.PIT:
        return const Pit();

      case protocol.TileType.ROCKET:
        return Rocket(player: PlayerColor.values[tile.owner.value]);

      case protocol.TileType.ARROW:
        return Arrow(
            player: PlayerColor.values[tile.owner.value],
            direction: Direction.values[tile.direction.value],
            halfTurnPower: tile.damagedOrDeparted
                ? ArrowHalfTurnPower.OneCat
                : ArrowHalfTurnPower.TwoCats,
            expiration: tile.expiration);

      case protocol.TileType.GENERATOR:
        return Generator(direction: Direction.values[tile.direction.value]);
    }

    // TODO Better handling.
    throw Exception('Got unknown tile type from network!');
  }

  Map<String, dynamic> toJson();

  protocol.Tile toProtocolTile();
}

class Empty extends Tile {
  const Empty();

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': TileType.Empty.index,
    };
  }

  @override
  protocol.Tile toProtocolTile() =>
      protocol.Tile()..type = protocol.TileType.EMPTY;

  @override
  bool operator ==(other) {
    return other is Empty;
  }
}

enum ArrowHalfTurnPower { TwoCats, OneCat, ZeroCat }

class Arrow extends Tile {
  static const int defaultExpiration =
      60 * 2 * 10; // 10 sec at 120 ticks per second.

  final PlayerColor player;
  final Direction direction;
  final ArrowHalfTurnPower halfTurnPower;
  final int expiration;

  const Arrow(
      {required this.player,
      required this.direction,
      this.halfTurnPower = ArrowHalfTurnPower.TwoCats,
      this.expiration = defaultExpiration});

  const Arrow.notExpiring({
    required this.player,
    required this.direction,
    this.halfTurnPower = ArrowHalfTurnPower.TwoCats,
  }) : expiration = 600 * 1000000;

  Tile withHalfTurnPower(ArrowHalfTurnPower halfTurnPower) => Arrow(
      player: this.player,
      direction: this.direction,
      halfTurnPower: halfTurnPower,
      expiration: this.expiration);

  Tile withExpiration(int expiration) => expiration <= 0
      ? Empty()
      : Arrow(
          player: this.player,
          direction: this.direction,
          halfTurnPower: this.halfTurnPower,
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
        halfTurnPower = ArrowHalfTurnPower.TwoCats,
        expiration = 0;

  @override
  protocol.Tile toProtocolTile() => protocol.Tile()
    ..type = protocol.TileType.ARROW
    ..owner = protocol.PlayerColor.values[player.index]
    ..direction = protocol.Direction.values[direction.index]
    ..damagedOrDeparted = halfTurnPower == ArrowHalfTurnPower.OneCat
    ..expiration = expiration;

  @override
  bool operator ==(other) {
    return super == other ||
        (other is Arrow &&
            player == other.player &&
            direction == other.direction &&
            halfTurnPower == other.halfTurnPower &&
            expiration == other.expiration);
  }
}

class Pit extends Tile {
  const Pit();

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': TileType.Pit.index,
    };
  }

  protocol.Tile toProtocolTile() =>
      protocol.Tile()..type = protocol.TileType.PIT;

  @override
  bool operator ==(other) {
    return other is Pit;
  }
}

class Rocket extends Tile {
  final PlayerColor player;
  final bool departed;

  const Rocket({required this.player, this.departed = false});

  const Rocket.departed({required this.player}) : departed = true;

  @override
  Map<String, dynamic> toJson() => {
        'type': TileType.Rocket.index,
        'player': player.index,
      };

  Rocket.fromJson(Map<String, dynamic> parsedJson)
      : player = PlayerColor.values[parsedJson['player']],
        departed = false;

  @override
  protocol.Tile toProtocolTile() => protocol.Tile()
    ..type = protocol.TileType.ROCKET
    ..owner = protocol.PlayerColor.values[player.index];

  @override
  bool operator ==(other) {
    return super == other ||
        (other is Rocket &&
            player == other.player &&
            departed == other.departed);
  }
}

class Generator extends Tile {
  final Direction direction;

  const Generator({required this.direction});

  @override
  Map<String, dynamic> toJson() => {
        'type': TileType.Generator.index,
        'direction': direction.index,
      };

  Generator.fromJson(Map<String, dynamic> parsedJson)
      : direction = Direction.values[parsedJson['direction']];

  @override
  protocol.Tile toProtocolTile() => protocol.Tile()
    ..type = protocol.TileType.GENERATOR
    ..direction = protocol.Direction.values[direction.index];

  @override
  bool operator ==(other) {
    return super == other ||
        (other is Generator && direction == other.direction);
  }
}
