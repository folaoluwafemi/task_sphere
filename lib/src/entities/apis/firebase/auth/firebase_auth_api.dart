import 'package:firebase_auth/firebase_auth.dart';

part 'auth_api_interface.dart';

final class FirebaseAuthApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final UserCredential login = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    AuthCredential token = login.credential!;
    _auth.signInWithCredential(token);
  }
}
