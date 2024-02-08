import 'package:task_sphere/src/features/_auth/auth_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

part 'forgot_password_state.dart';

class ForgotPasswordPresenter extends VanillaNotifier<ForgotPasswordState>
    with VanillaUtilsMixin<ForgotPasswordState>, BasicErrorHandlerMixin {
  final AuthRepoInterface _repo;

  ForgotPasswordPresenter({
    AuthRepoInterface? repo,
  })  : _repo = repo ?? AuthRepository(),
        super(const ForgotPasswordState());

  Future<void> requestResetEmail(String email) => handleError(
        _requestResetEmail(email),
        catcher: notifyOnError,
      );

  Future<void> _requestResetEmail(String email) async {
    notifyLoading();
    await _repo.sendResetEmail(email);
    notifySuccess();
  }
}
