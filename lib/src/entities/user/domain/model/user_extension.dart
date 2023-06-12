import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

extension UserExtension on User {
  String? get firstname => displayName?.words.first;

  String? get lastname => displayName?.words.last;
}
