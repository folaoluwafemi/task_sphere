import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

part 'private.dart';

final class UserManager {
  UserManager._() {
    FirebaseAuth.instance.authStateChanges().listen(_authStreamListener);
  }

  static final UserManager _instance = UserManager._();

  factory UserManager() => _instance;

  final UserVanillaNotifier notifier = UserVanillaNotifier(null);

  User? get user {
    if (notifier.readData != null) return notifier.readData!;

    if (FirebaseAuth.instance.currentUser != null) {
      updateUser(FirebaseAuth.instance.currentUser!);
    }

    return notifier.readData;
  }

  User get requireUser {
    if (user != null) return user!;

    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Failure(message: ErrorMessages.userNotLoggedIn);
    }

    return currentUser;
  }

  void updateUser(User user) => notifier.createData(user);

  void deleteUser() => notifier.deleteData();

  void _authStreamListener(User? user) {
    if (user == null) {
      deleteUser();
    } else {
      updateUser(user);
    }
  }
}
