import 'package:nyanya_rocket_base/src/board.dart';
import 'package:nyanya_rocket_base/src/protocol/game_server.pb.dart';

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

  ProtocolEntity toPbEntity() {
    ProtocolEntity e = ProtocolEntity()
      ..direction = ProtocolDirection.values[position.direction.index]
      ..x = position.x
      ..y = position.y
      ..step = position.step;

    switch (runtimeType) {
      case Cat:
        e.type = ProtocolEntityType.CAT;
        break;

      case SpecialMouse:
        e.type = ProtocolEntityType.SPECIAL_MOUSE;
        break;

      case GoldenMouse:
        e.type = ProtocolEntityType.GOLDEN_MOUSE;
        break;

      case Mouse:
        e.type = ProtocolEntityType.MOUSE;
        break;
    }

    return e;
  }

  factory Entity.fromPbEntity(ProtocolEntity entity) {
    Entity e;
    switch (entity.type) {
      case ProtocolEntityType.CAT:
        e = Cat(
            position: BoardPosition(entity.x, entity.y,
                Direction.values[entity.direction.value], entity.step));
        break;

      case ProtocolEntityType.MOUSE:
        e = Mouse(
            position: BoardPosition(entity.x, entity.y,
                Direction.values[entity.direction.value], entity.step));
        break;

      case ProtocolEntityType.GOLDEN_MOUSE:
        e = GoldenMouse(
            position: BoardPosition(entity.x, entity.y,
                Direction.values[entity.direction.value], entity.step));
        break;

      case ProtocolEntityType.SPECIAL_MOUSE:
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
