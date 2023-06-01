import 'package:flutter/material.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class InheritedVanilla<State extends VanillaState> extends InheritedWidget {
  final VanillaNotifier<State> notifier;

  const InheritedVanilla({
    required this.notifier,
    required super.child,
    super.key,
  });

  static VanillaNotifier<T> read<T extends VanillaState>(
    BuildContext context,
  ) {
    try {
      return context
          .findAncestorWidgetOfExactType<InheritedVanilla<T>>()!
          .notifier;
    } catch (e) {
      throw Exception(
        'Cannot find InheritedVanilla<$T> in the widget tree',
      );
    }
  }

  static VanillaNotifier<T> watch<T extends VanillaState>(
    BuildContext context,
  ) {
    try {
      return context
          .dependOnInheritedWidgetOfExactType<InheritedVanilla<T>>()!
          .notifier;
    } catch (e) {
      throw Exception(
        'Cannot find InheritedVanilla<$T> in the widget tree',
      );
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    if (oldWidget is InheritedVanilla<State>) {
      return oldWidget.notifier.value != notifier.value;
    }
    return false;
  }
}
