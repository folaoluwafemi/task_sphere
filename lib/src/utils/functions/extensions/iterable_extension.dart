part of 'extensions.dart';

extension IterableExtension<T> on Iterable<T> {
  T? get firstOrNull {
    try {
      return first;
    } catch (e) {
      return null;
    }
  }

  T? get lastOrNull {
    try {
      return last;
    } catch (e) {
      return null;
    }
  }
}

extension NullableIterableExtension<T> on Iterable<T>? {
  bool get isNullOrEmpty => this?.isEmpty ?? true;

  bool get isNotNullOrEmpty => this?.isNotEmpty ?? false;
}
