import 'package:flutter/cupertino.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class LargeButtonGutterClipper extends CustomClipper<Path> {
  final double horizontalLength;
  final double verticalHeight;
  final double depth;
  final double radius;

  const LargeButtonGutterClipper({
    required this.horizontalLength,
    required this.verticalHeight,
    required this.depth,
    required this.radius,
  });

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path
      ..moveTo(0, 0)
      ..addPath(
        getHorizontalClip1(size),
        Offset.zero,
      )
      ..lineTo(size.width, 0)
      ..addPath(
        getVerticalClip1(
          path,
          size,
        ),
        Offset.zero,
      )
      ..lineTo(size.width, size.height)
      ..addPath(
        getHorizontalClip2(path, size),
        Offset.zero,
      )
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

  Path getHorizontalClip1(Size size) {
    final Path path = Path();
    final double gutterYMid = depth.half;

    final Offset gutterStartOffset = Offset(
      size.width.half - horizontalLength.half,
      0,
    );
    final Offset gutterEndOffset = Offset(
      size.width.half + horizontalLength.half,
      depth,
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
      curveCenterStart.dx - radius,
      curveCenterStart.dy - gutterYMid,
    );

    final Offset positiveCurveEnd = Offset(
      curveCenterEnd.dx + radius,
      curveCenterEnd.dy - gutterYMid,
    );

    final Offset negativeCurveStart = Offset(
      curveCenterStart.dx + radius,
      curveCenterStart.dy + gutterYMid,
    );

    final Offset negativeCurveEnd = Offset(
      curveCenterEnd.dx - radius,
      curveCenterEnd.dy + gutterYMid,
    );

    final Offset startFirstCubicControlPoint = Offset(
      positiveCurveStart.dx + radius.percent(150),
      positiveCurveStart.dy,
    );

    final Offset startSecondCubicControlPoint = Offset(
      negativeCurveStart.dx - radius.percent(150),
      negativeCurveStart.dy,
    );

    final Offset endFirstCubicControlPoint = Offset(
      negativeCurveEnd.dx + radius.percent(150),
      negativeCurveEnd.dy,
    );

    final Offset endSecondCubicControlPoint = Offset(
      positiveCurveEnd.dx - radius.percent(150),
      positiveCurveEnd.dy,
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

  Path getHorizontalClip2(Path path, Size size) {
    final double gutterYMid = depth.half;

    final Offset gutterStartOffset = Offset(
      size.width.half + horizontalLength.half,
      size.height,
    );
    final Offset gutterEndOffset = Offset(
      size.width.half - horizontalLength.half,
      size.height - depth,
    );

    final Offset curveCenterStart = Offset(
      gutterStartOffset.dx,
      gutterStartOffset.dy - gutterYMid,
    );
    final Offset curveCenterEnd = Offset(
      gutterEndOffset.dx,
      gutterEndOffset.dy + gutterYMid,
    );

    final Offset positiveCurveStart = Offset(
      curveCenterStart.dx + radius,
      curveCenterStart.dy + gutterYMid,
    );

    final Offset positiveCurveEnd = Offset(
      curveCenterEnd.dx - radius,
      curveCenterEnd.dy + gutterYMid,
    );

    final Offset negativeCurveStart = Offset(
      curveCenterStart.dx - radius,
      curveCenterStart.dy - gutterYMid,
    );

    final Offset negativeCurveEnd = Offset(
      curveCenterEnd.dx + radius,
      curveCenterEnd.dy - gutterYMid,
    );

    final Offset startFirstCubicControlPoint = Offset(
      positiveCurveStart.dx - radius.percent(150),
      positiveCurveStart.dy,
    );

    final Offset startSecondCubicControlPoint = Offset(
      negativeCurveStart.dx + radius.percent(150),
      negativeCurveStart.dy,
    );

    final Offset endFirstCubicControlPoint = Offset(
      negativeCurveEnd.dx - radius.percent(150),
      negativeCurveEnd.dy,
    );

    final Offset endSecondCubicControlPoint = Offset(
      positiveCurveEnd.dx + radius.percent(150),
      positiveCurveEnd.dy,
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
