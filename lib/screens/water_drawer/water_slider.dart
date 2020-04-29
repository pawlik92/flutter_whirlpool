import 'package:flutter/material.dart';
import 'package:flutter_whirlpool/screens/water_drawer/wave_container.dart';
import 'package:flutter_whirlpool/shared/colors.dart';
import 'package:flutter_whirlpool/shared/decorators.dart';
import 'package:flutter_whirlpool/shared/widgets.dart';

typedef ValueChangeCallback = void Function(double value);

class WaterSlider extends StatefulWidget {
  WaterSlider({
    @required this.minValue,
    @required this.maxValue,
    this.initValue,
    this.onValueChanged,
    Key key,
  }) : super(key: key) {
    assert(minValue < maxValue);
    assert(minValue >= 0);
    assert(maxValue >= 0);
  }

  final double minValue;
  final double maxValue;
  final double initValue;
  final ValueChangeCallback onValueChanged;

  @override
  _WaterSliderState createState() => _WaterSliderState();
}

class _WaterSliderState extends State<WaterSlider> {
  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(50);

    InnerShadowDecoration foregroundDecoration = InnerShadowDecoration(
      colors: [
        Color.lerp(CustomColors.pressedContainer, Colors.black, .12),
        Colors.white
      ],
      borderRadius: borderRadius,
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Row(
          children: <Widget>[
            NeumorphicContainer(
              width: 90,
              borderRadius: borderRadius,
              disableForegroundDecoration: true,
              padding: EdgeInsets.zero,
              child: Container(
                decoration: foregroundDecoration,
                child: Stack(
                  children: [
                    _WaterSlide(
                      height: constraints.maxHeight,
                      min: widget.minValue,
                      max: widget.maxValue,
                      topOffset: 40,
                      bottomOffset: 58,
                      initValue: widget.initValue,
                      onValueChanged: widget?.onValueChanged,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: _SliderRange(
                min: widget.minValue,
                max: widget.maxValue,
                step: 50,
                topOffset: 50,
                bottomOffset: 50,
                markNStep: 4,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SliderRange extends StatelessWidget {
  const _SliderRange({
    @required this.min,
    @required this.max,
    @required this.step,
    this.topOffset = 0.0,
    this.bottomOffset = 0.0,
    this.markNStep,
    Key key,
  }) : super(key: key);

  final double min;
  final double max;
  final double step;
  final double topOffset;
  final double bottomOffset;
  final int markNStep;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: 120,
          child: Stack(children: _generateRangeList(constraints.maxHeight)),
        );
      },
    );
  }

  List<Widget> _generateRangeList(double height) {
    List<Widget> result = [];

    int numberOfLines = ((max - min) / step).floor() + 1;
    double bottomMargin =
        (height - topOffset - bottomOffset) / (numberOfLines - 1);

    for (int i = 0; i < numberOfLines; i++) {
      bool markStep = markNStep != null && i % markNStep == 0;
      double top = topOffset + i * bottomMargin;

      result.add(
        Positioned(
          left: 0,
          top: top,
          child: Container(
            width: markStep ? 80 : 25,
            height: 2,
            color: CustomColors.headerColor.withAlpha(30),
          ),
        ),
      );

      if (markStep) {
        result.add(
          Positioned(
            left: 80.0 + 8.0,
            top: top - 6,
            child: Text(
              (max - i * step).toStringAsFixed(0),
              style: TextStyle(
                color: CustomColors.headerColor.withAlpha(140),
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        );
      }
    }

    return result;
  }
}

class _WaterSlide extends StatefulWidget {
  _WaterSlide({
    @required this.height,
    @required this.min,
    @required this.max,
    this.topOffset = 0.0,
    this.bottomOffset = 0.0,
    this.onValueChanged,
    this.initValue,
    Key key,
  }) : super(key: key);

  final double height;
  final double min;
  final double max;
  final double topOffset;
  final double bottomOffset;
  final double initValue;
  final ValueChangeCallback onValueChanged;

  @override
  _WaterSlideState createState() => _WaterSlideState();
}

class _WaterSlideState extends State<_WaterSlide>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _growAnimation;

  double _yOffset = 0;

  @override
  void initState() {
    super.initState();

    double animationEndValue = widget.initValue == null
        ? _validateYOffset(_yOffset)
        : _validateYOffset(_calculateYOffset(widget.initValue));

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _growAnimation = Tween<double>(begin: widget.height, end: animationEndValue)
        .chain(CurveTween(curve: Curves.easeOutCirc))
        .animate(_animationController)
          ..addListener(() {
            setState(() {
              _yOffset = _growAnimation.value;
            });
          });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -_yOffset,
      left: 0,
      child: GestureDetector(
        onVerticalDragUpdate: _onDragUpdate,
        child: Stack(
          children: [
            WaveContainer(
              size: Size(90, widget.height),
              offset: Offset(45, 0),
              color: Color.fromRGBO(254, 193, 45, .3),
              sinWidthFraction: 2,
            ),
            WaveContainer(
              size: Size(90, widget.height),
              offset: Offset.zero,
            ),
          ],
        ),
      ),
    );
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _yOffset = _validateYOffset(_yOffset + details.delta.dy);
      _calculateValue();
    });
  }

  void _calculateValue() {
    double workingH = widget.height - widget.topOffset - widget.bottomOffset;
    double currentH = widget.height - widget.bottomOffset - _yOffset;

    double factor = workingH / (widget.max - widget.min);
    double value = (currentH + (widget.min * factor)) / factor;

    if (widget.onValueChanged != null) {
      widget.onValueChanged(value);
    }
  }

  double _calculateYOffset(double value) {
    double workingH = widget.height - widget.topOffset - widget.bottomOffset;
    double factor = workingH / (widget.max - widget.min);

    double result = -((value * factor) -
        widget.height +
        widget.bottomOffset -
        (widget.min * factor));

    return result;
  }

  double _validateYOffset(double newYOffset) {
    double result = newYOffset;
    if (result < widget.topOffset) {
      result = widget.topOffset;
    }

    if (result > widget.height - widget.bottomOffset) {
      result = widget.height - widget.bottomOffset;
    }

    return result;
  }
}
