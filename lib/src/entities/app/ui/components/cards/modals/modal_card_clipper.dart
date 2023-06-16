import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/utils/functions/extensions/extensions.dart';

class ModalCardClipper extends CustomClipper<Path> {
  final double gutterRadius;
  final double gutterHeight;
  final double gutterThickness;

  ModalCardClipper({
    required this.gutterRadius,
    double? gutterHeight,
    double? gutterThickness,
  })  : gutterHeight = gutterHeight ?? 44.h,
        gutterThickness = gutterThickness ?? 4.w;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double gutterXMid = gutterThickness.half;

    final Offset gutterStartOffset = Offset(
      size.width - gutterThickness,
      size.height.half - gutterHeight.half,
    );
    final Offset gutterEndOffset = Offset(
      size.width,
      size.height.half + gutterHeight.half,
    );

    final Offset curveCenterStart = Offset(
      gutterEndOffset.dx - gutterXMid,
      gutterStartOffset.dy,
    );
    final Offset curveCenterEnd = Offset(
      gutterEndOffset.dx - gutterXMid,
      gutterEndOffset.dy,
    );

    final Offset positiveCurveStart = Offset(
      curveCenterStart.dx + gutterXMid,
      curveCenterStart.dy - gutterRadius,
    );

    final Offset positiveCurveEnd = Offset(
      curveCenterEnd.dx + gutterXMid,
      curveCenterEnd.dy + gutterRadius,
    );

    final Offset negativeCurveStart = Offset(
      curveCenterStart.dx - gutterXMid,
      curveCenterStart.dy + gutterRadius,
    );

    final Offset negativeCurveEnd = Offset(
      curveCenterEnd.dx - gutterXMid,
      curveCenterEnd.dy - gutterRadius,
    );

    final Offset startFirstCubicControlPoint = Offset(
      positiveCurveStart.dx,
      positiveCurveStart.dy + gutterRadius,
    );

    final Offset startSecondCubicControlPoint = Offset(
      negativeCurveStart.dx,
      negativeCurveStart.dy - gutterRadius,
    );

    final Offset endFirstCubicControlPoint = Offset(
      negativeCurveEnd.dx,
      negativeCurveEnd.dy + gutterRadius,
    );

    final Offset endSecondCubicControlPoint = Offset(
      positiveCurveEnd.dx,
      positiveCurveEnd.dy - gutterRadius,
    );

    path
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(positiveCurveStart.dx, positiveCurveStart.dy)
      ..cubicTo(
        startFirstCubicControlPoint.dx,
        startFirstCubicControlPoint.dy,
        startSecondCubicControlPoint.dx,
        startSecondCubicControlPoint.dy,
        negativeCurveStart.dx,
        negativeCurveStart.dy,
      )
      ..lineTo(gutterStartOffset.dx, gutterStartOffset.dy)
      ..lineTo(negativeCurveEnd.dx, negativeCurveEnd.dy)
      ..cubicTo(
        endFirstCubicControlPoint.dx,
        endFirstCubicControlPoint.dy,
        endSecondCubicControlPoint.dx,
        endSecondCubicControlPoint.dy,
        positiveCurveEnd.dx,
        positiveCurveEnd.dy,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
