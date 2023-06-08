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
        top: Radius.circular(radius),
      );
}
