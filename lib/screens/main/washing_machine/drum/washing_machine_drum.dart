import 'dart:math';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/screens/main/washing_machine/drum/physic/drum_physic.dart';
import 'package:flutter_whirlpool/screens/main/washing_machine/drum/physic/drum_physic_renderer.dart';
import 'package:flutter_whirlpool/screens/main/washing_machine/washing_machine_controller.dart';
import 'package:flutter_whirlpool/shared/colors.dart';
import 'package:flutter_whirlpool/shared/utils.dart';

class WashingMachineDrum extends LeafRenderObjectWidget {
  const WashingMachineDrum(this.controller, {Key? key}) : super(key: key);

  final WashingMachineController? controller;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return WhirlpoolRenderObject()..controller = controller;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant WhirlpoolRenderObject renderObject) {
    if (renderObject.controller != controller) {
      renderObject.controller = controller;
    }
  }
}

class WhirlpoolRenderObject extends RenderBox {
  final DrumPhysicRenderer _physicRenderer = DrumPhysicRenderer(ppm: DrumPhysic.ppm);

  WashingMachineController? get controller => _controller;

  WashingMachineController? _controller;
  double _lastTimeStamp = 0.0;

  set controller(WashingMachineController? value) {
    if (_controller == value) {
      return;
    }

    _controller = value;
    _controller!.onNeedPaint = markNeedsPaint;
    markNeedsPaint();
    markNeedsLayout();

    SchedulerBinding.instance.scheduleFrameCallback(frame);
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  bool get sizedByParent => true;

  @override
  void paint(PaintingContext context, Offset offset) {
    _drawDrum(context, offset);
    _drawWhirlpool(context, offset);

    // debug draw whirlpool circle body
    // _physicRenderer.renderBody(
    //     context.canvas, controller.physic.whirlpoolCoreBody);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.biggest;
  }

  frame(Duration timeStamp) {
    final double t =
        timeStamp.inMicroseconds / Duration.microsecondsPerMillisecond / 1000.0;

    if (_lastTimeStamp == 0) {
      _lastTimeStamp = t;
      SchedulerBinding.instance.scheduleFrameCallback(frame);
      return;
    }

    double elapsed = (t - _lastTimeStamp).clamp(0.0, 1.0);
    _lastTimeStamp = t;

    controller?.step(elapsed);
    controller?.redraw();
    SchedulerBinding.instance.scheduleFrameCallback(frame);
  }

  _drawWhirlpool(PaintingContext context, Offset offset) {
    if (controller!.devMode != true) {
      context.pushLayer(
          ColorFilterLayer(
            colorFilter: const ColorFilter.matrix(
              [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 20, -1200],
            ),
          ),
          (PaintingContext context2, Offset offset2) => context2.pushLayer(
                ImageFilterLayer(
                  imageFilter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
                ),
                (PaintingContext context3, Offset offset3) =>
                    _drawBalls(context3, offset3),
                offset2,
              ),
          offset);
    } else {
      _drawBalls(context, offset);
    }
  }

  _drawBalls(PaintingContext context, Offset offset) async {
    Canvas canvas = context.canvas;
    var rect = Rect.fromLTWH(
        controller!.physic.origin.dx - controller!.physic.radius!,
        controller!.physic.origin.dy - controller!.physic.radius!,
        controller!.physic.radius! * 2,
        controller!.physic.radius! * 2);
    canvas.save();
    canvas.clipPath(Path()..addOval(rect));

    for (var body in controller!.physic.balls) {
      _physicRenderer.renderBody(canvas, body);
    }
    canvas.restore();
  }

  _drawDrum(PaintingContext context, Offset offset) {
    Canvas canvas = context.canvas;
    canvas.drawRect(
      context.estimatedBounds,
      Paint()..color = CustomColors.drumBackground,
    );

    Path washingMachineRibForeground =
        _createDrumPath(3, 10, context.estimatedBounds);
    Path washingMachineRibBackground = _createDrumPath(
      3,
      10,
      context.estimatedBounds,
      convexity: 30,
    );

    canvas.save();
    canvas.translate(
        context.estimatedBounds.center.dx, context.estimatedBounds.center.dy);
    canvas.rotate(controller!.drumAngle);
    canvas.scale(1.05);
    canvas.translate(
        -context.estimatedBounds.center.dx, -context.estimatedBounds.center.dy);

    canvas.drawPath(
        washingMachineRibBackground,
        Paint()
          ..color = CustomColors.drumRibBackground
          ..style = PaintingStyle.fill);

    canvas.drawPath(
        washingMachineRibForeground,
        Paint()
          ..color = CustomColors.drumRibForeground
          ..style = PaintingStyle.fill);

    canvas.restore();

    canvas.drawRect(
      context.estimatedBounds,
      Paint()
        ..shader = RadialGradient(
          colors: CustomColors.drumInnerShadowColors,
          stops: const [
            0.85,
            1,
          ],
        ).createShader(context.estimatedBounds),
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
        ..multiply(Matrix4.rotationZ(Utils.degToRad(i * stepRotationAngle)))
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
    double x = center.dx + r * cos(Utils.degToRad(angleDegree));
    double y = center.dy + r * sin(Utils.degToRad(angleDegree));

    return Offset(x, y);
  }
}
