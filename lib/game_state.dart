import 'dart:math';

import 'package:snake_ai/config.dart';

enum Direction { left, right, up, down }

extension DirectionOpposite on Direction {
  Direction opposite() {
    return switch (this) {
      Direction.left => Direction.right,
      Direction.right => Direction.left,
      Direction.up => Direction.down,
      Direction.down => Direction.up
    };
  }
}

class GameState {
  final bool running;
  final List<Point> snake;
  final Direction direction;

  GameState(
      {this.running = false,
      this.snake = const [Point(3, 0), Point(2, 0), Point(1, 0), Point(0, 0)],
      this.direction = Direction.right});

  GameState copyWith(
      {bool? running, List<Point>? snake, Direction? direction}) {
    return GameState(
        running: running ?? this.running,
        snake: snake ?? this.snake,
        direction: direction ?? this.direction);
  }

  bool isLossState() {
    final snakeHead = snake.first;
    if (snakeHead.x < 0 || snakeHead.x >= boardWidth) {
      return true;
    }
    if (snakeHead.y < 0 || snakeHead.y >= boardHeight) {
      return true;
    }
    return false;
  }
}
