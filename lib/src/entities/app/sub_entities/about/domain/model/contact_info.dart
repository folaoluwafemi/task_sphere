import 'package:task_sphere/src/entities/app/sub_entities/about/about_app_barrel.dart';

class ContactInfo {
  final String name, role;
  final List<Contact> contacts;

  const ContactInfo({
    required this.name,
    required this.role,
    required this.contacts,
  });
}
