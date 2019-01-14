import 'package:test/test.dart';
import 'dart:convert';

import 'package:nyanya_rocket_base/nyanya_rocket_base.dart';

void main() {
  test('create an empty board', () {
    final board = Board();

    for (int x = 0; x < Board.width; x++) {
      for (int y = 0; y < Board.height; y++) {
        expect(board.tiles[x][y].runtimeType, Empty);
        expect(board.hasRightWall(x, y), false);
        expect(board.hasUpWall(x, y), false);
        expect(board.hasLeftWall(x, y), false);
        expect(board.hasDownWall(x, y), false);
      }
    }
  });

  test('Board.toJson() on an empty board', () {
    final board = Board();
    String json = jsonEncode(board.toJson());
    expect(json, json);
  });
}
