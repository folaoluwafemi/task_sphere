import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'private.dart';

abstract final class UserManager {
  static final UserVanillaNotifier notifier = UserVanillaNotifier(null);

  static User? get user {
    if (notifier.readData != null) return notifier.readData!;

    if (FirebaseAuth.instance.currentUser != null) {
      updateUser(FirebaseAuth.instance.currentUser!);
    }

    return notifier.readData;
  }

  static User get requireUser {
    if (user != null) return user!;

    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Failure(message: ErrorMessages.userNotLoggedIn);
    }

    return currentUser;
  }

  static void updateUser(User user) => notifier.createData(user);

  static void deleteUser() => notifier.deleteData();
}
