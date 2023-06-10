import 'package:task_sphere/src/utils/utils_barrel.dart';

mixin VanillaUtilsMixin<State extends VanillaStateWithStatus>
    on VanillaNotifier<State> {
  void notifyOnError(Failure error) {
    state = state.copyWith(error: error, loading: false, success: false);
  }

  void notifyLoading([nullifyError = true]) {
    state = state.copyWith(
      loading: true,
      success: false,
      error: nullifyError ? null : state.error,
    );
  }

  void notifySuccess([nullifyError = true]) {
    state = state.copyWith(
      success: true,
      loading: false,
      error: nullifyError ? null : state.error,
    );
  }
}
