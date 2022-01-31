import 'package:flutter/material.dart';
import 'package:flutter_whirlpool/screens/main/washing_machine/drum/washing_machine_drum.dart';
import 'package:flutter_whirlpool/screens/main/washing_machine/washing_machine_controller.dart';
import 'package:flutter_whirlpool/shared/colors.dart';
import 'package:flutter_whirlpool/view_models/service_locator.dart';

class WashingMachineCase extends StatefulWidget {
  const WashingMachineCase({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _WashingMachineCaseState createState() => _WashingMachineCaseState();
}

class _WashingMachineCaseState extends State<WashingMachineCase> {
  WashingMachineController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = ServiceLocator.get<WashingMachineController>();
    _controller!.initialize(radius: widget.width! / 2 - 64);
  }

  @override
  Widget build(BuildContext context) {
    const circularBorder = const BorderRadius.all(Radius.circular(200));
    const ring1Offset = 35;
    const ring2Offset = 70;
    const ring3Offset = 28;

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.3, 0.07),
          end: Alignment(0.35, 1),
          colors: CustomColors.drumRing1Colors,
          stops: [0, 0.4, 1],
        ),
        border: Border.all(color: CustomColors.drumBorder, width: 2),
        borderRadius: circularBorder,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(-8, -8),
            color: Colors.white.withAlpha(12),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: widget.width! - ring1Offset,
          height: widget.height! - ring1Offset,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.3, 0.07),
              end: Alignment(0.35, 1),
              colors: CustomColors.drumRing2Colors,
              stops: [0, 0.6, 1],
            ),
            borderRadius: circularBorder,
          ),
          child: Center(
            child: Container(
              width: widget.width! - ring1Offset - ring2Offset,
              height: widget.height! - ring1Offset - ring2Offset,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.36, 0.07),
                  end: Alignment(0.5, 0.6),
                  colors: CustomColors.drumRing3Colors,
                  stops: [0, 0.25, 1],
                ),
                borderRadius: circularBorder,
              ),
              child: Center(
                child: Container(
                  width:
                      widget.width! - ring1Offset - ring2Offset - ring3Offset,
                  height:
                      widget.height! - ring1Offset - ring2Offset - ring3Offset,
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
