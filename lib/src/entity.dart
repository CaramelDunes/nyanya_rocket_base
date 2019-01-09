import 'package:nyanya_rocket_base/src/board.dart';

enum EntityType {
  Cat,
  Mouse,
  GoldenMouse,
  SpecialMouse,
}

class EntityMovement {
  static const int maxStep = 30;
  final int x;
  final int y;
  final int step; // Between 0 and maxStep
  final Direction direction;

  EntityMovement(this.x, this.y, this.direction, this.step);

  EntityMovement.copy(EntityMovement e)
      : x = e.x,
        y = e.y,
        step = e.step,
        direction = e.direction;
  EntityMovement.centered(this.x, this.y, this.direction) : step = maxStep ~/ 2;
  EntityMovement.entering(this.x, this.y, this.direction) : step = 0;

  EntityMovement withDirection(Direction newDirection) =>
      EntityMovement(x, y, newDirection, step);

  int moveSpeed() => 3;
}

abstract class Entity {
  EntityMovement movement;

  Entity(this.movement);
}

class Cat extends Entity {
  Cat(EntityMovement movement) : super(movement);
}

class Mouse extends Entity {
  Mouse(EntityMovement movement) : super(movement);
}

class GoldenMouse extends Mouse {
  GoldenMouse(EntityMovement movement) : super(movement);
}

class SpecialMouse extends Mouse {
  SpecialMouse(EntityMovement movement) : super(movement);
}
