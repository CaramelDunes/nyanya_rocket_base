import 'dart:math';

// Based on https://en.wikipedia.org/wiki/Xorshift

// Warning: Not immutable
class XorShiftState {
  static const int maxUint32 = (1 << 32) - 1;

  // Invariant: a, b, c, d <= maxUint32
  int a;
  int b;
  int c;
  int d;

  XorShiftState.random() {
    final Random rng = Random();

    a = rng.nextInt(1 << 32);
    b = rng.nextInt(1 << 32);
    c = rng.nextInt(1 << 32);
    d = rng.nextInt(1 << 32);
  }

  int nextInt(int max) {
    int t = d;
    final int s = a;
    d = c;
    c = b;
    b = s;

    t ^= (t << 11) & maxUint32; // Because Dart integers are infinite precision.
    t ^= (t >> 8);

    a = t ^ s ^ (s >> 19);

    assert(0 <= a && a <= maxUint32);

    return a % max;
  }
}
