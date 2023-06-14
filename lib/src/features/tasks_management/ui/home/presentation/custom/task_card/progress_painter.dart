part of 'task_card.dart';

class TaskProgressPainter extends CustomPainter {
  final double percentage;
  final Color thinLineColor;
  final Color progressColor;
  final BuildContext context;

  const TaskProgressPainter({
    required this.context,
    required this.percentage,
    required this.thinLineColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = thinLineColor
      ..strokeWidth = 0.5.l
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(
      size.width.half,
      size.height.half,
    );
    final double radius = min(
      size.width.half,
      size.height.half,
    );

    canvas.drawCircle(center, radius + 2.l, paint);

    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = 4.l
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.stroke;

    final double progressAngle = -360.toRadians * (percentage / 100);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      360.toRadians,
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is! TaskProgressPainter) return false;
    return oldDelegate.percentage != percentage;
  }
}
