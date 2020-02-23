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

  Entity({this.position});

  factory Entity.fromJson(Map<String, dynamic> parsedJson) {
    return Entity.fromEntityType(EntityType.values[parsedJson['type']],
        BoardPosition.fromJson(parsedJson['position']));
  }

  factory Entity.fromEntityType(EntityType type, BoardPosition position) {
    switch (type) {
      case EntityType.Cat:
        return Cat(position: position);
        break;

      case EntityType.Mouse:
        return Mouse(position: position);
        break;

      case EntityType.GoldenMouse:
        return GoldenMouse(position: position);
        break;

      case EntityType.SpecialMouse:
        return SpecialMouse(position: position);
        break;

      default:
        return Mouse(position: position);
        break;
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
    Entity e;
    switch (entity.type) {
      case protocol.EntityType.CAT:
        e = Cat(
            position: BoardPosition(entity.x, entity.y,
                Direction.values[entity.direction.value], entity.step));
        break;

      case protocol.EntityType.MOUSE:
        e = Mouse(
            position: BoardPosition(entity.x, entity.y,
                Direction.values[entity.direction.value], entity.step));
        break;

      case protocol.EntityType.GOLDEN_MOUSE:
        e = GoldenMouse(
            position: BoardPosition(entity.x, entity.y,
                Direction.values[entity.direction.value], entity.step));
        break;

      case protocol.EntityType.SPECIAL_MOUSE:
        e = SpecialMouse(
            position: BoardPosition(entity.x, entity.y,
                Direction.values[entity.direction.value], entity.step));
        break;
    }

    return e;
  }

  int moveSpeed();

  Map<String, dynamic> toJson();
}

class Cat extends Entity {
  Cat({BoardPosition position}) : super(position: position);

  @override
  int moveSpeed() => 2;

  @override
  Map<String, dynamic> toJson() => {
        'type': EntityType.Cat.index,
        'position': position.toJson(),
      };
}

class Mouse extends Entity {
  Mouse({BoardPosition position}) : super(position: position);

  @override
  int moveSpeed() => 3;

  @override
  Map<String, dynamic> toJson() => {
        'type': EntityType.Mouse.index,
        'position': position.toJson(),
      };
}

class GoldenMouse extends Mouse {
  GoldenMouse({BoardPosition position}) : super(position: position);

  @override
  Map<String, dynamic> toJson() => {
        'type': EntityType.GoldenMouse.index,
        'position': position.toJson(),
      };
}

class SpecialMouse extends Mouse {
  SpecialMouse({BoardPosition position}) : super(position: position);

  @override
  Map<String, dynamic> toJson() => {
        'type': EntityType.SpecialMouse.index,
        'position': position.toJson(),
      };
}
