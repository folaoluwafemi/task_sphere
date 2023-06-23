import 'package:task_sphere/src/entities/app/sub_entities/about/about_app_barrel.dart';

abstract final class ContactContents {
  static const List<ContactInfo> collaboratorContacts = [
    developer,
    designer,
    projectManager,
  ];

  /// The guy who wrote this code :)
  static const ContactInfo developer = ContactInfo(
    name: 'Fola Oluwafemi (dartgod)',
    role: 'Developer',
    contacts: [
      Contact.email(
        placeholder: 'folaoluwafemi55@gmail.com',
        url: 'mailto:folaoluwafemi55@gmail.com',
      ),
      Contact.twitter(
        placeholder: '@popestrings',
        url: 'https://twitter.com/popestrings',
      ),
    ],
  );

  /// The guy who made the crazy ass design
  static const ContactInfo designer = ContactInfo(
    name: 'UXer Oluwatobi',
    role: 'Designer',
    contacts: [
      Contact.email(
        placeholder: 'samsontobi890@gmail.com',
        url: 'mailto:samsontobi890@gmail.com',
      ),
    ],
  );

  /// The lady who managed the process
  static const ContactInfo projectManager = ContactInfo(
    name: 'Bolade Oluwafemi',
    role: 'Project manager',
    contacts: [
      Contact.email(
        placeholder: 'boladevictory@gmail.com',
        url: 'mailto:boladevictory@gmail.com',
      ),
      Contact.whatsapp(
        placeholder: '@boladevictory',
        url: 'https://wa.me/2349028344017',
      ),
    ],
  );
}
