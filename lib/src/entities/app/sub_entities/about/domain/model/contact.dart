import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
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
      final Uri uri = Uri.parse(url);
      final bool canLaunch = await url_launcher.canLaunchUrl(uri);
      if (!canLaunch) {
        await Clipboard.setData(ClipboardData(text: url));
        onError(
          'Cannot  launch  url!!,   But  it  has  been  copied  to  your  clipboard!',
        );
      }
      await url_launcher.launchUrl(uri);
    } catch (e) {
      debugPrint('error $e');
      final Failure failure = e is Failure ? e : Failure(message: e.toString());
      onError(failure.message ?? 'unknown error occurred');
    }
  }
}
