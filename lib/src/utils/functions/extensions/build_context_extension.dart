part of 'extensions.dart';

extension BuildContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);

  ColorPalette get palette => theme.extension<ColorPalette>()!;

  InputPalette get inputPalette => theme.extension<InputPalette>()!;

  NeutralColors get neutralColors => palette.neutrals;

  AlertColors get alertColors => palette.alerts;

  BackgroundColors get bgColors => palette.bg;

  AppTypography get typography => theme.extension<AppTypography>()!;

  PrimaryTextStyle get primaryTypography => typography.primary;

  SecondaryTextStyle get secondaryTypography => typography.secondary;
}
