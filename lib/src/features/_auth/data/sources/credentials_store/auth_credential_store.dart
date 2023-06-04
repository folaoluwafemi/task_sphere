import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'auth_credential_store_interface.dart';

final class AuthCredentialStore implements AuthCredentialStoreInterface {
  final Box<Map> _box;

  const AuthCredentialStore({
    Box<Map>? box,
  }) : _box = box ?? Hive.box(name);
}