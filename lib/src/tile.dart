import 'package:nyanya_rocket_base/src/board.dart';

enum PlayerColor {
  Blue,
  Yellow,
  Red,
  Green,
}

abstract class Tile {}

class Empty extends Tile {}

class Arrow extends Tile {
  final PlayerColor owner;
  final Direction direction;
  final bool full;

  Arrow(this.owner, this.direction, [this.full = true]);
  Tile damaged() => full ? Arrow(owner, direction, false) : Empty();
}

class Pit extends Tile {}

class Rocket extends Tile {
  final PlayerColor owner;
  final bool departed;

  Rocket(this.owner, [this.departed = false]);
}

class Generator extends Tile {
  final Direction direction;

  Generator(this.direction);
}
