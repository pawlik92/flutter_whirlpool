import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/shared/colors.dart';
import 'package:flutter_whirlpool/shared/consts.dart';
import 'package:flutter_whirlpool/shared/widgets.dart';

class ModeTile extends StatelessWidget {
  const ModeTile({
    Key key,
    this.margin,
    this.pressed,
    @required this.name,
    @required this.indicatorColor,
    @required this.minutes,
  }) : super(key: key);

  final EdgeInsetsGeometry margin;
  final String name;
  final int minutes;
  final bool pressed;
  final Color indicatorColor;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      width: 120,
      margin: const EdgeInsets.only(
        left: GLOBAL_EDGE_MARGIN_VALUE,
        top: 10,
        bottom: 10,
      ),
      pressed: pressed,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          left: 8,
          right: 8,
          bottom: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _Indicator(
              color: indicatorColor,
            ),
            Expanded(child: Container()),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                color: CustomColors.headerColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              '$minutes minutes',
              style: TextStyle(
                fontSize: 13,
                color: CustomColors.headerColor.withAlpha(120),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    Key key,
    @required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      padding: EdgeInsets.all(4.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: color.withAlpha(70),
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
      ),
    );
  }
}
