import 'package:flutter/widgets.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class HalfSpadePainter extends CustomPainter {
  final double headSize;
  final double stemLength;
  final Color color;

  const HalfSpadePainter({
    required this.headSize,
    required this.stemLength,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    paintDiamondHead(canvas, size);
    paintStem(canvas, size);
  }

  void paintStem(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    canvas.drawLine(
      Offset(headSize.half, headSize.half),
      Offset(headSize + stemLength, headSize.half),
      paint,
    );
  }

  void paintDiamondHead(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, headSize.half)
      ..lineTo(headSize.half, 0)
      ..lineTo(headSize, headSize.half)
      ..lineTo(headSize / 2, headSize)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
