part of 'sign_up_vanilla.dart';

class SignUpState extends VanillaStateWithStatus {
  final String? email;

  const SignUpState({
    super.success = false,
    super.loading = false,
    super.error,
    this.email,
  });

  @override
  SignUpState copyWith({
    bool? success,
    bool? loading,
    Failure? error,
    String? email,
  }) {
    return SignUpState(
      success: success ?? this.success,
      loading: loading ?? this.loading,
      error: error ?? this.error,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [
        success,
        loading,
        error,
        email,
      ];
}
