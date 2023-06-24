import 'package:flutter/cupertino.dart';
import 'package:task_sphere/src/utils/constants/assets/assets.dart';
import 'package:task_sphere/src/utils/error_handling/data/failure.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

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

  const Contact.whatsapp({
    required this.placeholder,
    required this.url,
  }) : vectorAsset = VectorAssets.whatsapp;

  Future<void> launchUrl(Function(String message) onError) async {
    try {
      await url_launcher.launchUrl(Uri.parse(url));
    } catch (e) {
      debugPrint('error $e');
      final Failure failure = e is Failure ? e : Failure(message: e.toString());
      onError(failure.message ?? 'unknown error occurred');
    }
  }
}
