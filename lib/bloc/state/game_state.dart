import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:snake_ai/bloc/state/direction.dart';

class GameState extends Equatable {
  final List<int> boardSize;
  final bool running;
  final List<Point> snakePosition;
  final Direction direction;
  final Point powerUpPosition;

  const GameState({
    this.boardSize = const <int>[16, 16],
    this.running = false,
    this.snakePosition = const [
      Point(3, 0),
      Point(2, 0),
      Point(1, 0),
      Point(0, 0)
    ],
    this.direction = Direction.right,
    this.powerUpPosition = const Point(-1, -1),
  });

  GameState copyWith(
      {bool? running,
      List<Point>? snakePosition,
      Direction? direction,
      Point? powerUpPosition}) {
    return GameState(
        boardSize: boardSize,
        running: running ?? this.running,
        snakePosition: snakePosition ?? this.snakePosition,
        direction: direction ?? this.direction,
        powerUpPosition: powerUpPosition ?? this.powerUpPosition);
  }

  bool hitWall() {
    final snakeHead = snakePosition.first;
    if (snakeHead.x < 0 || snakeHead.x >= boardSize[0]) {
      return true;
    }
    if (snakeHead.y < 0 || snakeHead.y >= boardSize[1]) {
      return true;
    }
    return false;
  }

  bool hitPowerUp() {
    return snakePosition.first == powerUpPosition;
  }

  bool hitSelf() {
    for (var snakeBodyPosition
        in snakePosition.sublist(1, snakePosition.length)) {
      if (snakeBodyPosition == snakePosition.first) {
        return true;
      }
    }
    return false;
  }

  List<Point> getFreePositions() {
    final List<Point> freePositions = [];
    for (var x = 0; x < boardSize[0]; x += 1) {
      for (var y = 0; y < boardSize[1]; y += 1) {
        final position = Point(x, y);
        if (!snakePosition.contains(position) && powerUpPosition != position) {
          freePositions.add(position);
        }
      }
    }
    return freePositions;
  }

  @override
  // TODO: Test
  List<Object?> get props =>
      [boardSize, running, snakePosition, direction, powerUpPosition];
}
