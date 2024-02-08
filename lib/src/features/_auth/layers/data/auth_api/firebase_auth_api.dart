part of 'auth_api.dart';

final class FirebaseAuthApi with FirebaseErrorHandlerMixin implements AuthApi {
  final FirebaseAuth _auth;

  FirebaseAuthApi._({
    FirebaseAuth? auth,
  }) : _auth = auth ?? FirebaseAuth.instance;

  static final FirebaseAuthApi _instance = FirebaseAuthApi._();

  factory FirebaseAuthApi() => _instance;

  @override
  Future<User> fetchUser() => handleError(_fetchUser());

  Future<User> _fetchUser() async {
    return _auth.currentUser!;
  }

  @override
  Future<void> requestResetEmail(String email) => handleError(
        _requestResetEmail(email),
      );

  Future<void> _requestResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<User> login({
    required String email,
    required String password,
  }) =>
      handleError(_login(email: email, password: password));

  Future<User> _login({
    required String email,
    required String password,
  }) async {
    final UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return credential.user!;
  }

  @override
  Future<void> logout() => handleError(_logout());

  Future<void> _logout() async {
    await _auth.signOut();
  }

  @override
  Future<User> registerAndRequestOtp({
    required String email,
    required String password,
  }) =>
      handleError(
        _register(
          email: email,
          password: password,
        ),
      );

  Future<User> _register({
    required String email,
    required String password,
  }) async {
    final UserCredential credential =
        await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await credential.user?.updateEmail(email);

    return credential.user!;
  }
}
