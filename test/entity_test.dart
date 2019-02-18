import 'package:test/test.dart';
import 'dart:convert';

import 'package:nyanya_rocket_base/nyanya_rocket_base.dart';

void main() {
  test('Cat.toJson()', () {
    final Cat cat =
        Cat(position: BoardPosition.centered(0, 0, Direction.Right));
    expect(jsonEncode(cat.toJson()),
        '{"type":0,"position":{"x":0,"y":0,"step":${BoardPosition.center},"direction":0}}');
  });

  test('Mouse.toJson()', () {
    final Mouse mouse =
        Mouse(position: BoardPosition.centered(0, 0, Direction.Right));
    expect(jsonEncode(mouse.toJson()),
        '{"type":1,"position":{"x":0,"y":0,"step":${BoardPosition.center},"direction":0}}');
  });

  test('Entity.fromJson() on an Cat', () {
    final Entity entity = Entity.fromJson(jsonDecode(
        '{"type":0,"position":{"x":0,"y":0,"step":${BoardPosition.center},"direction":0}}'));
    expect(entity.runtimeType, Cat);
    expect((entity as Cat).position.x, 0);
    expect((entity as Cat).position.y, 0);
    expect((entity as Cat).position.step, BoardPosition.center);
    expect((entity as Cat).position.direction, Direction.Right);
  });

  test('Entity.fromJson() on a Mouse', () {
    final Entity entity = Entity.fromJson(jsonDecode(
        '{"type":1,"position":{"x":0,"y":0,"step":${BoardPosition.center},"direction":0}}'));
    expect(entity.runtimeType, Mouse);
    expect((entity as Mouse).position.x, 0);
    expect((entity as Mouse).position.y, 0);
    expect((entity as Mouse).position.step, BoardPosition.center);
    expect((entity as Mouse).position.direction, Direction.Right);
  });
}
