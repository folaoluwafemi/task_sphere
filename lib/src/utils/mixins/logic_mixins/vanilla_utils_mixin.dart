import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

mixin VanillaUtilsMixin<State extends VanillaStateWithStatus>
    on VanillaNotifier<State> {
  void notifyOnError(Failure error) {
    state = state.copyWith(error: error, loading: false, success: false);
  }

  void notifyLoading({
    nullifyError = true,
    State? state_,
  }) {
    if (state.loading) return;
    state = (state_ ?? state).copyWith(
      loading: true,
      success: false,
      error: nullifyError ? null : state.error,
    );
  }

  void notifySuccess({
    State? state,
    nullifyError = true,
  }) {
    this.state = (state ?? this.state).copyWith(
      success: true,
      loading: false,
      error: nullifyError ? null : (state ?? this.state).error,
    );
  }
}
