import 'package:flutter/material.dart';
import 'package:vanilla_state/vanilla_state.dart';

class ThemeVanilla extends VanillaNotifier<ThemeMode> {
  ThemeVanilla() : super(ThemeMode.system);

  void switchToDark() {
    state = ThemeMode.dark;
  }

  void switchToLight() {
    state = ThemeMode.light;
  }

  void switchToSystem() {
    state = ThemeMode.system;
  }

  void switchTo(ThemeMode themeMode) {
    state = themeMode;
  }

  void toggle() => switch (state) {
        ThemeMode.dark => switchToLight(),
        ThemeMode.light => switchToDark(),
        ThemeMode.system => switchToDark(),
      };
}
