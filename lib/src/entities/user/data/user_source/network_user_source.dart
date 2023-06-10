import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_sphere/src/entities/apis/firebase/firebase_api_barrel.dart';

part 'network_user_source_api.dart';

class FirebaseUserSource
    with FirebaseErrorHandlerMixin
    implements NetworkUserSourceInterface {
  final FirebaseAuth _firebaseAuth;

  FirebaseUserSource({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<User> getUser({
    required String userId,
  }) =>
      handleError(_getUser(userId: userId));

  Future<User> _getUser({
    required String userId,
  }) async {
    final User user = _firebaseAuth.currentUser!;
    return user;
  }

  @override
  Future<void> updateName({
    required String firstname,
    required String lastname,
  }) =>
      handleError(_updateName(firstname: firstname, lastname: lastname));

  Future<void> _updateName({
    required String firstname,
    required String lastname,
  }) async {
    await _firebaseAuth.currentUser?.updateDisplayName('$firstname $lastname');
  }
}
