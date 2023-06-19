import 'package:flutter/material.dart';
import 'package:task_sphere/src/entities/app/ui/theme/theme_barrel.dart';

part 'color_shapes.dart';

class ColorPalette extends ThemeExtension<ColorPalette> {
  final AlertColors alerts;
  final NeutralColors neutrals;
  final BackgroundColors bg;
  final ProductivityColors productivityColors;
  final Color primary;
  final Color secondary;
  final Color bgAccent;

  const ColorPalette._({
    required this.alerts,
    required this.neutrals,
    required this.primary,
    required this.secondary,
    required this.bgAccent,
    required this.bg,
    required this.productivityColors,
  });

  const ColorPalette.light()
      : primary = AppColors.orange,
        secondary = AppColors.brown,
        bgAccent = AppColors.lightOrange,
        alerts = (
          background: AppColors.alertBG,
          info: AppColors.yellowAlert,
          error: AppColors.redAlert,
          success: AppColors.greenAlert,
        ),
        neutrals = (
          $100: AppColors.neutral100,
          $200: AppColors.neutral200,
          $300: AppColors.neutral300,
          $400: AppColors.neutral400,
          $500: AppColors.neutral500,
          $600: AppColors.neutral600,
          $700: AppColors.neutral700,
          $800: AppColors.neutral800,
        ),
        bg = (
          $50: AppColors.backgroundWhite,
          $100: AppColors.backgroundGrey,
        ),
        productivityColors = (
          extra: AppColors.orange,
          high: AppColors.brown,
          medium: AppColors.brown100,
          low: AppColors.brown200,
          none: AppColors.backgroundWhite,
        );

  @override
  ThemeExtension<ColorPalette> copyWith({
    AlertColors? alerts,
    NeutralColors? neutrals,
    ProductivityColors? productivityColors,
    Color? primary,
    Color? secondary,
    Color? bgAccent,
    BackgroundColors? backGroundColors,
  }) =>
      ColorPalette._(
        productivityColors: productivityColors ?? this.productivityColors,
        alerts: alerts ?? this.alerts,
        neutrals: neutrals ?? this.neutrals,
        primary: primary ?? this.primary,
        secondary: secondary ?? this.secondary,
        bgAccent: bgAccent ?? this.bgAccent,
        bg: backGroundColors ?? bg,
      );

  @override
  ThemeExtension<ColorPalette> lerp(
    covariant ThemeExtension<ColorPalette>? other,
    double t,
  ) {
    if (other is! ColorPalette) return this;

    return ColorPalette._(
      productivityColors: productivityColors.lerp(other.productivityColors, t),
      alerts: alerts.lerp(other.alerts, t),
      neutrals: neutrals.lerp(other.neutrals, t),
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      bgAccent: Color.lerp(bgAccent, other.bgAccent, t)!,
      bg: bg.lerp(other.bg, t),
    );
  }
}
