import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:snake_ai/bloc/state/direction.dart';
import 'package:snake_ai/bloc/state/game_state.dart';

void main() {
  group('Copy', () {
    test('all', () {
      final running = true;
      final snakePosition = [Point(0, 0)];
      final direction = Direction.left;
      final powerUpPosition = Point(0, 0);

      final copy = GameState(
          running: running,
          snakePosition: snakePosition,
          direction: direction,
          powerUpPosition: powerUpPosition);
      expect(copy.running, running);
      expect(copy.snakePosition, snakePosition);
      expect(copy.direction, direction);
      expect(copy.powerUpPosition, powerUpPosition);
    });
  });

  group('Hitting wall', () {
    test('nowhere', () {
      final snakePosition = [Point(0, 0), Point(1, 0)];
      final state = GameState(snakePosition: snakePosition);
      expect(state.hitWall(), false);
    });

    test('to left', () {
      final snakePosition = [Point(-1, 0), Point(0, 0)];
      final state = GameState(snakePosition: snakePosition);
      expect(state.hitWall(), true);
    });

    test('to right', () {
      final snakePosition = [Point(10, 0), Point(9, 0)];
      final state =
          GameState(boardSize: [10, 10], snakePosition: snakePosition);
      expect(state.hitWall(), true);
    });

    test('to top', () {
      final snakePosition = [Point(0, -1), Point(0, 0)];
      final state = GameState(snakePosition: snakePosition);
      expect(state.hitWall(), true);
    });

    test('to down', () {
      final snakePosition = [Point(11, 5), Point(0, 5)];
      final state =
          GameState(boardSize: [10, 10], snakePosition: snakePosition);
      expect(state.hitWall(), true);
    });
  });

  group('Hit power up', () {
    test('nowhere', () {
      final snakePosition = [Point(0, 0), Point(1, 0)];
      final state = GameState(snakePosition: snakePosition);
      expect(state.hitWall(), false);
    });

    test('on head', () {
      final snakePosition = [Point(0, 0), Point(1, 0)];
      final state = GameState(snakePosition: snakePosition);
      expect(state.hitWall(), false);
    });
  });

  test('Get free positions', () {
    final snakePosition = [Point(1, 0), Point(0, 0)];
    final state = GameState(boardSize: [3, 2], snakePosition: snakePosition);
    expect(state.getFreePositions(), [
      Point(0, 1),
      Point(1, 1),
      Point(2, 0),
      Point(2, 1),
    ]);
  });

  group('Hit self', () {
    test('nowhere', () {
      final snakePosition = [Point(0, 0), Point(1, 0)];
      final state = GameState(snakePosition: snakePosition);
      expect(state.hitSelf(), false);
    });

    test('somewhere', () {
      final snakePosition = [
        Point(0, 0),
        Point(1, 0),
        Point(2, 0),
        Point(2, 1),
        Point(1, 1),
        Point(0, 1),
        Point(0, 0)
      ];
      final state = GameState(snakePosition: snakePosition);
      expect(state.hitSelf(), true);
    });
  });
}
