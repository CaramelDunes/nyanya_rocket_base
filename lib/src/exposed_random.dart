import 'dart:math';

import 'package:fixnum/fixnum.dart';

// Dart's Random with exposed state for multiplayer deterministic simulation.
class ExposedRandom implements Random {
  late Int64 _state; // uint64_t

  // https://github.com/dart-lang/sdk/blob/master/sdk/lib/_internal/vm/lib/math_patch.dart
  // https://github.com/dart-lang/sdk/blob/master/runtime/vm/random.cc#L35
  ExposedRandom([int? seed]) {
    if (seed == null) {
      seed = DateTime.now().microsecondsSinceEpoch;
    }

    Int64 seed64 = mix64(Int64(seed));

    if (seed64 == 0) {
      seed64 = Int64(0x5a17);
    }

    _state = seed64;
    _nextState();
    _nextState();
    _nextState();
    _nextState();
  }

  ExposedRandom.withState(int state) : this._state = Int64(state);

  int get state => _state.toInt();

  // https://github.com/dart-lang/sdk/blob/master/runtime/lib/math.cc
  static Int64 mix64(Int64 n64) {
    // Thomas Wang 64-bit mix.
    // http://www.concentric.net/~Ttwang/tech/inthash.htm
    // via. http://web.archive.org/web/20071223173210/http://www.concentric.net/~Ttwang/tech/inthash.htm
    n64 = (~n64) + (n64 << 21); // n = (n << 21) - n - 1;
    n64 = n64 ^ n64.shiftRightUnsigned(24);
    n64 = n64 * 265; // n = (n + (n << 3)) + (n << 8);
    n64 = n64 ^ n64.shiftRightUnsigned(14);
    n64 = n64 * 21; // n = (n + (n << 2)) + (n << 4);
    n64 = n64 ^ n64.shiftRightUnsigned(28);
    n64 = n64 + (n64 << 31);

    return n64.toUnsigned(64);
  }

  // The algorithm used here is Multiply with Carry (MWC) with a Base b = 2^32.
  // http://en.wikipedia.org/wiki/Multiply-with-carry
  // The constant A is selected from "Numerical Recipes 3rd Edition" p.348 B1.
  void _nextState() {
    const int A = 0xffffda61;

    Int64 state_lo = _state.toUnsigned(32);
    Int64 state_hi = (_state >> 32).toUnsigned(32);
    _state = (state_lo * A) + state_hi;
  }

  int nextInt(int max) {
    const limit = 0x3FFFFFFF;
    if ((max <= 0) || ((max > limit) && (max > _POW2_32))) {
      throw new RangeError.range(
          max, 1, _POW2_32, "max", "Must be positive and <= 2^32");
    }
    if ((max & -max) == max) {
      // Fast case for powers of two.
      _nextState();
      return _state.toUnsigned(32).toInt() & (max - 1);
    }

    var rnd32;
    var result;
    do {
      _nextState();
      rnd32 = _state.toUnsigned(32).toInt();
      result = rnd32 % max;
    } while ((rnd32 - result + max) > _POW2_32);
    return result;
  }

  double nextDouble() {
    return ((nextInt(1 << 26) * _POW2_27_D) + nextInt(1 << 27)) / _POW2_53_D;
  }

  bool nextBool() {
    return nextInt(2) == 0;
  }

  // Constants used by the algorithm.
  static const _POW2_32 = 1 << 32;
  static const _POW2_53_D = 1.0 * (1 << 53);
  static const _POW2_27_D = 1.0 * (1 << 27);
}
