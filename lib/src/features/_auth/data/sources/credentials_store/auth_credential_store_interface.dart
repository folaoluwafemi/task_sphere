part of 'auth_credential_store.dart';

abstract interface class AuthCredentialStoreInterface {
  Future<void> save(AuthCredential credential);

  Future<void> delete();
}
