part of 'input_palette.dart';

typedef SingleInputPalette = ({
  SingleInputColors empty,
  SingleInputColors focused,

  /// After the user has entered some text but removed focus
  SingleInputColors filled,
});

class SingleInputColors {
  final Color borderColor;
  final Color prefixIconColor;
  final Color fillColor;

  const SingleInputColors({
    required this.borderColor,
    required this.prefixIconColor,
    required this.fillColor,
  });

  SingleInputColors copyWith({
    Color? borderColor,
    Color? prefixIconColor,
    Color? fillColor,
  }) {
    return SingleInputColors(
      borderColor: borderColor ?? this.borderColor,
      prefixIconColor: prefixIconColor ?? this.prefixIconColor,
      fillColor: fillColor ?? this.fillColor,
    );
  }

  SingleInputColors lerp(SingleInputColors b, double t) {
    return SingleInputColors(
      borderColor: Color.lerp(borderColor, b.borderColor, t)!,
      prefixIconColor: Color.lerp(prefixIconColor, b.prefixIconColor, t)!,
      fillColor: Color.lerp(fillColor, b.fillColor, t)!,
    );
  }

  static SingleInputPalette lerpPalette(
    SingleInputPalette a,
    SingleInputPalette b,
    double t,
  ) {
    return (
      empty: a.empty.lerp(b.empty, t),
      focused: a.focused.lerp(b.focused, t),
      filled: a.filled.lerp(b.filled, t),
    );
  }
}
