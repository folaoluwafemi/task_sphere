import 'package:flutter/material.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';

part 'otp_input_palette.dart';

part 'single_input_palette.dart';

class InputPalette extends ThemeExtension<InputPalette> {
  final SingleInputPalette textFieldPalette;
  final OtpInputPalette otpPalette;

  const InputPalette._({
    required this.textFieldPalette,
    required this.otpPalette,
  });

  const InputPalette.light()
      : textFieldPalette = (
          empty: const SingleInputColors(
            borderColor: AppColors.neutral300,
            fillColor: AppColors.backgroundGrey,
            prefixIconColor: AppColors.neutral300,
          ),
          focused: const SingleInputColors(
            borderColor: AppColors.brown,
            fillColor: AppColors.backgroundGrey,
            prefixIconColor: AppColors.brown,
          ),
          filled: const SingleInputColors(
            borderColor: AppColors.neutral300,
            fillColor: AppColors.backgroundGrey,
            prefixIconColor: AppColors.brown,
          ),
        ),
        otpPalette = (
          focused: const OtpInputColors(
            borderColor: AppColors.brown,
            fillColor: AppColors.backgroundGrey,
          ),
          unfocused: const OtpInputColors(
            borderColor: AppColors.neutral300,
            fillColor: AppColors.backgroundGrey,
          ),
        );

  @override
  ThemeExtension<InputPalette> copyWith({
    SingleInputPalette? textFieldPalette,
    OtpInputPalette? otpPalette,
  }) {
    return InputPalette._(
      textFieldPalette: textFieldPalette ?? this.textFieldPalette,
      otpPalette: otpPalette ?? this.otpPalette,
    );
  }

  @override
  ThemeExtension<InputPalette> lerp(
    covariant ThemeExtension<InputPalette>? other,
    double t,
  ) {
    if (other is! InputPalette) return this;
    return InputPalette._(
      textFieldPalette: SingleInputColors.lerpPalette(
        textFieldPalette,
        other.textFieldPalette,
        t,
      ),
      otpPalette: OtpInputColors.lerpPalette(otpPalette, other.otpPalette, t),
    );
  }
}
