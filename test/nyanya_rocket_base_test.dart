import 'package:test/test.dart';

import 'package:nyanya_rocket_base/nyanya_rocket_base.dart';

void main() {
  test('create an empty game', () {
    final calculator = Game();
    expect(calculator.scoreOf(PlayerColor.Blue), 0);
  });
}
