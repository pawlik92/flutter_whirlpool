import 'package:flutter/material.dart';
import 'package:flutter_whirlpool/screens/main/washing_machine/drum/washing_machine_drum.dart';
import 'package:flutter_whirlpool/screens/main/washing_machine/washing_machine_controller.dart';
import 'package:flutter_whirlpool/shared/colors.dart';

class WashingMachineCase extends StatefulWidget {
  const WashingMachineCase({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  _WashingMachineCaseState createState() => _WashingMachineCaseState();
}

class _WashingMachineCaseState extends State<WashingMachineCase> {
  final WashingMachineController _controller = WashingMachineController();

  @override
  Widget build(BuildContext context) {
    const circularBorder = const BorderRadius.all(Radius.circular(200));
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.31, 0.07),
          end: Alignment(0.35, 1),
          colors: [
            Color.fromRGBO(248, 250, 251, 1),
            Color.fromRGBO(243, 246, 248, 1),
            Color.fromRGBO(221, 228, 236, 1),
          ],
          stops: [0, 0.4, 1],
        ),
        border: Border.all(color: Color.fromRGBO(223, 229, 232, 1), width: 2.5),
        borderRadius: circularBorder,
        boxShadow: [
          BoxShadow(
            blurRadius: 9,
            offset: Offset(6, 6),
            color: Colors.black.withAlpha(10),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: widget.width - 30,
          height: widget.height - 30,
          decoration: BoxDecoration(
            color: CustomColors.primaryColor,
            borderRadius: circularBorder,
          ),
          child: Center(
            child: Container(
              width: widget.width - 30 - 70,
              height: widget.height - 30 - 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.36, 0.07),
                  end: Alignment(0.5, 0.6),
                  colors: [
                    Color.fromRGBO(205, 216, 227, 1),
                    Color.fromRGBO(207, 218, 228, 1),
                    Color.fromRGBO(243, 245, 247, 1),
                  ],
                  stops: [0, 0.26, 1],
                ),
                borderRadius: circularBorder,
              ),
              child: Center(
                child: Container(
                  width: widget.width - 30 - 70 - 28,
                  height: widget.height - 30 - 70 - 28,
                  child: ClipOval(
                    child: WashingMachineDrum(_controller),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
