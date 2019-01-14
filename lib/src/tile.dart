import 'package:meta/meta.dart';
import 'package:nyanya_rocket_base/src/board.dart';

enum TileType {
  Empty,
  Arrow,
  Pit,
  Rocket,
  Generator,
}

enum PlayerColor {
  Blue,
  Yellow,
  Red,
  Green,
}

abstract class Tile {
  Tile();

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

  Map<String, dynamic> toJson();
}

class Empty extends Tile {
  @override
  Map<String, dynamic> toJson() {
    return {
      'type': TileType.Empty.index,
    };
  }
}

class Arrow extends Tile {
  final PlayerColor player;
  final Direction direction;
  final bool full;
  final int tickCount;

  Arrow(
      {@required this.player,
      @required this.direction,
      this.full = true,
      this.tickCount = 0});
  Tile damaged() => full
      ? Arrow(player: this.player, direction: this.direction, full: false)
      : Empty();

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
        tickCount = 0;
}

class Pit extends Tile {
  @override
  Map<String, dynamic> toJson() {
    return {
      'type': TileType.Pit.index,
    };
  }
}

class Rocket extends Tile {
  final PlayerColor player;
  final bool departed;

  Rocket({@required this.player, this.departed = false});

  @override
  Map<String, dynamic> toJson() => {
        'type': TileType.Rocket.index,
        'player': player.index,
      };

  Rocket.fromJson(Map<String, dynamic> parsedJson)
      : player = PlayerColor.values[parsedJson['player']],
        departed = false;
}

class Generator extends Tile {
  final Direction direction;

  Generator({@required this.direction});

  @override
  Map<String, dynamic> toJson() => {
        'type': TileType.Generator.index,
        'direction': direction.index,
      };

  Generator.fromJson(Map<String, dynamic> parsedJson)
      : direction = Direction.values[parsedJson['direction']];
}
