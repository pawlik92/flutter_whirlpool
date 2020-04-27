import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/shared/colors.dart';
import 'package:flutter_whirlpool/shared/decorators.dart';

const NEUMORPHIC_RADIUS = 14.0;

class NeumorphicContainer extends StatelessWidget {
  const NeumorphicContainer({
    Key key,
    @required this.child,
    this.pressed,
    this.width,
    this.height,
    this.margin,
  }) : super(key: key);

  final bool pressed;
  final double width;
  final double height;
  final Widget child;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      margin: margin,
      duration: const Duration(milliseconds: 80),
      padding: const EdgeInsets.all(8.0),
      foregroundDecoration: InnerShadowDecoration(
        colors: pressed == true
            ? [
                Color.lerp(CustomColors.pressedContainer, Colors.black, .12),
                Colors.white
              ]
            : [
                CustomColors.containerPrimary,
                CustomColors.containerPrimary,
              ],
        borderRadius: BorderRadius.circular(NEUMORPHIC_RADIUS),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(NEUMORPHIC_RADIUS),
        color: pressed == true
            ? CustomColors.pressedContainer
            : CustomColors.containerPrimary,
        boxShadow: pressed == true
            ? null
            : [
                BoxShadow(
                  blurRadius: 7,
                  offset: -Offset(6, 6),
                  color: Colors.white,
                ),
                BoxShadow(
                    blurRadius: 7,
                    offset: Offset(6, 6),
                    color: Colors.black.withAlpha(18)),
              ],
      ),
      child: child,
    );
  }
}
