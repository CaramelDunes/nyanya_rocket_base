import 'dart:math';

import 'package:test/test.dart';
import 'package:nyanya_rocket_base/nyanya_rocket_base.dart';

void main() {
  test(
      'ExposedRandom produces the same sequence of numbers as Random with seed = 1',
      () {
    int seed = 1;
    testSimilarity(seed);
  });

  test(
      'ExposedRandom produces the same sequence of numbers as Random with seed = MicrosSinceUtc & MASK_32',
      () {
    int seed = DateTime.now().microsecondsSinceEpoch & ExposedRandom.MASK_32;
    testSimilarity(seed);
  });

  test(
      'ExposedRandom produces the same sequence of numbers as Random with seed = MicrosSinceUtc & MASK_64',
      () {
    int seed = DateTime.now().microsecondsSinceEpoch & ExposedRandom.MASK_64;
    testSimilarity(seed);
  });

  test(
      'ExposedRandom produces the same sequence of numbers as Random with seed = MicrosSinceUtc',
      () {
    int seed = DateTime.now().microsecondsSinceEpoch;
    testSimilarity(seed);
  });
}

void testSimilarity(int seed) {
  ExposedRandom exposedRandom = ExposedRandom(seed);
  Random random = Random(seed);

  // Fail fast on first int.
  expect(random.nextInt(1 << 32), exposedRandom.nextInt(1 << 32));

  for (int i = 0; i < 100000; i++) {
    expect(random.nextInt(1 << 32), exposedRandom.nextInt(1 << 32));
  }

  for (int i = 1; i < 100000; i++) {
    expect(random.nextInt(i), exposedRandom.nextInt(i));
  }
}
