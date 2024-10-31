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

  bool isGameInProgress() {
    return _timer?.isActive ?? false;
  }

  GameBloc(super.initialState) {
    // TODO: Start event should not create a new state when we already have one in the constructor
    on<StartEvent>(
      (event, emit) {
        _timer?.cancel();
        _timer = Timer.periodic(
          const Duration(milliseconds: 250),
          (timer) {
            add(StepEvent());
          },
        );
        var state = GameState(boardSize: boardSize);
        state = state.copyWith(
            running: true,
            powerUpPosition: _selectRandomPosition(state.getFreePositions()));
        emit(state);
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
          emit(nextState.copyWith(
              powerUpPosition:
                  _selectRandomPosition(nextState.getFreePositions())));
        } else {
          updatedSnake.removeLast();
          emit(nextState.copyWith(snakePosition: updatedSnake));
        }
      },
    );
  }

  Point _selectRandomPosition(List<Point> positions) {
    return positions[Random().nextInt(positions.length)];
  }
}
