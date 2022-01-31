import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/shared/colors.dart';
import 'package:flutter_whirlpool/shared/widgets.dart';
import 'package:flutter_whirlpool/view_models/timer_view_model.dart';
import 'package:provider/provider.dart';

class TimerPanel extends StatefulWidget {
  TimerPanel({Key? key}) : super(key: key);

  @override
  _TimerPanelState createState() => _TimerPanelState();
}

class _TimerPanelState extends State<TimerPanel> {
  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      width: 115,
      height: 52,
      pressed: true,
      border: Border.all(color: CustomColors.timerPanelBorder, width: 2),
      child: Center(
        child: Consumer<TimerViewModel>(
          builder: (context, viewModel, _) {
            return Text(
              viewModel.remainigString,
              style: TextStyle(
                color: CustomColors.secondaryTextColor,
                letterSpacing: 3,
                fontSize: 22,
              ),
            );
          },
        ),
      ),
    );
  }
}
