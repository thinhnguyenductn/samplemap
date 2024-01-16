import 'dart:ui';
import 'package:flutter/material.dart';
import 'app_node.dart';

class PathFinderPainter extends CustomPainter {
  PathFinderPainter(this.nodes, this.path, this.start, this.end);

  final List<List<Node>> nodes;
  final List<Node> path;
  final Node start;
  final Node end;

  @override
  void paint(Canvas canvas, Size size) {
    final double cellSize = size.height / nodes.length;
    final double halfCellSize = cellSize / 2;

    if (path.isNotEmpty) {
      _drawPath(cellSize, canvas, halfCellSize);
    }

    _drawNodes(canvas, cellSize, halfCellSize);
  }

  void _drawNodes(Canvas canvas, double cellSize, double halfCellSize) {
    for (int i = 0; i < nodes.length; i++) {
      for (int j = 0; j < nodes[i].length; j++) {
        final Node node = nodes[i][j];
        final Paint paint = Paint()..color = _getNodeColor(node);

        canvas.drawCircle(
          Offset(j * cellSize + halfCellSize, i * cellSize + halfCellSize),
          cellSize / _getNodeSize(node),
          paint,
        );
      }
    }
  }

  void _drawPath(double cellSize, Canvas canvas, double halfCellSize) {
    final Paint pathPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = cellSize / 6;

    for (int i = 0; i < path.length - 1; i++) {
      final Node node = path[i];
      final Node nextNode = path[i + 1];

      canvas.drawPoints(
        PointMode.lines,
        <Offset>[
          node.position * cellSize + Offset(halfCellSize, halfCellSize),
          nextNode.position * cellSize + Offset(halfCellSize, halfCellSize),
        ],
        pathPaint,
      );
    }
  }

  double _getNodeSize(Node node) {
    if (node == start || node == end || node.isWall) {
      return 5;
    }

    // if (node.visited) {
    //   return 6;
    // }

    return 24;
  }

  Color _getNodeColor(Node node) {
    if (node == start || node == end) {
      return Colors.yellow;
    }

    // if (node.visited) {
    //   return Colors.red;
    // }

    return Colors.white;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
