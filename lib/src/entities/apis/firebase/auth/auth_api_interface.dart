part of 'firebase_auth_api.dart';

abstract interface class AuthApiInterface {
  Future<AuthCredential> login({
    required String email,
    required String password,
  });

  Future<(User, AuthCredential)> register({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  });

  Future<void> logout();
}
