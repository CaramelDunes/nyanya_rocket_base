import 'dart:math';

import 'package:fixnum/fixnum.dart';
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
      'ExposedRandom produces the same sequence of numbers as Random with seed = Int32(MicrosSinceUtc)',
      () {
    int seed = Int32(DateTime.now().microsecondsSinceEpoch).toInt();
    testSimilarity(seed);
  });

  test(
      'ExposedRandom produces the same sequence of numbers as Random with seed = Int64(MicrosSinceUtc)',
      () {
    int seed = Int64(DateTime.now().microsecondsSinceEpoch).toInt();
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
