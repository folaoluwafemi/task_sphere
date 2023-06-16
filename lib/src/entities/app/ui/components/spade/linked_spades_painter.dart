import 'package:flutter/widgets.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class LinkedSpadePainter extends CustomPainter {
  final double head1Size;
  final double head2Size;
  final double stemLength;
  final Color firstHalfColor;
  final Color secondHalfColor;

  const LinkedSpadePainter({
    required this.head1Size,
    required this.head2Size,
    required this.stemLength,
    required this.firstHalfColor,
    required this.secondHalfColor,
  });

  double get firstStemLength => stemLength / 2;

  double get secondStemLength => stemLength;

  double get thickness => 2.l;

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
      ..strokeWidth = thickness
      ..style = PaintingStyle.fill;

    canvas.drawLine(
      Offset(head1Size.half, size.height.half - thickness.half),
      Offset(head1Size + firstStemLength, size.height.half - 1.l),
      paint,
    );
  }

  void painSecondStem(
    Canvas canvas,
    Size size,
  ) {
    final Paint paint = Paint()
      ..color = secondHalfColor
      ..strokeWidth = thickness
      ..style = PaintingStyle.fill;

    final double leftOffset = head1Size + firstStemLength;

    canvas.drawLine(
      Offset(leftOffset, size.height.half - thickness.half),
      Offset(
        (head2Size * 1.5) + secondStemLength,
        size.height.half - thickness.half,
      ),
      paint,
    );
  }

  void paintFirstDiamondHead(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = firstHalfColor
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, size.height.half - thickness.half)
      ..lineTo(
        head1Size.half,
        size.height.half - (head1Size.half + thickness.half),
      )
      ..lineTo(head1Size, size.height.half - thickness.half)
      ..lineTo(
        head1Size.half,
        size.height.half + (head1Size.half - thickness.half),
      )
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

    final double leftOffset = head2Size + secondStemLength;

    final Path path = Path();
    path
      ..moveTo(leftOffset, size.height.half - thickness.half)
      ..lineTo(
        leftOffset + head2Size.half,
        size.height.half - (head2Size.half + thickness.half),
      )
      ..lineTo(leftOffset + head2Size, size.height.half - thickness.half)
      ..lineTo(
        leftOffset + head2Size.half,
        size.height.half + (head2Size.half - thickness.half),
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
