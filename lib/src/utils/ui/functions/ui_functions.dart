import 'package:flutter/widgets.dart';

abstract final class Ui {
  static BorderRadius circularBorder(double radius) => BorderRadius.all(
        Radius.circular(radius),
      );

  static BorderRadius circularBorderTop(double radius) => BorderRadius.vertical(
        top: Radius.circular(radius),
      );

  static BorderRadius circularBorderBottom(double radius) =>
      BorderRadius.vertical(
        bottom: Radius.circular(radius),
      );

  static BorderRadius circularBorderLeft(double radius) =>
      BorderRadius.horizontal(
        left: Radius.circular(radius),
      );

  static BorderRadius circularBorderRight(double radius) =>
      BorderRadius.horizontal(
        right: Radius.circular(radius),
      );
}
