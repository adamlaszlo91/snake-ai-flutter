import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_ai/config.dart';

class Board extends StatelessWidget {
  final List<Point> snake;
  final Point powerUp;

  const Board({super.key, required this.snake, required this.powerUp});

  Color _colorOfPosition({required int x, required int y}) {
    final position = Point(x, y);
    if (snake.contains(position)) {
      return Colors.red;
    } else if (position == powerUp) {
      return Colors.orange;
    }
    return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Row(
        mainAxisSize: MainAxisSize.max,
          children: [
            for (var x = 0; x < boardSize[0]; x += 1)
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                children: [
                  for (var y = 0; y < boardSize[1]; y += 1)
                    Expanded(
                        child: Container(color: _colorOfPosition(x: x, y: y))),
                ],
              ),
            )
        ],
      ),
    );
  }
}
