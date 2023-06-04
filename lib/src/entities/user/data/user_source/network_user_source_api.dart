part of 'network_user_source.dart';

abstract interface class NetworkUserSourceInterface {
  Future<User> getUser({
    required String userId,
  });

  Future<User> updateUser({
    required User user,
  });

  Future<User> createUser({
    required User user,
  });

  Future<void> deleteUser({
    required String userId,
  });
}
