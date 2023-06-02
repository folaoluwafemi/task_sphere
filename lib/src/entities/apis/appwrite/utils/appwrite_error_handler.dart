import 'package:appwrite/appwrite.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

mixin AppwriteErrorHandlerMixin {
  Future<T> handleError<T>(
    Future<T> computation, {
    ErrorFallback<T>? catcher,
  }) async {
    try {
      return await computation;
    } on AppwriteException catch (exception, stackTrace) {
      Failure failure = Failure(
        message: exception.message,
        stackTrace: stackTrace,
      );

      switch (exception.code) {
        case null:
          break;
        case >= 300 && < 400:
          failure = _handleRequireAction(
            exception: exception,
            stackTrace: stackTrace,
          );
        case >= 400 && < 500:
          failure = _handleClientFailure(
            exception: exception,
            stackTrace: stackTrace,
          );
        case >= 500:
          failure = _handleServerError(
            exception: exception,
            stackTrace: stackTrace,
          );
          break;
      }

      Log.error('appwrite error: $failure');

      return catcher != null ? catcher.call(failure) : Future<T>.error(failure);
    } catch (e, stackTrace) {
      late Failure failure;
      if (e is! Failure) {
        failure = Failure(message: '$e', stackTrace: stackTrace);
      } else {
        failure = e;
      }
      Log.error('appwrite error: $failure');

      return catcher != null ? catcher.call(failure) : Future<T>.error(failure);
    }
  }

  Failure _handleClientFailure({
    required AppwriteException exception,
    required StackTrace stackTrace,
  }) {
    Failure failure = Failure(
      message: exception.message,
      stackTrace: stackTrace,
    );

    //TODO: implement client error handling

    return failure;
  }

  Failure _handleRequireAction({
    required AppwriteException exception,
    required StackTrace stackTrace,
  }) {
    Failure failure = Failure(
      message: exception.message,
      stackTrace: stackTrace,
    );

    //TODO: implement client error handling

    return failure;
  }

  Failure _handleServerError({
    required AppwriteException exception,
    required StackTrace stackTrace,
  }) {
    Failure failure = Failure(
      message: exception.message,
      stackTrace: stackTrace,
    );

    //TODO: implement server error handling

    return failure;
  }
}
