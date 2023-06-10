import 'package:flutter/cupertino.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class AlertGutterClipper extends CustomClipper<Path> {
  final double verticalHeight;
  final double depth;
  final double radius;

  const AlertGutterClipper({
    required this.verticalHeight,
    required this.depth,
    required this.radius,
  });

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..addPath(
        getVerticalClip1(
          path,
          size,
        ),
        Offset.zero,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..addPath(
        getVerticalClip2(path, size),
        Offset.zero,
      )
      ..close();

    return path;
  }

  Path getVerticalClip2(Path path, Size size) {
    final double gutterXMid = depth.half;

    final Offset gutterStartOffset = Offset(
      depth,
      size.height.half + verticalHeight.half,
    );
    final Offset gutterEndOffset = Offset(
      0,
      size.height.half - verticalHeight.half,
    );

    final Offset curveCenterStart = Offset(
      gutterStartOffset.dx - gutterXMid,
      gutterStartOffset.dy,
    );
    final Offset curveCenterEnd = Offset(
      gutterEndOffset.dx + gutterXMid,
      gutterEndOffset.dy,
    );

    final Offset positiveCurveStart = Offset(
      curveCenterStart.dx - gutterXMid,
      curveCenterStart.dy + radius,
    );

    final Offset positiveCurveEnd = Offset(
      curveCenterEnd.dx - gutterXMid,
      curveCenterEnd.dy - radius,
    );

    final Offset negativeCurveStart = Offset(
      curveCenterStart.dx + gutterXMid,
      curveCenterStart.dy - radius,
    );

    final Offset negativeCurveEnd = Offset(
      curveCenterEnd.dx + gutterXMid,
      curveCenterEnd.dy + radius,
    );

    final Offset startFirstCubicControlPoint = Offset(
      positiveCurveStart.dx,
      positiveCurveStart.dy - radius.percent(150),
    );

    final Offset startSecondCubicControlPoint = Offset(
      negativeCurveStart.dx,
      negativeCurveStart.dy + radius.percent(150),
    );

    final Offset endFirstCubicControlPoint = Offset(
      negativeCurveEnd.dx,
      negativeCurveEnd.dy - radius.percent(150),
    );

    final Offset endSecondCubicControlPoint = Offset(
      positiveCurveEnd.dx,
      positiveCurveEnd.dy + radius.percent(150),
    );

    path
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
      );

    return path;
  }

  Path getVerticalClip1(Path path, Size size) {
    final double gutterXMid = depth.half;

    final Offset gutterStartOffset = Offset(
      size.width - depth,
      size.height.half - verticalHeight.half,
    );
    final Offset gutterEndOffset = Offset(
      size.width,
      size.height.half + verticalHeight.half,
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
      curveCenterStart.dy - radius,
    );

    final Offset positiveCurveEnd = Offset(
      curveCenterEnd.dx + gutterXMid,
      curveCenterEnd.dy + radius,
    );

    final Offset negativeCurveStart = Offset(
      curveCenterStart.dx - gutterXMid,
      curveCenterStart.dy + radius,
    );

    final Offset negativeCurveEnd = Offset(
      curveCenterEnd.dx - gutterXMid,
      curveCenterEnd.dy - radius,
    );

    final Offset startFirstCubicControlPoint = Offset(
      positiveCurveStart.dx,
      positiveCurveStart.dy + radius.percent(150),
    );

    final Offset startSecondCubicControlPoint = Offset(
      negativeCurveStart.dx,
      negativeCurveStart.dy - radius.percent(150),
    );

    final Offset endFirstCubicControlPoint = Offset(
      negativeCurveEnd.dx,
      negativeCurveEnd.dy + radius.percent(150),
    );

    final Offset endSecondCubicControlPoint = Offset(
      positiveCurveEnd.dx,
      positiveCurveEnd.dy - radius.percent(150),
    );

    path
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
      );

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
