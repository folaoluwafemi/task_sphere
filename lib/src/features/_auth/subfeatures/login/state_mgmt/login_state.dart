part of 'login_vanilla.dart';

class LoginState extends VanillaStateWithStatus {
  const LoginState({
    super.success = false,
    super.loading = false,
    super.error,
  });

  @override
  LoginState copyWith({
    bool? success,
    bool? loading,
    Failure? error,
  }) {
    return LoginState(
      success: success ?? this.success,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [success, loading, error];
}
