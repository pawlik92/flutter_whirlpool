import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DrumPhysicRenderer {
  DrumPhysicRenderer({
    @required this.ppm,
  });

  final double ppm;

  renderBody(Canvas canvas, Body body) {
    if (body == null) {
      return;
    }

    double angle = body.getAngle();
    Vector2 position = body.position * ppm;
    Color color = body.userData as Color;

    Matrix4 matrix = Matrix4.identity()
      ..leftTranslate(position.x, position.y)
      ..rotateZ(angle);
    canvas.save();
    canvas.transform(matrix.storage);

    for (Fixture f = body.getFixtureList(); f != null; f = f.getNext()) {
      if (f.getType() == ShapeType.CIRCLE) {
        _drawCircleShape(canvas, f.getShape(), color);
      } else if (f.getType() == ShapeType.POLYGON) {
        _drawPolygonShape(canvas, f.getShape(), color);
      } else if (f.getType() == ShapeType.CHAIN) {
        _drawChainShape(canvas, f.getShape(), color);
      }
    }

    canvas.restore();
  }

  _drawCircleShape(Canvas canvas, CircleShape circle, Color color) {
    canvas.drawCircle(
        Offset(circle.p.x * ppm, circle.p.x * ppm),
        circle.radius * ppm,
        Paint()
          ..style = PaintingStyle.fill
          ..color = color != null ? color : Colors.amber);
  }

  _drawPolygonShape(Canvas canvas, PolygonShape polygon, Color color) {
    int vertexCount = polygon.getVertexCount();
    List<Offset> points = [];
    for (int i = 0; i < vertexCount; i++) {
      Vector2 vertex = polygon.getVertex(i) * ppm;
      points.add(Offset(vertex.x, vertex.y));
    }

    canvas.drawRect(
        Rect.fromLTRB(points[0].dx, points[2].dy, points[2].dx, points[0].dy),
        Paint()
          ..strokeWidth = 1
          ..style = PaintingStyle.fill
          ..color = color != null ? color : Colors.blue);
  }

  _drawChainShape(Canvas canvas, ChainShape chain, Color color) {
    List<Offset> points = [];
    int vertexCount = chain.getVertexCount();

    for (int i = 0; i < vertexCount; i++) {
      Vector2 vertex = chain.getVertex(i) * ppm;
      points.add(Offset(vertex.x, vertex.y));
    }

    canvas.drawPoints(
        PointMode.lines,
        points,
        Paint()
          ..strokeWidth = 1
          ..style = PaintingStyle.fill
          ..color = color != null ? color : Colors.green);
  }
}
