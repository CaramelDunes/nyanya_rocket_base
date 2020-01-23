import 'dart:math';

// Based on https://en.wikipedia.org/wiki/Xorshift

class XorShiftState {
  int a;
  int b;
  int c;
  int d;

  XorShiftState.random() {
    Random rng = Random();

    a = rng.nextInt(1 << 32);
    b = rng.nextInt(1 << 32);
    c = rng.nextInt(1 << 32);
    d = rng.nextInt(1 << 32);
  }
}

int nextXorShiftInt(XorShiftState state, int max) {
  const int maxUint32 = (1 << 32) - 1;

  int t = state.d;
  final int s = state.a;
  state.d = state.c;
  state.c = state.b;
  state.b = s;

  t ^= (t << 11) & maxUint32;
  t ^= (t >> 8) & maxUint32;

  state.a = (t ^ s ^ ((s >> 19) & maxUint32)) & maxUint32;
  return state.a % max;
}
