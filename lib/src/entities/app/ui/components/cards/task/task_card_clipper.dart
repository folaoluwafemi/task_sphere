import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/utils/functions/extensions/extensions.dart';

class TaskCardClipper extends CustomClipper<Path> {
  final double gutterRadius;
  final double gutterWidth;
  final double gutterThickness;

  TaskCardClipper({
    required this.gutterRadius,
    double? gutterWidth,
    double? gutterThickness,
  })  : gutterWidth = gutterWidth ?? 44.w,
        gutterThickness = gutterThickness ?? 4.h;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double gutterYMid = gutterThickness.half;

    final Offset gutterStartOffset = Offset(
      size.width.half - gutterWidth.half,
      0,
    );
    final Offset gutterEndOffset = Offset(
      size.width.half + gutterWidth.half,
      gutterThickness,
    );

    final Offset curveCenterStart = Offset(
      gutterStartOffset.dx,
      gutterStartOffset.dy + gutterYMid,
    );
    final Offset curveCenterEnd = Offset(
      gutterEndOffset.dx,
      gutterEndOffset.dy - gutterYMid,
    );

    final Offset positiveCurveStart = Offset(
      curveCenterStart.dx - gutterRadius,
      curveCenterStart.dy - gutterYMid,
    );

    final Offset positiveCurveEnd = Offset(
      curveCenterEnd.dx + gutterRadius,
      curveCenterEnd.dy - gutterYMid,
    );

    final Offset negativeCurveStart = Offset(
      curveCenterStart.dx + gutterRadius,
      curveCenterStart.dy + gutterYMid,
    );

    final Offset negativeCurveEnd = Offset(
      curveCenterEnd.dx - gutterRadius,
      curveCenterEnd.dy + gutterYMid,
    );

    final Offset startFirstCubicControlPoint = Offset(
      positiveCurveStart.dx + gutterRadius,
      positiveCurveStart.dy,
    );

    final Offset startSecondCubicControlPoint = Offset(
      negativeCurveStart.dx - gutterRadius,
      negativeCurveStart.dy,
    );

    final Offset endFirstCubicControlPoint = Offset(
      negativeCurveEnd.dx + gutterRadius,
      negativeCurveEnd.dy,
    );

    final Offset endSecondCubicControlPoint = Offset(
      positiveCurveEnd.dx - gutterRadius,
      positiveCurveEnd.dy,
    );

    path
      ..moveTo(0, 0)
      ..lineTo(positiveCurveStart.dx, positiveCurveStart.dy)
      ..cubicTo(
        startFirstCubicControlPoint.dx,
        startFirstCubicControlPoint.dy,
        startSecondCubicControlPoint.dx,
        startSecondCubicControlPoint.dy,
        negativeCurveStart.dx,
        negativeCurveStart.dy,
      )
      ..lineTo(negativeCurveEnd.dx, negativeCurveEnd.dy)
      ..cubicTo(
        endFirstCubicControlPoint.dx,
        endFirstCubicControlPoint.dy,
        endSecondCubicControlPoint.dx,
        endSecondCubicControlPoint.dy,
        positiveCurveEnd.dx,
        positiveCurveEnd.dy,
      )
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(TaskCardClipper oldClipper) {
    return oldClipper.gutterRadius != gutterRadius ||
        oldClipper.gutterWidth != gutterWidth ||
        oldClipper.gutterThickness != gutterThickness;
  }
}
