import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/shared/widgets.dart';

class NeumorphicIconButton extends StatelessWidget {
  const NeumorphicIconButton({
    Key? key,
    required this.icon,
    this.onTap,
    this.margin,
    this.color,
    this.pressed,
    this.disabled,
  }) : super(key: key);

  final Icon icon;
  final EdgeInsetsGeometry? margin;
  final GestureTapCallback? onTap;
  final Color? color;
  final bool? pressed;
  final bool? disabled;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      child: icon,
      onTap: onTap,
      margin: margin,
      color: color,
      pressed: pressed,
      disabled: disabled,
    );
  }
}
