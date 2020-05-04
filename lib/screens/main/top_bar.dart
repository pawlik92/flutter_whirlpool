import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/screens/main/timer_panel.dart';
import 'package:flutter_whirlpool/screens/main/washing_machine/washing_machine_controller.dart';
import 'package:flutter_whirlpool/shared/colors.dart';
import 'package:flutter_whirlpool/shared/consts.dart';
import 'package:flutter_whirlpool/shared/widgets.dart';
import 'package:flutter_whirlpool/view_models/service_locator.dart';

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
              Icons.code,
              color: CustomColors.textColor,
            ),
            onTap: () {
              var controller = ServiceLocator.get<WashingMachineController>();
              controller.devMode = !controller.devMode;
            },
          ),
          TimerPanel()
        ],
      ),
    );
  }
}
