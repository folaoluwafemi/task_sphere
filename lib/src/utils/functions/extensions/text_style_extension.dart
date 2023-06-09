part of 'extensions.dart';

extension TextStyleExtension on TextStyle {
  TextStyle withColor(Color? color) => copyWith(color: color);

  TextStyle withSize(double size) => copyWith(fontSize: size);

  TextStyle withWeight(FontWeight weight) => copyWith(fontWeight: weight);

  TextStyle withHeight(double height) => copyWith(height: height);

  TextStyle withDecoration(TextDecoration decoration) => copyWith(
        decoration: decoration,
      );

  TextStyle get asMedium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get asBold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get asRegular => copyWith(fontWeight: FontWeight.w400);
}
