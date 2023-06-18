import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

mixin BasicErrorHandlerMixin {
  Future<T> handleError<T>(
    Future<T> computation, {
    ErrorFallback<T>? catcher,
  }) async {
    try {
      return await computation;
    } catch (e, stackTrace) {
      late Failure failure;
      if (e is! Failure) {
        failure = Failure(message: '$e', stackTrace: stackTrace);
      } else {
        failure = e;
      }
      debugPrint('basic error handler: $failure');

      return catcher != null ? catcher.call(failure) : Future<T>.error(failure);
    }
  }

  T handleSyncError<T>(
    T computation, {
    ErrorFallback<T>? catcher,
  }) {
    try {
      return computation;
    } catch (e) {
      late Failure failure;
      if (e is! Failure) {
        failure = Failure(message: '$e');
      } else {
        failure = e;
      }

      debugPrint('$failure');

      catcher?.call(failure);
      throw failure;
    }
  }
}
