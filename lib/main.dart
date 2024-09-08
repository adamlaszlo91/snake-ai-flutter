import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_ai/board.dart';
import 'package:snake_ai/game_bloc.dart';
import 'package:snake_ai/game_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<GameBloc>(
          create: (context) {
            return GameBloc(GameState());
          },
          child: const MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                context.read<GameBloc>().add(StartEvent());
              },
              child: const Text('Start')),
          ElevatedButton(
              onPressed: () {
                context
                    .read<GameBloc>()
                    .add(DirectionChangeEvent(direction: Direction.right));
              },
              child: const Text('Right')),
          ElevatedButton(
              onPressed: () {
                context
                    .read<GameBloc>()
                    .add(DirectionChangeEvent(direction: Direction.left));
              },
              child: const Text('Left')),
          ElevatedButton(
              onPressed: () {
                context
                    .read<GameBloc>()
                    .add(DirectionChangeEvent(direction: Direction.up));
              },
              child: const Text('Up')),
          ElevatedButton(
              onPressed: () {
                context
                    .read<GameBloc>()
                    .add(DirectionChangeEvent(direction: Direction.down));
              },
              child: const Text('Down')),
          BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              return Board(snake: state.snake);
            },
            buildWhen: (previous, current) => previous.snake != current.snake,
          )
        ],
      ),
    );
  }
}
