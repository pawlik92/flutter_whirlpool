import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/shared/widgets.dart';

class NeumorphicIconButton extends StatelessWidget {
  const NeumorphicIconButton({
    Key key,
    this.onTap,
    this.margin,
    @required this.icon,
  }) : super(key: key);

  final Icon icon;
  final EdgeInsetsGeometry margin;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      child: icon,
      onTap: onTap,
      margin: margin,
    );
  }
}
