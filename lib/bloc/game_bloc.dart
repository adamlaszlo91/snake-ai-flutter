import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_ai/bloc/state/direction.dart';
import 'package:snake_ai/bloc/state/game_state.dart';
import 'package:snake_ai/config.dart';

sealed class GameEvent {}

class StartEvent extends GameEvent {}

class StopEvent extends GameEvent {}

class StepEvent extends GameEvent {}

class DirectionChangeEvent extends GameEvent {
  final Direction direction;

  DirectionChangeEvent({required this.direction});
}

class GameBloc extends Bloc<GameEvent, GameState> {
  Timer? _timer;

  GameBloc(super.initialState) {
    on<StartEvent>(
      (event, emit) {
        _timer?.cancel();
        _timer = Timer.periodic(
          const Duration(milliseconds: 500),
          (timer) {
            add(StepEvent());
          },
        );
        // TODO: Use copy instead
        emit(GameState(boardSize: boardSize, running: true));
      },
    );

    on<StopEvent>(
      (event, emit) {
        _timer?.cancel();
        _timer = null;
        emit(state.copyWith(running: false));
      },
    );

    on<DirectionChangeEvent>(
      (event, emit) {
        if (state.direction.opposite() != event.direction) {
          emit(state.copyWith(direction: event.direction));
        }
      },
    );

    on<StepEvent>(
      (event, emit) {
        Point nextSnakeHead(Point point) {
          final nextX = switch (state.direction) {
            Direction.left => point.x - 1,
            Direction.right => point.x + 1,
            _ => point.x
          };

          final nextY = switch (state.direction) {
            Direction.up => point.y - 1,
            Direction.down => point.y + 1,
            _ => point.y
          };

          return Point(nextX, nextY);
        }

        var updatedSnake = [
          nextSnakeHead(state.snakePosition.first),
          ...state.snakePosition
        ];
        final nextState = state.copyWith(snakePosition: updatedSnake);

        if (nextState.hitWall()) {
          add(StopEvent());
        } else if (nextState.hitPowerUp()) {
          final freePositions = nextState.getFreePositions();
          freePositions.shuffle();
          emit(nextState.copyWith(powerUpPosition: freePositions.first));
        } else {
          updatedSnake.removeLast();
          emit(nextState.copyWith(snakePosition: updatedSnake));
        }
      },
    );
  }
}
