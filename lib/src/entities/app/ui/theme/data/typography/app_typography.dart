import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/entities/app/ui/theme/theme_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'text_styles.dart';

part 'typography_shapes.dart';

class AppTypography extends ThemeExtension<AppTypography> {
  final PrimaryTextStyle primary;
  final SecondaryTextStyle secondary;
  final TextStyle button;

  const AppTypography._({
    required this.primary,
    required this.secondary,
    required this.button,
  });

  AppTypography.light()
      : primary = (
          paragraph: (
            medium: TextStyles.primaryParagraphMedium,
            small: TextStyles.primaryParagraphSmall,
          ),
          title: (
            large: TextStyles.primaryTitleLargeBold,
            small: TextStyles.primaryTitleSmallBold,
          ),
        ),
        secondary = (
          caption: (
            medium: TextStyles.secondaryCaptionMedium,
            regular: TextStyles.secondaryCaptionSmall,
          ),
          paragraph: (
            large: TextStyles.secondaryParagraphLargeMed,
            medium: TextStyles.secondaryParagraphMediumReg,
            small: TextStyles.secondaryParagraphSmallReg,
          ),
          footnote: TextStyles.secondaryFootnote,
        ),
        button = TextStyles.buttonLight;

  @override
  ThemeExtension<AppTypography> copyWith({
    PrimaryTextStyle? primary,
    SecondaryTextStyle? secondary,
    TextStyle? button,
    TextStyle? footnote,
  }) {
    return AppTypography._(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      button: button ?? this.button,
    );
  }

  @override
  ThemeExtension<AppTypography> lerp(
    covariant ThemeExtension<AppTypography>? other,
    double t,
  ) {
    if (other is! AppTypography) return this;

    return AppTypography._(
      primary: primary.lerp(other.primary, t),
      secondary: secondary.lerp(other.secondary, t),
      button: TextStyle.lerp(button, other.button, t)!,
    );
  }
}
