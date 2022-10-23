import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/shared/widgets.dart';

class NeumorphicButton extends StatefulWidget {
  const NeumorphicButton({
    Key? key,
    required this.child,
    this.width = 54.0,
    this.height = 54.0,
    this.pressed,
    this.onTap,
    this.margin,
    this.color,
    this.disabled,
  }) : super(key: key);

  final bool? pressed;
  final double width;
  final double height;
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final GestureTapCallback? onTap;
  final Color? color;
  final bool? disabled;

  @override
  NeumorphicButtonState createState() => NeumorphicButtonState();
}

class NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTap,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: NeumorphicContainer(
        pressed: widget.pressed ?? _isPressed,
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        color: widget.color,
        disabled: widget.disabled,
        child: widget.child,
      ),
    );
  }

  void _onTap(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });

    if (widget.onTap != null && widget.disabled != true) {
      widget.onTap!();
    }
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
  }
}
