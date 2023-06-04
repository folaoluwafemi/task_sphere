import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

mixin HiveErrorHandlerMixin {
  Future<T> handleError<T>(
    Future<T> computation, {
    ErrorFallback<T>? catcher,
  }) async {
    try {
      return await computation;
    } on HiveError catch (e, stackTrace) {
      Failure failure = Failure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
      debugPrint('$failure');
      return catcher?.call(failure) ?? Future.error(failure);
    } catch (e, stackTrace) {
      late Failure failure;
      if (e is! Failure) {
        failure = Failure(message: '$e', stackTrace: stackTrace);
      } else {
        failure = e;
      }

      debugPrint('$failure');

      return catcher?.call(failure) ?? Future.error(failure);
    }
  }

  T handleSyncError<T>(
    T computation, {
    ErrorFallback<T>? catcher,
  }) {
    try {
      return computation;
    } on HiveError catch (e, stackTrace) {
      Failure failure = Failure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
      debugPrint('$failure');
      catcher?.call(failure);
      throw failure;
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
