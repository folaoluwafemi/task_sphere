import 'package:task_sphere/src/utils/constants/assets/assets.dart';

class Contact {
  final String vectorAsset;
  final String url;
  final String placeholder;

  const Contact.twitter({
    required this.placeholder,
    required this.url,
  }) : vectorAsset = VectorAssets.twitter;

  const Contact.email({
    required this.placeholder,
    required this.url,
  }) : vectorAsset = VectorAssets.emailIcon;
}
