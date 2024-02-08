part of 'forgot_password_presenter.dart';

class ForgotPasswordState extends VanillaStateWithStatus {
  const ForgotPasswordState({
    super.success = false,
    super.loading = false,
    super.error,
  });

  @override
  ForgotPasswordState copyWith({
    bool? success,
    bool? loading,
    Failure? error,
  }) {
    return ForgotPasswordState(
      success: success ?? this.success,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [success, loading, error];
}
