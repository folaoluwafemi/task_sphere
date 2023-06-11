part of 'extensions.dart';

extension BuildContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get screenHeight => mediaQuery.size.height;

  double get screenWidth => mediaQuery.size.width;

  double get topScreenPadding => mediaQuery.viewPadding.top;

  double get bottomScreenPadding => mediaQuery.viewPadding.bottom;

  double get verticalPadding => mediaQuery.viewPadding.vertical;

  ThemeData get theme => Theme.of(this);

  ColorPalette get palette => theme.extension<ColorPalette>()!;

  InputPalette get inputPalette => theme.extension<InputPalette>()!;

  NeutralColors get neutralColors => palette.neutrals;

  AlertColors get alertColors => palette.alerts;

  BackgroundColors get bgColors => palette.bg;

  AppTypography get typography => theme.extension<AppTypography>()!;

  PrimaryTextStyle get primaryTypography => typography.primary;

  SecondaryTextStyle get secondaryTypography => typography.secondary;

  TextStyle get buttonTextStyle => primaryTypography.paragraph.medium;
}
