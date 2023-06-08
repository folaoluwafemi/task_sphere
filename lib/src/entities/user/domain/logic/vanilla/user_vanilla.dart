import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'private.dart';

abstract final class UserManager {
  static final _UserVanillaNotifier _notifier = _UserVanillaNotifier(null);

  static User? get user => _notifier.readData;

  static User get requireUser {
    if (user != null) return user!;

    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Failure(message: ErrorMessages.userNotLoggedIn);
    }

    return currentUser;
  }

  static void updateUser(User user) => _notifier.createData(user);

  static void deleteUser() => _notifier.deleteData();
}
