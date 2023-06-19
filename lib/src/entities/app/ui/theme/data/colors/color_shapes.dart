part of 'color_palette.dart';

typedef ProductivityColors = ({
  Color none,
  Color low,
  Color medium,
  Color high,
  Color extra,
});

typedef AlertColors = ({
  /// alertBg #383C50
  Color background,

  /// yellowAlert #E4CB44
  Color info,

  /// redAlert #C14242
  Color error,

  /// greenAlert #32A680
  Color success,
});

typedef BackgroundColors = ({
  /// backgroundWhite #FFFFFF
  Color $50,

  /// backgroundGrey #F3F3F3
  Color $100,
});

typedef NeutralColors = ({
  /// neutral100 #F5F5F5
  Color $100,

  /// neutral200 #E8EAF0
  Color $200,

  /// neutral300 #DFE1E3
  Color $300,

  /// neutral400 #D2D6E0
  Color $400,

  /// neutral500 #B2B6C0
  Color $500,

  /// neutral600 #777D8D
  Color $600,

  /// neutral700 #585B65
  Color $700,

  /// neutral800 #161617
  Color $800,
});

extension BackGroundColorsExtension on BackgroundColors {
  BackgroundColors lerp(
    BackgroundColors other,
    double t,
  ) =>
      (
        $50: Color.lerp(this.$50, other.$50, t)!,
        $100: Color.lerp(this.$100, other.$100, t)!,
      );
}

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

extension ProductivityColorExtension on ProductivityColors {
  ProductivityColors lerp(
    ProductivityColors other,
    double t,
  ) =>
      (
        none: Color.lerp(this.none, other.none, t)!,
        low: Color.lerp(this.low, other.low, t)!,
        medium: Color.lerp(this.medium, other.medium, t)!,
        extra: Color.lerp(this.extra, other.extra, t)!,
        high: Color.lerp(this.high, other.high, t)!,
      );
}
