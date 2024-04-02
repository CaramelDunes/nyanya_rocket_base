import 'package:test/test.dart';
import 'dart:convert';

import 'package:nyanya_rocket_base/nyanya_rocket_base.dart';

String useTheWallsPuzzle =
    '{"name":"Use The Walls","gameData":"{\\"board\\":{\\"tiles\\":[[{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0}],[{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0}],[{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0}],[{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0}],[{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0}],[{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0}],[{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0}],[{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0}],[{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0}],[{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0}],[{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":3,\\"player\\":0}],[{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0},{\\"type\\":0}]],\\"walls\\":[[3,1,1,1,1,1,1,1,1],[2,3,0,1,0,3,0,1,2],[2,0,0,0,0,0,0,0,0],[2,0,0,0,0,0,0,0,0],[2,0,0,0,0,0,0,0,0],[2,0,0,2,0,0,2,2,0],[2,0,0,3,0,1,2,1,0],[2,0,0,0,0,0,0,0,0],[2,0,0,0,0,0,0,0,0],[2,0,0,0,0,0,0,0,2],[2,2,0,0,2,0,0,0,1],[2,1,0,1,0,1,0,0,1]]},\\"entities\\":[{\\"type\\":1,\\"position\\":{\\"x\\":11,\\"y\\":8,\\"direction\\":1}},{\\"type\\":1,\\"position\\":{\\"x\\":11,\\"y\\":7,\\"direction\\":1}},{\\"type\\":1,\\"position\\":{\\"x\\":11,\\"y\\":6,\\"direction\\":1}},{\\"type\\":1,\\"position\\":{\\"x\\":11,\\"y\\":5,\\"direction\\":1}},{\\"type\\":1,\\"position\\":{\\"x\\":11,\\"y\\":4,\\"direction\\":1}},{\\"type\\":1,\\"position\\":{\\"x\\":11,\\"y\\":3,\\"direction\\":1}},{\\"type\\":1,\\"position\\":{\\"x\\":11,\\"y\\":1,\\"direction\\":1}},{\\"type\\":1,\\"position\\":{\\"x\\":11,\\"y\\":2,\\"direction\\":1}},{\\"type\\":1,\\"position\\":{\\"x\\":11,\\"y\\":0,\\"direction\\":2}},{\\"type\\":1,\\"position\\":{\\"x\\":10,\\"y\\":0,\\"direction\\":2}},{\\"type\\":1,\\"position\\":{\\"x\\":9,\\"y\\":0,\\"direction\\":2}},{\\"type\\":1,\\"position\\":{\\"x\\":8,\\"y\\":0,\\"direction\\":2}},{\\"type\\":1,\\"position\\":{\\"x\\":7,\\"y\\":0,\\"direction\\":2}},{\\"type\\":1,\\"position\\":{\\"x\\":6,\\"y\\":0,\\"direction\\":2}},{\\"type\\":1,\\"position\\":{\\"x\\":5,\\"y\\":0,\\"direction\\":2}},{\\"type\\":1,\\"position\\":{\\"x\\":4,\\"y\\":0,\\"direction\\":2}},{\\"type\\":1,\\"position\\":{\\"x\\":3,\\"y\\":0,\\"direction\\":2}},{\\"type\\":1,\\"position\\":{\\"x\\":2,\\"y\\":0,\\"direction\\":2}},{\\"type\\":1,\\"position\\":{\\"x\\":1,\\"y\\":0,\\"direction\\":2}},{\\"type\\":1,\\"position\\":{\\"x\\":0,\\"y\\":0,\\"direction\\":3}},{\\"type\\":1,\\"position\\":{\\"x\\":0,\\"y\\":1,\\"direction\\":3}},{\\"type\\":1,\\"position\\":{\\"x\\":0,\\"y\\":2,\\"direction\\":3}},{\\"type\\":1,\\"position\\":{\\"x\\":0,\\"y\\":3,\\"direction\\":3}},{\\"type\\":1,\\"position\\":{\\"x\\":0,\\"y\\":4,\\"direction\\":3}},{\\"type\\":1,\\"position\\":{\\"x\\":0,\\"y\\":5,\\"direction\\":3}},{\\"type\\":1,\\"position\\":{\\"x\\":0,\\"y\\":6,\\"direction\\":3}},{\\"type\\":1,\\"position\\":{\\"x\\":0,\\"y\\":7,\\"direction\\":3}},{\\"type\\":1,\\"position\\":{\\"x\\":1,\\"y\\":8,\\"direction\\":0}},{\\"type\\":1,\\"position\\":{\\"x\\":2,\\"y\\":8,\\"direction\\":0}},{\\"type\\":1,\\"position\\":{\\"x\\":3,\\"y\\":8,\\"direction\\":0}},{\\"type\\":1,\\"position\\":{\\"x\\":4,\\"y\\":8,\\"direction\\":0}},{\\"type\\":1,\\"position\\":{\\"x\\":5,\\"y\\":8,\\"direction\\":0}},{\\"type\\":1,\\"position\\":{\\"x\\":6,\\"y\\":8,\\"direction\\":0}},{\\"type\\":1,\\"position\\":{\\"x\\":7,\\"y\\":8,\\"direction\\":0}},{\\"type\\":1,\\"position\\":{\\"x\\":8,\\"y\\":8,\\"direction\\":0}},{\\"type\\":1,\\"position\\":{\\"x\\":9,\\"y\\":8,\\"direction\\":2}},{\\"type\\":1,\\"position\\":{\\"x\\":0,\\"y\\":8,\\"direction\\":3}}]}","arrows":[0,1,0,0]}';

