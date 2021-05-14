import 'package:test/test.dart';
import 'dart:convert';

import 'package:nyanya_rocket_base/nyanya_rocket_base.dart';

void main() {
  test('Arrow.toJson()', () {
    final Arrow arrow =
        Arrow(player: PlayerColor.Blue, direction: Direction.Right);
    expect(jsonEncode(arrow.toJson()), '{"type":1,"player":0,"direction":0}');
  });

  test('Rocket.toJson()', () {
    final Rocket rocket = Rocket(player: PlayerColor.Blue);
    expect(jsonEncode(rocket.toJson()), '{"type":3,"player":0}');
  });

  test('Tile.fromJson() on an Arrow', () {
    final Tile tile =
        Tile.fromJson(jsonDecode('{"type":1,"player":0,"direction":0}'));
    expect(tile.runtimeType, Arrow);
    expect((tile as Arrow).player, PlayerColor.Blue);
    expect(tile.direction, Direction.Right);
  });

  test('Tile.fromJson() on a Rocket', () {
    final Tile tile = Tile.fromJson(jsonDecode('{"type":3,"player":0}'));
    expect(tile.runtimeType, Rocket);
    expect((tile as Rocket).player, PlayerColor.Blue);
  });
}
