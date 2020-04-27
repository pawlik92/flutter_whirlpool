import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/shared/widgets.dart';

class NeumorphicButton extends StatefulWidget {
  NeumorphicButton({
    this.width = 54,
    this.height = 54,
    this.pressed,
    this.onTap,
    this.margin,
    @required this.child,
    Key key,
  }) : super(key: key);

  final bool pressed;
  final double width;
  final double height;
  final Widget child;
  final EdgeInsetsGeometry margin;
  final GestureTapCallback onTap;

  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTap,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: NeumorphicContainer(
        pressed: widget?.pressed ?? _isPressed,
        width: widget.width,
        height: widget.height,
        child: widget.child,
        margin: widget.margin,
      ),
    );
  }

  void _onTap(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });

    if (widget.onTap != null) {
      widget.onTap();
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
