part of 'network_user_source.dart';

abstract interface class NetworkUserSourceInterface {
  Future<User> getUser({
    required String userId,
  });

  Future<void> updateName({
    required String firstname,
    required String lastname,
  });
}
