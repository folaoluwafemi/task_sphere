import 'package:flutter/material.dart';
import 'package:task_sphere/src/entities/app/ui/theme/theme_barrel.dart';

abstract final class AppTheme {
  static ThemeData get light => _lightTheme;
}

final ThemeData _lightTheme = ThemeData.light().copyWith(
  primaryColor: AppColors.orange,
  colorScheme: const ColorScheme.light(
    secondary: AppColors.brown,
    secondaryContainer: AppColors.lightOrange,
    error: AppColors.redAlert,
    background: AppColors.backgroundGrey,
  ),
  scaffoldBackgroundColor: AppColors.backgroundGrey,
  canvasColor: AppColors.backgroundGrey,
  cardColor: AppColors.backgroundWhite,
  iconTheme: const IconThemeData(
    color: AppColors.brown,
  ),
  indicatorColor: AppColors.orange,
  highlightColor: AppColors.lightOrange,

  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.orange,
    selectionColor: AppColors.lightOrange,
    selectionHandleColor: AppColors.brown,
  ),
  extensions: [
    const ColorPalette.light(),
    const InputPalette.light(),
    AppTypography.light(),
  ],
);
