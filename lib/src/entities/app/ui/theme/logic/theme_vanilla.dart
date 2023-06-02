import 'package:flutter/material.dart';
import 'package:task_sphere/src/utils/state_management/vanilla/vanilla.dart';

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
