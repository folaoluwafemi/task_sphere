import 'package:flutter/material.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'text_styles.dart';

part 'typography_shapes.dart';

class TaskSphereTypography extends ThemeExtension<TaskSphereTypography> {
  final Primary primary;
  final Secondary secondary;

  const TaskSphereTypography._({
    required this.primary,
    required this.secondary,
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
        );

  @override
  ThemeExtension<TaskSphereTypography> copyWith({
    Primary? primary,
    Secondary? secondary,
  }) {
    return TaskSphereTypography._(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
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
    );
  }
}
