import 'package:flutter/widgets.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class AlertTailPainter extends CustomPainter {
  final Color color;
  final double height;

  const AlertTailPainter({
    required this.color,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = color
      ..strokeWidth = 2;

    final Offset startCenter = Offset(
      size.width.half,
      0,
    );

    canvas.drawLine(
      startCenter,
      startCenter + Offset(0, height),
      linePaint,
    );

    paintTriangleHead(canvas, size);
  }

  void paintTriangleHead(Canvas canvas, Size size) {
    final double headSize = 12.l;
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double headStart = size.width.half - headSize.half;

    final Path path = Path()
      ..moveTo(headStart, 0)
      ..lineTo(headStart + headSize, 0)
      ..lineTo(headStart + headSize.half, headSize.half)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is! AlertTailPainter) return false;
    return oldDelegate.height != height;
  }
}