String oneHundredMice1 =
    '{"board":{"tiles":[[{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":4,"direction":0},{"type":4,"direction":0}],[{"type":0},{"type":0},{"type":0},{"type":3,"player":0},{"type":3,"player":0},{"type":0},{"type":0},{"type":0},{"type":0}],[{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0}],[{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0}],[{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0}],[{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0}],[{"type":0},{"type":0},{"type":0},{"type":3,"player":0},{"type":3,"player":0},{"type":3,"player":0},{"type":0},{"type":0},{"type":0}],[{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0}],[{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0}],[{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0},{"type":0}],[{"type":0},{"type":0},{"type":0},{"type":3,"player":0},{"type":3,"player":0},{"type":0},{"type":0},{"type":0},{"type":0}],[{"type":4,"direction":2},{"type":4,"direction":2},{"type":0},{"type":3,"player":0},{"type":3,"player":0},{"type":3,"player":0},{"type":0},{"type":0},{"type":0}]],"walls":[[3,1,3,1,1,1,1,3,1],[2,0,0,0,0,0,0,0,0],[2,0,0,0,0,0,0,0,0],[2,0,0,0,2,0,0,0,0],[2,0,0,1,3,0,0,0,0],[2,0,0,0,0,0,0,0,0],[2,0,0,0,0,0,0,0,0],[2,0,0,0,0,0,0,0,0],[2,0,0,0,2,2,0,0,0],[2,0,0,0,0,0,0,0,0],[2,0,0,0,0,0,0,0,0],[2,0,2,0,0,0,0,2,0]]},"entities":[]}';

GameState loadNamedGameJson(String gameJson) {
  return GameState.fromJson(jsonDecode(jsonDecode(gameJson)['gameData']));
}

const updateCount = 1000000;

void main() {
  test('run puzzle simulation for a lot of ticks', () {
    GameState game = loadNamedGameJson(useTheWallsPuzzle);
    GameSimulator simulator = PuzzleGameSimulator();

    var stopwatch = Stopwatch()..start();
    for (int i = 0; i < updateCount; i++) {
      simulator.update(game);
    }
    stopwatch.stop();

    assert(stopwatch.elapsedMilliseconds / updateCount < 0.1);
  });

  test('run challenge simulation for a lot of ticks', () {
    GameState game = GameState.fromJson(jsonDecode(oneHundredMice1));
    GameSimulator simulator = ChallengeGameSimulator();

    var stopwatch = Stopwatch()..start();
    for (int i = 0; i < updateCount; i++) {
      simulator.update(game);
    }
    stopwatch.stop();

    assert(stopwatch.elapsedMilliseconds / updateCount < 0.1);
  });
}
