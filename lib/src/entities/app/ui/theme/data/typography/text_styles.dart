part of 'task_sphere_typography.dart';

abstract final class TextStyles {
  ///Primary
  ///
  static TextStyle primaryTitleLargeBold = TextStyle(
    fontSize: 31.sp,
    height: 0.968,
    letterSpacing: -0.5,
    fontWeight: FontWeight.bold,
    fontFamily: FontAssets.spaceGrotesk,
  );

  ///
  static TextStyle primaryTitleSmallBold = TextStyle(
    fontSize: 20.sp,
    height: 1,
    letterSpacing: -0.5,
    fontWeight: FontWeight.bold,
    fontFamily: FontAssets.spaceGrotesk,
  );

  ///
  static TextStyle primaryParagraphMedium = TextStyle(
    fontSize: 16.sp,
    height: 1.25,
    letterSpacing: -0.5,
    fontWeight: FontWeight.w500,
    fontFamily: FontAssets.spaceGrotesk,
  );

  ///
  static TextStyle primaryParagraphSmall = TextStyle(
    fontSize: 12.sp,
    height: 1.666667,
    letterSpacing: -0.5,
    fontWeight: FontWeight.w400,
    fontFamily: FontAssets.spaceGrotesk,
  );

  ///Secondary
  ///
  static TextStyle secondaryParagraphLargeMed = TextStyle(
    fontSize: 16.sp,
    height: 1.25,
    letterSpacing: -0.5,
    fontWeight: FontWeight.w500,
    fontFamily: FontAssets.spaceGrotesk,
  );

  ///
  static TextStyle secondaryParagraphMediumReg = TextStyle(
    fontSize: 14.sp,
    height: 1.4285,
    letterSpacing: -0.5,
    fontWeight: FontWeight.w500,
    fontFamily: FontAssets.spaceGrotesk,
  );

  ///
  static TextStyle secondaryParagraphSmallReg = TextStyle(
    fontSize: 12.sp,
    height: 1.66666667,
    letterSpacing: -0.4,
    fontWeight: FontWeight.w400,
    fontFamily: FontAssets.spaceGrotesk,
  );

  ///
  static TextStyle secondaryCaptionMedium = TextStyle(
    fontSize: 10.sp,
    height: 1.2,
    letterSpacing: -0.3,
    fontWeight: FontWeight.w500,
    fontFamily: FontAssets.spaceGrotesk,
  );

  ///
  static TextStyle secondaryCaptionSmall = TextStyle(
    fontSize: 10.sp,
    height: 1.2,
    letterSpacing: -0.3,
    fontWeight: FontWeight.w400,
    fontFamily: FontAssets.spaceGrotesk,
  );
}