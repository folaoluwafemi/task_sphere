part of 'appwrite_auth_api.dart';

abstract interface class AppwriteAuthApiInterface {
  Future<Session> login({
    required String email,
    required String password,
  });

  Future<(User, Session)> register({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  });

  Future<void> logout();
}
