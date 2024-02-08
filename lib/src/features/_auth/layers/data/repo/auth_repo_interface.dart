import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_sphere/archive/analytics/layers/data/source/analysis_source/analysis_source_interface.dart';
import 'package:task_sphere/src/entities/user/data/user_source/network_user_source.dart';
import 'package:task_sphere/src/entities/user/user_barrel.dart';
import 'package:task_sphere/src/features/features_barrel.dart';

part 'auth_repository.dart';

abstract interface class AuthRepoInterface {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<User> register({
    required String email,
    required String password,
  });

  Future<User> updateName({
    required String firstname,
    required String lastname,
  });

  Future<void> sendResetEmail(String email);

  Future<User> fetchUser();

  Future<void> logout();
}
