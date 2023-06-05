part of 'auth_repo_interface.dart';

class AuthRepository implements AuthRepoInterface {
  final AuthApi _authApi;

  AuthRepository({
    AuthApi? authApi,
  }) : _authApi = authApi ?? FirebaseAuthApi();

  @override
  Future<User> fetchUser() async {
    final User user = await _authApi.fetchUser();
    UserManager.updateUser(user);
    return user;
  }

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    final User user = await _authApi.login(
      email: email,
      password: password,
    );
    UserManager.updateUser(user);
    return user;
  }

  @override
  Future<void> logout() {
    UserManager.deleteUser();
    return _authApi.logout();
  }

  @override
  Future<User> register({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) async {
    final User user = await _authApi.register(
      firstname: firstname,
      lastname: lastname,
      email: email,
      password: password,
    );

    UserManager.updateUser(user);

    await FirebaseAnalysisSource().createUserAnalyticsBucket(user.uid);

    return user;
  }
}
