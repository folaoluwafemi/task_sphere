import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_sphere/src/entities/apis/firebase/firebase_api_barrel.dart';

part 'firebase_auth_api.dart';

abstract interface class AuthApi {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<User> registerAndRequestOtp({
    required String email,
    required String password,
  });

  Future<void> requestResetEmail(String email);

  Future<User> fetchUser();

  Future<void> logout();
}
