import 'package:flutter/foundation.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

mixin VanillaUtilsMixin<State extends VanillaStateWithStatus>
    on ValueNotifier<State> {
  State get state => value;

  set state(State state) {
    value = state;
  }

  void emitOnError(Failure error) {
    state = state.copyWith(error: error, loading: false, success: false);
  }

  void emitLoading([nullifyError = true]) {
    state = state.copyWith(
      loading: true,
      success: false,
      error: nullifyError ? null : state.error,
    );
  }

  void emitSuccess([nullifyError = true]) {
    state = state.copyWith(
      success: true,
      loading: false,
      error: nullifyError ? null : state.error,
    );
  }
}
