import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_sphere/src/entities/user/user_barrel.dart';
import 'package:task_sphere/src/features/_auth/data/auth_api/auth_api.dart';

part 'auth_repository.dart';

abstract interface class AuthRepoInterface {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<User> register({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  });

  Future<User> fetchUser();

  Future<void> logout();
}
