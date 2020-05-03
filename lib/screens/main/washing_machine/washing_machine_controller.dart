import 'dart:async';

typedef PaintCallback();

class WashingMachineController {
  WashingMachineController() {
    Timer.periodic(Duration(milliseconds: 40), (timer) {
      drumAngle += 4;
      if (drumAngle >= 360) {
        drumAngle = 0;
      }

      if (onNeedPaint != null) {
        onNeedPaint();
      }
    });
  }

  double drumAngle = 0.0;
  PaintCallback onNeedPaint;

  void dispose() {}
}
