import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_whirlpool/shared/colors.dart';
import 'package:flutter_whirlpool/shared/decorators.dart';
import 'package:flutter_whirlpool/view_models/timer_view_model.dart';
import 'package:provider/provider.dart';

class TimerPanel extends StatefulWidget {
  TimerPanel({Key key}) : super(key: key);

  @override
  _TimerPanelState createState() => _TimerPanelState();
}

class _TimerPanelState extends State<TimerPanel> {
  @override
  Widget build(BuildContext context) {
    var radius = BorderRadius.circular(10);

    return Container(
      width: 115,
      height: 52,
      padding: const EdgeInsets.all(8.0),
      decoration: InnerShadowDecoration(
        colors: [
          Color.lerp(CustomColors.pressedContainer, Colors.black, .12),
          Colors.white
        ],
        borderRadius: radius,
      ),
      foregroundDecoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        borderRadius: radius,
      ),
      child: Center(
        child: Consumer<TimerViewModel>(
          builder: (context, viewModel, _) {
            return Text(
              viewModel.remainigString,
              style: TextStyle(
                color: CustomColors.textColor,
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
