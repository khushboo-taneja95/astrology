import 'package:flutter/material.dart';
import 'package:login/constant/colors.dart';

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = AstroColors.appColor.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(20, 50), 100, paint1);
    canvas.drawCircle(Offset(120, -10), 100, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}