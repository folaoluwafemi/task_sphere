import 'package:appwrite/appwrite.dart';

class AppwriteClient {
  final Client _client;

  AppwriteClient._() : _client = Client() {
    _client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('6479dbb8d4949276c5bb')
        .setSelfSigned(status: true); //
  }

  Client get client => _client;

  static final AppwriteClient instance = AppwriteClient._();

  factory AppwriteClient() => instance;
}
