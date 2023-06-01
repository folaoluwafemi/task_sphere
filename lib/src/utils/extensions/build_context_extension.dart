part of 'extensions.dart';

extension BuildContextExtension on BuildContext {
  T read<T extends VanillaNotifier>() {
    return VanillaNotifierHolder.read<T>(this);
  }
}
