part of 'stepper_divider.dart';

class StepperDividerPainter extends CustomPainter {
  final double spacing;
  final double stepWidth;
  final double thickness;
  final Color color;
  final Color spacingColor;

  const StepperDividerPainter({
    required this.spacing,
    required this.stepWidth,
    required this.thickness,
    required this.color,
    required this.spacingColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = thickness.doubled;
    final Paint spacingPaint = Paint()
      ..color = spacingColor
      ..strokeWidth = thickness.doubled;

    final int stepCount = (size.width / (stepWidth)).floor();
    final double stepSpacing = spacing;

    for (int i = 0; i < stepCount - 1; i++) {
      final double lineStart = (i * (stepWidth + stepSpacing));
      final double spacingStart = lineStart - stepSpacing;
      final double spacingEnd = lineStart;
      final double lineEnd = lineStart + stepWidth;

      canvas.drawLine(
        Offset(spacingStart, 0),
        Offset(spacingEnd, 0),
        spacingPaint,
      );

      canvas.drawLine(
        Offset(lineStart, 0),
        Offset(lineEnd, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(StepperDividerPainter oldDelegate) {
    return oldDelegate.spacing != spacing ||
        oldDelegate.stepWidth != stepWidth ||
        oldDelegate.thickness != thickness;
  }
}
