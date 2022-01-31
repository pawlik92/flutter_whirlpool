import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/shared/colors.dart';
import 'package:flutter_whirlpool/shared/consts.dart';
import 'package:flutter_whirlpool/shared/decorators.dart';

class NeumorphicContainer extends StatelessWidget {
  const NeumorphicContainer({
    Key? key,
    this.child,
    this.pressed,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.color,
    this.borderRadius,
    this.border,
    this.decoration,
    this.foregroundDecoration,
    this.disableForegroundDecoration,
    this.disabled,
  }) : super(key: key);

  final bool? pressed;
  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final EdgeInsetsGeometry? padding;
  final bool? disableForegroundDecoration;
  final bool? disabled;

  @override
  Widget build(BuildContext context) {
    BorderRadius deafultRadius =
        BorderRadius.circular(NEUMORPHIC_DEFAULT_RADIUS);
    InnerShadowDecoration defaultForegroundDecoration = InnerShadowDecoration(
      colors: pressed == true
          ? [
              CustomColors.containerInnerShadowTop,
              CustomColors.containerInnerShadowBottom
            ]
          : [
              CustomColors.container,
              CustomColors.container,
            ],
      borderRadius: borderRadius ?? deafultRadius,
    );

    return Opacity(
      opacity: disabled == true ? .5 : 1,
      child: AnimatedContainer(
        width: width,
        height: height,
        margin: margin,
        duration: const Duration(milliseconds: 150),
        padding: padding ?? const EdgeInsets.all(8.0),
        foregroundDecoration: disableForegroundDecoration != true
            ? foregroundDecoration ?? defaultForegroundDecoration
            : null,
        decoration: decoration ??
            BoxDecoration(
              borderRadius: borderRadius ?? deafultRadius,
              border: border,
              color: pressed == true
                  ? CustomColors.containerPressed
                  : color ?? CustomColors.container,
              boxShadow: pressed == true
                  ? null
                  : [
                      BoxShadow(
                        blurRadius: 10,
                        offset: const Offset(-6, -6),
                        color: CustomColors.containerShadowTop,
                      ),
                      BoxShadow(
                        blurRadius: 10,
                        offset: const Offset(6, 6),
                        color: CustomColors.containerShadowBottom,
                      ),
                    ],
            ),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: borderRadius ?? deafultRadius,
          child: child,
        ),
      ),
    );
  }
}
