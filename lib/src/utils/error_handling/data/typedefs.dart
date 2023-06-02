part of 'failure.dart';

typedef FailureCatcher = Function(Failure failure);
typedef ErrorFallback<T> = FutureOr<T> Function(Failure failure);
