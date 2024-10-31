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
