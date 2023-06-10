import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class AlertPainter extends CustomPainter {
  final Color color;

  const AlertPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    final Path path = Path();

    final double curveSpan = 36.w;
    final double curveRadius = 10.h;

    final Size borderRadius = Size(
      curveSpan.sixth,
      curveRadius.percent(34),
    );

    final Offset borderRadiusOffset = Offset(
      borderRadius.width,
      borderRadius.height,
    );

    final Offset curveStart = Offset(
      size.width.half - curveSpan.half,
      0,
    );
    final Offset curveEnd = Offset(
      size.width.half + curveSpan.half,
      0,
    );

    final Offset firstBorderRadiusStartOffset = Offset(curveStart.dx, 0);
    final Offset firstBorderRadiusEndOffset = Offset(
      curveStart.dx + borderRadius.width + 0,
      borderRadius.height,
    );

    final Offset secondBorderRadiusEndOffset = Offset(curveEnd.dx, 0);

    final double circleRadius = curveRadius.percent(60);

    final Offset circleStart = Offset(
      curveStart.dx + borderRadius.width,
      curveRadius + borderRadius.height,
    );

    final Offset circleEnd = Offset(
      curveEnd.dx - borderRadius.width,
      curveEnd.dy + borderRadius.height,
    );

    final Offset circleControlPoint = Offset(
      (circleStart + circleEnd).dx.half,
      circleStart.dy + (circleRadius.half * (3 / 11)),
    );

    path
      ..moveTo(0, 0)
      ..lineTo(curveStart.dx, 0)
      ..quadraticBezierTo(
        firstBorderRadiusStartOffset.dx + (borderRadiusOffset.distance.half),
        firstBorderRadiusStartOffset.dy,
        firstBorderRadiusEndOffset.dx,
        firstBorderRadiusEndOffset.dy,
      )
      ..quadraticBezierTo(
        circleControlPoint.dx,
        circleControlPoint.dy,
        circleEnd.dx,
        circleEnd.dy,
      )
      ..quadraticBezierTo(
        secondBorderRadiusEndOffset.dx - borderRadiusOffset.distance.half,
        0,
        secondBorderRadiusEndOffset.dx,
        secondBorderRadiusEndOffset.dy,
      )
      ..lineTo(curveEnd.dx, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
