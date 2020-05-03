import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/screens/main/washing_machine/washing_machine_controller.dart';

class WashingMachineDrum extends LeafRenderObjectWidget {
  WashingMachineDrum(this.controller, {Key key}) : super(key: key);

  final WashingMachineController controller;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _WhirlpoolRenderObject()..controller = controller;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _WhirlpoolRenderObject renderObject) {
    if (renderObject.controller != controller) {
      renderObject.controller = controller;
    }
  }

  @override
  didUnmountRenderObject(covariant _WhirlpoolRenderObject renderObject) {
    renderObject?.controller?.dispose();
  }
}

class _WhirlpoolRenderObject extends RenderBox {
  WashingMachineController _controller;

  WashingMachineController get controller => _controller;

  set controller(WashingMachineController value) {
    if (_controller == value) {
      return;
    } else {
      _controller?.dispose();
    }

    _controller = value;
    _controller.onNeedPaint = markNeedsPaint;
    markNeedsPaint();
    markNeedsLayout();
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  bool get sizedByParent => true;

  @override
  void paint(PaintingContext context, Offset offset) {
    _drawDrum(context, offset);
  }

  _drawDrum(PaintingContext context, Offset offset) {
    Canvas canvas = context.canvas;
    canvas.drawRect(
      context.estimatedBounds,
      Paint()..color = Color.fromARGB(255, 233, 244, 249),
    );

    Path washingMachine = _createDrumPath(3, 10, context.estimatedBounds);
    Path washingMachineBackground = _createDrumPath(
      3,
      10,
      context.estimatedBounds,
      convexity: 30,
    );

    canvas.save();
    canvas.translate(
        context.estimatedBounds.center.dx, context.estimatedBounds.center.dy);
    canvas.rotate(_degToRad(controller.drumAngle));
    canvas.scale(1.05);
    canvas.translate(
        -context.estimatedBounds.center.dx, -context.estimatedBounds.center.dy);

    canvas.drawPath(
        washingMachineBackground,
        Paint()
          ..color = Color.fromARGB(255, 228, 238, 247)
          ..style = PaintingStyle.fill
          ..strokeWidth = 2);

    canvas.drawPath(
        washingMachine,
        Paint()
          ..color = Color.fromARGB(255, 236, 244, 250)
          ..style = PaintingStyle.fill
          ..strokeWidth = 2);

    canvas.restore();

    canvas.drawRect(
      context.estimatedBounds,
      Paint()
        ..color = Color.fromARGB(255, 233, 244, 249)
        ..shader = RadialGradient(colors: [
          Color.fromARGB(0, 255, 255, 255),
          Color.fromARGB(120, 202, 213, 225),
        ], stops: [
          0.85,
          1,
        ]).createShader(context.estimatedBounds),
    );
  }

  Path _createDrumPath(int segments, double angleOffset, Rect bounds,
      {double convexity = 0.0}) {
    Offset center = bounds.center;
    double startAngle = 360.0 - 90.0;
    double stepRotationAngle = 360 / segments;
    Path basePath = _createDrumBasePath(
      segments,
      startAngle,
      angleOffset,
      bounds,
      convexity: convexity,
    );

    Path result = Path();

    for (int i = 0; i < segments; i++) {
      Matrix4 transformMatrix = Matrix4.identity()
        ..translate(center.dx, center.dy)
        ..multiply(Matrix4.rotationZ(_degToRad(i * stepRotationAngle)))
        ..translate(-center.dx, -center.dy);

      result.extendWithPath(basePath, Offset.zero,
          matrix4: transformMatrix.storage);
    }

    return result;
  }

  Path _createDrumBasePath(
    int segments,
    double startAngle,
    double angleOffset,
    Rect bounds, {
    double convexity = 0.0,
  }) {
    Offset center = bounds.center;
    double r = bounds.width / 2;
    double stepRotationAngle = 360 / segments;

    double startPointAngle = startAngle + angleOffset;
    double endPointAngle = startAngle + stepRotationAngle - angleOffset;
    Offset startPoint = _findPoint(center, r, startPointAngle);
    Offset endPoint = _findPoint(center, r, endPointAngle);
    Offset controlPoint1 =
        Offset(startPoint.dx + convexity - 10, center.dy - convexity + 10);
    Offset controlPoint2 = Offset(endPoint.dx - 35, endPoint.dy - 28);

    return Path()
      ..moveTo(startPoint.dx, startPoint.dy)
      ..cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, endPoint.dx, endPoint.dy);
  }

  Offset _findPoint(Offset center, double r, double angleDegree) {
    double x = center.dx + r * cos(_degToRad(angleDegree));
    double y = center.dy + r * sin(_degToRad(angleDegree));

    return Offset(x, y);
  }

  double _degToRad(double angle) {
    return pi * angle / 180.0;
  }
}
