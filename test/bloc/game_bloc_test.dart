import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snake_ai/bloc/game_bloc.dart';
import 'package:snake_ai/bloc/state/direction.dart';
import 'package:snake_ai/bloc/state/game_state.dart';

void main() {
  group('Game progress', () {
    test('start and stop', () async {
      final bloc = GameBloc(GameState());
      expect(bloc.isGameInProgress(), false);
      bloc.add(StartEvent());
      await Future.delayed(Duration.zero);
      expect(bloc.isGameInProgress(), true);
      bloc.add(StopEvent());
      await Future.delayed(Duration.zero);
      expect(bloc.isGameInProgress(), false);
    });
  });

  blocTest(
    'Start event',
    build: () => GameBloc(GameState()),
    act: (bloc) => bloc.add(StartEvent()),
    expect: () =>
        [isA<GameState>().having((obj) => obj.running, 'running', true)],
  );

  blocTest('Stop event',
      build: () => GameBloc(GameState(running: true)),
      act: (bloc) => bloc.add(StopEvent()),
      expect: () =>
          [isA<GameState>().having((obj) => obj.running, 'running', false)]);

  group('Direction event', () {
    blocTest('normal direction change',
        build: () => GameBloc(GameState(direction: Direction.right)),
        act: (bloc) =>
            bloc.add(DirectionChangeEvent(direction: Direction.down)),
        expect: () => [
              isA<GameState>()
                  .having((obj) => obj.direction, 'direction', Direction.down)
            ]);

    blocTest('to the opposite direction',
        build: () => GameBloc(GameState(direction: Direction.right)),
        act: (bloc) =>
            bloc.add(DirectionChangeEvent(direction: Direction.left)),
        expect: () => []);
  });
}
