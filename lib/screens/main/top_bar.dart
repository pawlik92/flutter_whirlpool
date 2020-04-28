import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/screens/main/timer_panel.dart';
import 'package:flutter_whirlpool/shared/colors.dart';
import 'package:flutter_whirlpool/shared/consts.dart';
import 'package:flutter_whirlpool/shared/widgets.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          GLOBAL_EDGE_MARGIN_VALUE, DRAWER_BUTTON_MARGIN_TOP, 18, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          NeumorphicIconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: CustomColors.textColor,
            ),
            onTap: () => Scaffold.of(context).openDrawer(),
          ),
          TimerPanel()
        ],
      ),
    );
  }
}
