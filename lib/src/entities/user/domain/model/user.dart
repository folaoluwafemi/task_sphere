import 'package:appwrite/models.dart';

extension UserExtension on User {
  String get firstname => name.split(' ').first;

  String get lastname => name.split(' ').last;
}
