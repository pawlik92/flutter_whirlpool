import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:forge2d/forge2d.dart';

class DrumPhysicRenderer {
  DrumPhysicRenderer({
    required this.ppm,
  });

  final double ppm;

  renderBody(Canvas canvas, Body body) {
    double angle = body.angle;
    Vector2 position = body.position * ppm;
    Color? color = body.userData as Color?;

    Matrix4 matrix = Matrix4.identity()
      ..leftTranslate(position.x, position.y)
      ..rotateZ(angle);
    canvas.save();
    canvas.transform(matrix.storage);

    for (Fixture f in body.fixtures) {
      if (f.type == ShapeType.circle) {
        _drawCircleShape(canvas, f.shape as CircleShape, color);
      } else if (f.type == ShapeType.polygon) {
        _drawPolygonShape(canvas, f.shape as PolygonShape, color);
      } else if (f.type == ShapeType.chain) {
        _drawChainShape(canvas, f.shape as ChainShape, color);
      }
    }

    canvas.restore();
  }

  _drawCircleShape(Canvas canvas, CircleShape circle, Color? color) {
    canvas.drawCircle(
        Offset(circle.position.x * ppm, circle.position.x * ppm),
        circle.radius * ppm,
        Paint()
          ..style = PaintingStyle.fill
          ..color = color ?? Colors.amber);
  }

  _drawPolygonShape(Canvas canvas, PolygonShape polygon, Color? color) {
    int verticesCount = polygon.vertices.length;
    List<Offset> points = [];
    for (int i = 0; i < verticesCount; i++) {
      Vector2 vertice = polygon.vertices[i] * ppm;
      points.add(Offset(vertice.x, vertice.y));
    }

    canvas.drawRect(
        Rect.fromLTRB(points[0].dx, points[2].dy, points[2].dx, points[0].dy),
        Paint()
          ..strokeWidth = 1
          ..style = PaintingStyle.fill
          ..color = color ?? Colors.blue);
  }

  _drawChainShape(Canvas canvas, ChainShape chain, Color? color) {
    List<Offset> points = [];
    int vertexCount = chain.vertexCount;

    for (int i = 0; i < vertexCount; i++) {
      Vector2 vertex = chain.vertex(i) * ppm;
      points.add(Offset(vertex.x, vertex.y));
    }

    canvas.drawPoints(
        PointMode.lines,
        points,
        Paint()
          ..strokeWidth = 1
          ..style = PaintingStyle.fill
          ..color = color ?? Colors.green);
  }
}
