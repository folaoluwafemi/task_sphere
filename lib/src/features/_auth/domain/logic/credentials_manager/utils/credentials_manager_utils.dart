import 'package:firebase_auth/firebase_auth.dart';

abstract final class CredentialsManagerUtils {
  static AuthCredential credentialFromMap(Map<String, dynamic> map) {
    return AuthCredential(
      providerId: map['providerId'],
      signInMethod: map['signInMethod'],
      token: map['token'],
      accessToken: map['accessToken'],
    );
  }
}
