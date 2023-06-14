import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

mixin FirebaseErrorHandlerMixin {
  Future<T> handleError<T>(
    Future<T> computation, {
    ErrorFallback<T>? catcher,
  }) async {
    try {
      return await computation;
    } on FirebaseAuthException catch (e, stackTrace) {
      final Failure failure = Failure(
        message: e.code,
        exception: e,
        stackTrace: stackTrace,
      );
      return catcher != null ? catcher.call(failure) : Future.error(failure);
    } on FirebaseException catch (e, stackTrace) {
      Failure failure = Failure(
        message: e.message,
        exception: Exception('$e'),
        stackTrace: stackTrace,
      );
      Log.error('$failure \n | code: ${e.code}');
      return catcher != null ? catcher.call(failure) : Future.error(failure);
    } on SocketException catch (e, stackTrace) {
      Failure failure = Failure(
        message: e.message,
        exception: Exception('Socket Exception'),
        stackTrace: stackTrace,
      );
      return catcher != null ? catcher.call(failure) : Future.error(failure);
    } on TypeError catch (e, stackTrace) {
      final Failure failure = Failure(
        message: 'A Type/Cast Error occurred $e',
        stackTrace: stackTrace,
      );
      Log.error(failure);
      return catcher != null ? catcher.call(failure) : Future.error(failure);
    } catch (e, stackTrace) {
      if (e is Failure) {
        Log.escalatedError(e);
        return catcher != null ? catcher.call(e) : Future.error(e);
      }
      Failure failure = Failure(
        message: 'Unknown Error $e',
        exception: Exception('${e.runtimeType}'),
        stackTrace: stackTrace,
      );
      Log.escalatedError(failure);
      return catcher != null ? catcher.call(failure) : Future.error(failure);
    }
  }
}
