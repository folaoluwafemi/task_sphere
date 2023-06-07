import 'package:flutter/material.dart';
import 'package:task_sphere/src/entities/app/ui/theme/theme_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'text_styles.dart';

part 'typography_shapes.dart';

class TaskSphereTypography extends ThemeExtension<TaskSphereTypography> {
  final Primary primary;
  final Secondary secondary;
  final TextStyle button;

  const TaskSphereTypography._({
    required this.primary,
    required this.secondary,
    required this.button,
  });

  TaskSphereTypography.light()
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
        ),
        button = TextStyles.buttonLight;

  @override
  ThemeExtension<TaskSphereTypography> copyWith({
    Primary? primary,
    Secondary? secondary,
    TextStyle? button,
  }) {
    return TaskSphereTypography._(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      button: button ?? this.button,
    );
  }

  @override
  ThemeExtension<TaskSphereTypography> lerp(
    covariant ThemeExtension<TaskSphereTypography>? other,
    double t,
  ) {
    if (other is! TaskSphereTypography) return this;

    return TaskSphereTypography._(
      primary: primary.lerp(other.primary, t),
      secondary: secondary.lerp(other.secondary, t),
      button: TextStyle.lerp(button, other.button, t)!,
    );
  }
}
