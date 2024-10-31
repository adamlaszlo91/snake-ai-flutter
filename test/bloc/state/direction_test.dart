import 'package:flutter_test/flutter_test.dart';
import 'package:snake_ai/bloc/state/direction.dart';

void main() {
  group('Direction opposite', () {
    test('up', () {
      expect(Direction.up.opposite(), Direction.down);
    });
    test('down', () {
      expect(Direction.down.opposite(), Direction.up);
    });
    test('right', () {
      expect(Direction.right.opposite(), Direction.left);
    });
    test('left', () {
      expect(Direction.left.opposite(), Direction.right);
    });
  });
}
