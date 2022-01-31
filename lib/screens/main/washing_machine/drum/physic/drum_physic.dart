import 'dart:math';
import 'dart:async' as dartAsync;

import 'package:flutter/rendering.dart';
import 'package:forge2d/forge2d.dart';

class DrumPhysic {
  static const double GRAVITY = 9.8;
  static const double WHIRLPOOL_CIRCLE_SEGMENTS = 28;
  static const double BALL_RADIUS = 16;
  static const double PPM = 100;

  static const Color BALL_COLOR_BLUE = Color.fromARGB(255, 62, 36, 251);
  static const Color BALL_COLOR_AQUA = Color.fromARGB(255, 39, 230, 227);
  static const Color BALL_COLOR_ORANGE = Color.fromARGB(255, 253, 112, 33);
  static const Color BALL_COLOR_PINK = Color.fromARGB(255, 253, 66, 193);

  DrumPhysic({
    required this.ballsCount,
  }) : this.world = World(Vector2(0, GRAVITY)) {
    assert(ballsCount > 0);

    // forge2d settings
    velocityIterations = 5;
    positionIterations = 5;
  }

  final World world;
  final int ballsCount;
  final _random = Random();

  Offset get origin {
    return Offset(radius!, radius!);
  }

  double? get radius => _radius;

  double? _radius;
  late Body whirlpoolCoreBody;
  late Body whirlpoolBaseBody;
  List<Body> balls = [];
  Joint? whirlpoolJoint;
  RevoluteJointDef revoluteJointDef = RevoluteJointDef();

  // Velocity force variables
  double _endVelocity = 0.0;
  double _velocityStepValue = 0.0;
  bool _velocityStopAtEnd = false;
  double _lastElapsed = 1 / 60;

  void initialize(double? radiusValue) {
    _radius = radiusValue;
    _createWhirlpool();
  }

  void initializeBalls() {
    if (balls.length > 0) {
      return;
    }

    dartAsync.Timer.periodic(Duration(milliseconds: 70), (timer) {
      int offsetX =
          _randomBetween(-origin.dx.toInt() + 30, origin.dx.toInt() - 30);
      _createBall(offsetX, _randomColor());
      if (balls.length >= ballsCount) {
        timer.cancel();
        return;
      }
    });
  }

  void step(double elapsed) {
    _lastElapsed = elapsed;
    world.stepDt(elapsed);
    _velocityStep();
  }

  void setAngularVelocity(
    double value, {
    double seconds = 0,
    bool stopAtEnd = false,
  }) {
    _endVelocity = value;
    _velocityStopAtEnd = stopAtEnd;
    if (seconds == 0) {
      whirlpoolCoreBody.angularVelocity =
          (whirlpoolCoreBody.angularVelocity + value);
    } else {
      _velocityStepValue = (value - whirlpoolCoreBody.angularVelocity) /
          (seconds / _lastElapsed);
    }
  }

  void _velocityStep() {
    double newVelocity = 0;
    bool endReached = false;
    if (_velocityStepValue > 0 &&
        whirlpoolCoreBody.angularVelocity >= _endVelocity) {
      newVelocity = _endVelocity;
      endReached = true;
    } else if (_velocityStepValue < 0 &&
        whirlpoolCoreBody.angularVelocity <= _endVelocity) {
      newVelocity = _endVelocity;
      endReached = true;
    } else {
      newVelocity = whirlpoolCoreBody.angularVelocity + _velocityStepValue;
    }

    if (endReached == true && _velocityStopAtEnd == true) {
      newVelocity = 0.0;
      _velocityStepValue = 0.0;
      _endVelocity = 0.0;
    }
    whirlpoolCoreBody.angularVelocity = newVelocity;
  }

  Color _randomColor() {
    List<Color> colors = [
      BALL_COLOR_BLUE,
      BALL_COLOR_AQUA,
      BALL_COLOR_ORANGE,
      BALL_COLOR_PINK
    ];
    int random = _randomBetween(0, colors.length);

    return colors[random];
  }

  void _createWhirlpool() {
    _createWhirlpoolBase();
    _createWhirlpoolCore();
    _jointWhirlpool();
  }

  void _createWhirlpoolBase() {
    final polygonShape = PolygonShape();
    polygonShape.setAsBoxXY(2 / PPM, 2 / PPM);

    final bodyDef = BodyDef()
      ..type = BodyType.static
      ..position = Vector2(origin.dx / PPM, origin.dy / PPM);

    whirlpoolBaseBody = world.createBody(bodyDef);

    final fixtureDef = FixtureDef(polygonShape)..isSensor = true;
    whirlpoolBaseBody.createFixture(fixtureDef);
  }

  void _createWhirlpoolCore() {
    final chainShape = ChainShape();
    final bodyDef = BodyDef()
      ..type = BodyType.kinematic
      ..fixedRotation = true
      ..position = Vector2(origin.dx / PPM, origin.dy / PPM);

    List<Vector2> vertices = [];
    for (int i = 0; i < WHIRLPOOL_CIRCLE_SEGMENTS; i++) {
      double angle = ((pi * 2) / WHIRLPOOL_CIRCLE_SEGMENTS) * i;
      vertices.add(Vector2(
        radius! * cos(angle) / PPM,
        radius! * sin(angle) / PPM,
      ));
    }

    chainShape.createLoop(vertices);
    whirlpoolCoreBody = world.createBody(bodyDef);

    final fixtureDef = FixtureDef(chainShape)..density = 10;
    whirlpoolCoreBody.createFixture(fixtureDef);
  }

  void _jointWhirlpool() {
    revoluteJointDef.initialize(
        whirlpoolBaseBody, whirlpoolCoreBody, whirlpoolBaseBody.worldCenter);
    revoluteJointDef.collideConnected = false;

    revoluteJointDef.enableMotor = false;
    whirlpoolJoint = world.createJoint(revoluteJointDef);
  }

  void _createBall(int offsetX, Color color) {
    final bouncingRectangle = CircleShape()..radius = BALL_RADIUS / PPM;

    final activeFixtureDef = FixtureDef(bouncingRectangle)
      ..density = 4
      ..friction = 1
      ..restitution = .2;

    final activeBodyDef = BodyDef();
    activeBodyDef.position = Vector2(
      ((origin.dx + offsetX) / PPM),
      (origin.dy - (radius! / 2) - 10) / PPM,
    );
    activeBodyDef.type = BodyType.dynamic;
    activeBodyDef.bullet = true;
    Body boxBody = world.createBody(activeBodyDef);
    boxBody.createFixture(activeFixtureDef);
    boxBody.userData = color;

    balls.add(boxBody);
  }

  int _randomBetween(int min, int max) => min + _random.nextInt(max - min);
}
