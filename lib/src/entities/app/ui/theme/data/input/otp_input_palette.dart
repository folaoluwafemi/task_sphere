part of 'input_palette.dart';

typedef OtpInputPalette = ({
  OtpInputColors focused,
  OtpInputColors unfocused,
});

class OtpInputColors {
  final Color borderColor;
  final Color fillColor;

  const OtpInputColors({
    required this.borderColor,
    required this.fillColor,
  });

  OtpInputColors copyWith({
    Color? borderColor,
    Color? fillColor,
  }) {
    return OtpInputColors(
      borderColor: borderColor ?? this.borderColor,
      fillColor: fillColor ?? this.fillColor,
    );
  }

  OtpInputColors lerp(OtpInputColors b, double t) {
    return OtpInputColors(
      borderColor: Color.lerp(borderColor, b.borderColor, t)!,
      fillColor: Color.lerp(fillColor, b.fillColor, t)!,
    );
  }

  static OtpInputPalette lerpPalette(
    OtpInputPalette a,
    OtpInputPalette b,
    double t,
  ) {
    return (
      focused: a.focused.lerp(b.focused, t),
      unfocused: a.unfocused.lerp(b.unfocused, t),
    );
  }
}
