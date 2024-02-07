import 'package:task_sphere/src/features/_auth/auth_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

part 'login_state.dart';

class LoginVanilla extends VanillaNotifier<LoginState>
    with VanillaUtilsMixin<LoginState>, BasicErrorHandlerMixin {
  final AuthRepoInterface _repo;

  LoginVanilla({
    AuthRepoInterface? repo,
  })  : _repo = repo ?? AuthRepository(),
        super(const LoginState());

  Future<void> login({
    required String email,
    required String password,
  }) =>
      handleError(
        _login(email: email, password: password),
        catcher: notifyOnError,
      );

  Future<void> _login({
    required String email,
    required String password,
  }) async {
    notifyLoading();

    await Future.delayed(const Duration(seconds: 2));

    await _repo.login(
      email: email,
      password: password,
    );

    notifySuccess();
  }
}
