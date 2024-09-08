import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snake_ai/config.dart';

class Board extends StatelessWidget {
  final List<Point> snake;

  const Board({super.key, required this.snake});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          for (var x = 0; x < boardWidth; x += 1)
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  for (var y = 0; y < boardHeight; y += 1)
                    Expanded(
                        child: Container(
                      color: snake.contains(Point(x, y))
                          ? Colors.red
                          : Colors.blue,
                    ))
                ],
              ),
            )
        ],
      ),
    );
  }
}
