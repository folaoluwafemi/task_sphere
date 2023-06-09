import 'package:flutter/widgets.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class LinkedSpadePainter extends CustomPainter {
  final double headSize;
  final double stemLength;
  final Color firstHalfColor;
  final Color secondHalfColor;

  const LinkedSpadePainter({
    required this.headSize,
    required this.stemLength,
    required this.firstHalfColor,
    required this.secondHalfColor,
  });

  double get firstStemLength => stemLength / 2;

  double get secondStemLength => stemLength;

  @override
  void paint(Canvas canvas, Size size) {
    paintFirstDiamondHead(canvas, size);
    paintFirstStem(canvas, size);
    painSecondStem(canvas, size);
    paintSecondDiamondHead(canvas, size);
  }

  void paintFirstStem(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = firstHalfColor
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    canvas.drawLine(
      Offset(headSize.half, headSize.half),
      Offset(headSize + firstStemLength, headSize.half),
      paint,
    );
  }

  void painSecondStem(
    Canvas canvas,
    Size size,
  ) {
    final Paint paint = Paint()
      ..color = secondHalfColor
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final double leftOffset = headSize + firstStemLength;

    canvas.drawLine(
      Offset(leftOffset, headSize.half),
      Offset((headSize * 1.5) + secondStemLength, headSize.half),
      paint,
    );
  }

  void paintFirstDiamondHead(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = firstHalfColor
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, headSize.half)
      ..lineTo(headSize.half, 0)
      ..lineTo(headSize, headSize.half)
      ..lineTo(headSize / 2, headSize)
      ..close();

    canvas.drawPath(path, paint);
  }

  void paintSecondDiamondHead(
    Canvas canvas,
    Size size,
  ) {
    final Paint paint = Paint()
      ..color = secondHalfColor
      ..style = PaintingStyle.fill;

    final double leftOffset = headSize + stemLength;

    final Path path = Path()
      ..moveTo(leftOffset, headSize.half)
      ..lineTo(leftOffset + headSize.half, 0)
      ..lineTo(leftOffset + headSize, headSize.half)
      ..lineTo(leftOffset + headSize / 2, headSize)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
