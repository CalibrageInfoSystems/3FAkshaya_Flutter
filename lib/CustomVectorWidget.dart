import 'package:flutter/material.dart';

class CustomVectorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(987.3, 870.3),
      painter: VectorPainter(),
    );
  }
}

class VectorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Create a Path object from your SVG path data
    final path = Path();
    path.moveTo(0, 870);
    path.lineTo(0, 0);
    path.lineTo(987, 0);
    path.lineTo(987, 870);
    path.close();

    // Create a Paint object with a linear gradient
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Color(0xFFe56d5d),
          Color(0xFFe49e64),
          Color(0xFFE39A63),
        ],
        stops: [0.0, 0.1974, 0.3786],
        begin: Alignment(0.0, 2.6645353E-14),
        end: Alignment(0.0, 1.0),
      ).createShader(Rect.fromPoints(Offset(493.5, 2.6645353E-14), Offset(493.5, 870)))
      ..style = PaintingStyle.fill;

    // Draw the path with the gradient
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
