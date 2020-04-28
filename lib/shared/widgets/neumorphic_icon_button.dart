import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/shared/widgets.dart';

class NeumorphicIconButton extends StatelessWidget {
  const NeumorphicIconButton({
    @required this.icon,
    this.onTap,
    this.margin,
    this.color,
    Key key,
  }) : super(key: key);

  final Icon icon;
  final EdgeInsetsGeometry margin;
  final GestureTapCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      child: icon,
      onTap: onTap,
      margin: margin,
      color: color,
    );
  }
}
