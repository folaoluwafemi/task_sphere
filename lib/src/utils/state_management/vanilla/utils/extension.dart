part of '../vanilla.dart';

extension VanillaBuildContextExtension on BuildContext {
  T read<T extends VanillaNotifier>() {
    return VanillaNotifierHolder.read<T>(this);
  }
}
