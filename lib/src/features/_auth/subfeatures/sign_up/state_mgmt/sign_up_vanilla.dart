import 'package:task_sphere/src/features/_auth/auth_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

part 'sign_up_state.dart';

class SignUpVanilla extends VanillaNotifier<SignUpState>
    with VanillaUtilsMixin<SignUpState>, BasicErrorHandlerMixin {
  final AuthRepoInterface _repo;

  SignUpVanilla({
    AuthRepoInterface? repo,
  })  : _repo = repo ?? AuthRepository(),
        super(const SignUpState());

  Future<void> signUp({
    required String email,
    required String password,
  }) =>
      handleError(
        _signUp(email: email, password: password),
        catcher: notifyOnError,
      );

  Future<void> _signUp({
    required String email,
    required String password,
  }) async {
    notifyLoading();
    await Future.delayed(const Duration(seconds: 2));

    await _repo.register(
      email: email,
      password: password,
    );
    notifySuccess(state: state.copyWith(email: email));
  }

  Future<void> updateName({
    required String firstname,
    required String lastname,
  }) =>
      handleError(
        _updateName(firstname: firstname, lastname: lastname),
        catcher: notifyOnError,
      );

  Future<void> _updateName({
    required String firstname,
    required String lastname,
  }) async {
    notifyLoading();
    await _repo.updateName(
      firstname: firstname,
      lastname: lastname,
    );
    notifySuccess();
  }
}
