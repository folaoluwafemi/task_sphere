part of 'color_extension.dart';

typedef AlertColors = ({
  Color background,
  Color info,
  Color error,
  Color success,
});

typedef NeutralColors = ({
  Color $100,
  Color $200,
  Color $300,
  Color $400,
  Color $500,
  Color $600,
  Color $700,
  Color $800,
});

extension AlertColorsExtension on AlertColors {
  AlertColors lerp(
    AlertColors other,
    double t,
  ) =>
      (
        background: Color.lerp(this.background, other.background, t)!,
        info: Color.lerp(this.info, other.info, t)!,
        error: Color.lerp(this.error, other.error, t)!,
        success: Color.lerp(this.success, other.success, t)!
      );
}

extension NeutralColorsExtension on NeutralColors {
  NeutralColors lerp(
    NeutralColors other,
    double t,
  ) =>
      (
        $100: Color.lerp(this.$100, other.$100, t)!,
        $200: Color.lerp(this.$200, other.$200, t)!,
        $300: Color.lerp(this.$300, other.$300, t)!,
        $400: Color.lerp(this.$400, other.$400, t)!,
        $500: Color.lerp(this.$500, other.$500, t)!,
        $600: Color.lerp(this.$600, other.$600, t)!,
        $700: Color.lerp(this.$700, other.$700, t)!,
        $800: Color.lerp(this.$800, other.$800, t)!,
      );
}
