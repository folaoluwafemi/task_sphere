import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:task_sphere/src/entities/apis/appwrite/appwrite_api_barrel.dart';

part 'auth_api_interface.dart';

class AppWriteAuthApi
    with AppwriteErrorHandlerMixin
    implements AppwriteAuthApiInterface {
  final Account _account;

  AppWriteAuthApi({
    required AppwriteClient client,
  }) : _account = Account(client.client);

  asd() {}

  @override
  Future<Session> login({
    required String email,
    required String password,
  }) =>
      handleError(_login(email: email, password: password));

  Future<Session> _login({
    required String email,
    required String password,
  }) async {
    return await _account.createEmailSession(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> logout() => handleError(_logout());

  Future<void> _logout() async {
    return await _account.deleteSessions();
  }

  @override
  Future<(User, Session)> register({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) =>
      handleError(_register(
        firstname: firstname,
        lastname: lastname,
        email: email,
        password: password,
      ));

  Future<(User, Session)> _register({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) async {
    final User user = await _account.create(
      userId: ID.unique(),
      email: email,
      password: password,
    );

    final Session session = await _account.createEmailSession(
      email: email,
      password: password,
    );

    return (user, session);
  }
}
