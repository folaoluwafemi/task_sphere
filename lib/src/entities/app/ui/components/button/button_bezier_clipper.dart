import 'package:flutter/widgets.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class ButtonBezierClipper extends CustomClipper<Path> {
  final double horizontalLength;
  final double verticalHeight;

  const ButtonBezierClipper({
    required this.horizontalLength,
    required this.verticalHeight,
  });

  @override
  Path getClip(Size size) {
    final Path path = Path();
    path
      ..moveTo(
        3.bezierRelativeWidth(size.width),
        3.bezierRelativeHeight(size.height),
      )
      ..quadraticBezierTo(
        13.bezierRelativeWidth(size.width),
        0,
        size.width.half - horizontalLength.half,
        0,
      )
      ..lineTo(size.width.half + horizontalLength.half, 0)
      ..quadraticBezierTo(
        size.width - 13.bezierRelativeWidth(size.width),
        0,
        size.width - 3.bezierRelativeWidth(size.width),
        3.bezierRelativeHeight(size.height),
      )
      ..quadraticBezierTo(
        size.width,
        4.bezierRelativeHeight(size.height),
        size.width,
        size.height.half - verticalHeight.half,
      )
      ..lineTo(size.width, size.height.half - verticalHeight.half)
      ..quadraticBezierTo(
        size.width,
        size.height - 4.bezierRelativeHeight(size.height),
        size.width - 3.bezierRelativeWidth(size.width),
        size.height - 3.bezierRelativeHeight(size.height),
      )
      ..quadraticBezierTo(
        size.width - 13.bezierRelativeWidth(size.width),
        size.height,
        size.width.half + horizontalLength.half,
        size.height,
      )
      ..lineTo(size.width.half - horizontalLength.half, size.height)
      ..quadraticBezierTo(
        13.bezierRelativeWidth(size.width),
        size.height,
        3.bezierRelativeWidth(size.width),
        size.height - 3.bezierRelativeHeight(size.height),
      )
      ..quadraticBezierTo(
        0,
        size.height - 4.bezierRelativeHeight(size.height),
        0,
        size.height.half + verticalHeight.half,
      )
      ..lineTo(0, size.height.half - verticalHeight.half)
      ..quadraticBezierTo(
        0,
        4.bezierRelativeHeight(size.height),
        3.bezierRelativeWidth(size.width),
        3.bezierRelativeHeight(size.height),
      )
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
