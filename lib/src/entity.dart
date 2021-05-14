import 'board.dart';
import 'protocol/game_state.pb.dart' as protocol;

enum EntityType {
  Cat,
  Mouse,
  GoldenMouse,
  SpecialMouse,
}

abstract class Entity {
  BoardPosition position;

  Entity({required this.position});

  factory Entity.fromJson(Map<String, dynamic> parsedJson) {
    return Entity.fromEntityType(EntityType.values[parsedJson['type']],
        BoardPosition.fromJson(parsedJson['position']));
  }

  factory Entity.fromEntityType(EntityType type, BoardPosition position) {
    switch (type) {
      case EntityType.Cat:
        return Cat(position: position);

      case EntityType.Mouse:
        return Mouse(position: position);

      case EntityType.GoldenMouse:
        return GoldenMouse(position: position);

      case EntityType.SpecialMouse:
        return SpecialMouse(position: position);

      default:
        return Mouse(position: position);
    }
  }

  protocol.Entity toProtocolEntity() {
    protocol.Entity e = protocol.Entity()
      ..direction = protocol.Direction.values[position.direction.index]
      ..x = position.x
      ..y = position.y
      ..step = position.step;

    switch (runtimeType) {
      case Cat:
        e.type = protocol.EntityType.CAT;
        break;

      case SpecialMouse:
        e.type = protocol.EntityType.SPECIAL_MOUSE;
        break;

      case GoldenMouse:
        e.type = protocol.EntityType.GOLDEN_MOUSE;
        break;

      case Mouse:
        e.type = protocol.EntityType.MOUSE;
        break;
    }

    return e;
  }

  factory Entity.fromProtocolEntity(protocol.Entity entity) {
    switch (entity.type) {
      case protocol.EntityType.CAT:
        return Cat(
            position: BoardPosition(entity.x, entity.y,
                Direction.values[entity.direction.value], entity.step));

      case protocol.EntityType.MOUSE:
        return Mouse(
            position: BoardPosition(entity.x, entity.y,
                Direction.values[entity.direction.value], entity.step));

      case protocol.EntityType.GOLDEN_MOUSE:
        return GoldenMouse(
            position: BoardPosition(entity.x, entity.y,
                Direction.values[entity.direction.value], entity.step));

      case protocol.EntityType.SPECIAL_MOUSE:
        return SpecialMouse(
            position: BoardPosition(entity.x, entity.y,
                Direction.values[entity.direction.value], entity.step));
    }

    throw Exception(); //FIXME
  }

  int moveSpeed();

  Map<String, dynamic> toJson();
}

class Cat extends Entity {
  Cat({required BoardPosition position}) : super(position: position);

  Cat copy() => Cat(position: position.copy());

  @override
  int moveSpeed() => 2;

  @override
  Map<String, dynamic> toJson() => {
        'type': EntityType.Cat.index,
        'position': position.toJson(),
      };
}

class Mouse extends Entity {
  Mouse({required BoardPosition position}) : super(position: position);

  Mouse copy() => Mouse(position: position.copy());

  @override
  int moveSpeed() => 3;

  @override
  Map<String, dynamic> toJson() => {
        'type': EntityType.Mouse.index,
        'position': position.toJson(),
      };
}

class GoldenMouse extends Mouse {
  GoldenMouse({required BoardPosition position}) : super(position: position);

  GoldenMouse copy() => GoldenMouse(position: position.copy());

  @override
  Map<String, dynamic> toJson() => {
        'type': EntityType.GoldenMouse.index,
        'position': position.toJson(),
      };
}

class SpecialMouse extends Mouse {
  SpecialMouse({required BoardPosition position}) : super(position: position);

  SpecialMouse copy() => SpecialMouse(position: position.copy());

  @override
  Map<String, dynamic> toJson() => {
        'type': EntityType.SpecialMouse.index,
        'position': position.toJson(),
      };
}
