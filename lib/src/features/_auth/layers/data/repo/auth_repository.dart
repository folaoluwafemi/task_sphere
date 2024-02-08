part of 'auth_repo_interface.dart';

class AuthRepository implements AuthRepoInterface {
  final AuthApi _authApi;
  final NetworkUserSourceInterface _userSource;

  AuthRepository({
    NetworkUserSourceInterface? userSource,
    AuthApi? authApi,
  })  : _userSource = userSource ?? FirebaseUserSource(),
        _authApi = authApi ?? FirebaseAuthApi();

  @override
  Future<User> fetchUser() async {
    final User user = await _authApi.fetchUser();
    UserManager().updateUser(user);
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
    UserManager().updateUser(user);
    return user;
  }

  @override
  Future<void> logout() async {
    UserManager().deleteUser();
    await SearchHistoryManager().clearHistory();
    await _authApi.logout();
  }

  @override
  Future<User> register({
    required String email,
    required String password,
  }) async {
    final User user = await _authApi.registerAndRequestOtp(
      email: email,
      password: password,
    );

    UserManager().updateUser(user);

    await FirebaseAnalysisSource().createUserAnalyticsBucket(user.uid);

    return user;
  }

  @override
  Future<User> updateName({
    required String firstname,
    required String lastname,
  }) async {
    await _userSource.updateName(
      firstname: firstname,
      lastname: lastname,
    );

    final User user = await fetchUser();

    UserManager().updateUser(user);

    return user;
  }

  @override
  Future<void> sendResetEmail(String email) async {
    await _authApi.requestResetEmail(email);
  }
}
