import 'package:flutter/material.dart';
import 'package:task_sphere/src/entities/app/ui/theme/theme_barrel.dart';

part 'color_shapes.dart';

class TaskSpherePalette extends ThemeExtension<TaskSpherePalette> {
  final AlertColors alerts;
  final NeutralColors neutrals;
  final Color primary;
  final Color secondary;
  final Color bgAccent;

  const TaskSpherePalette._({
    required this.alerts,
    required this.neutrals,
    required this.primary,
    required this.secondary,
    required this.bgAccent,
  });

  const TaskSpherePalette.light()
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
        );

  @override
  ThemeExtension<TaskSpherePalette> copyWith({
    AlertColors? alerts,
    NeutralColors? neutrals,
    Color? primary,
    Color? secondary,
    Color? bgAccent,
  }) =>
      TaskSpherePalette._(
        alerts: alerts ?? this.alerts,
        neutrals: neutrals ?? this.neutrals,
        primary: primary ?? this.primary,
        secondary: secondary ?? this.secondary,
        bgAccent: bgAccent ?? this.bgAccent,
      );

  @override
  ThemeExtension<TaskSpherePalette> lerp(
    covariant ThemeExtension<TaskSpherePalette>? other,
    double t,
  ) {
    if (other is! TaskSpherePalette) return this;

    return TaskSpherePalette._(
      alerts: alerts.lerp(other.alerts, t),
      neutrals: neutrals.lerp(other.neutrals, t),
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      bgAccent: Color.lerp(bgAccent, other.bgAccent, t)!,
    );
  }
}
