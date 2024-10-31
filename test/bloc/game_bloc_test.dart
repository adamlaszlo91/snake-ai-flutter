import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:snake_ai/bloc/game_bloc.dart';
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

  blocTest('Stop event',
      build: () => GameBloc(GameState(running: true)),
      act: (bloc) => bloc.add(StopEvent()),
      expect: () => [GameState().copyWith(running: false)]);
}
