part of '../about_app_screen.dart';

enum AboutButton {
  aboutDev('About Design and Development', VectorAssets.arrowRight),
  privacyPolicy('Our Privacy Policy', VectorAssets.arrowUpRightWeighted);

  final String text, vectorAssetPath;

  const AboutButton(this.text, this.vectorAssetPath);

  static const String privacyPolicyLink =
      'https://docs.google.com/document/d/1E_tUvtQZyyskYSWmTW3RLWjzJr2oSAh2ko5AlpeCj4k/edit?usp=sharing';

  void action(BuildContext context) => switch (this) {
        aboutDev => context.goNamed(AppRoute.aboutDesignAndDev.name),
        privacyPolicy => launchPrivacyPolicy(
            (message) => AlertType.error.show(context, text: message),
          ),
      };

  Future<void> launchPrivacyPolicy(Function(String message) onError) async {
    try {
      await url_launcher.launchUrl(Uri.parse(privacyPolicyLink));
    } catch (e) {
      final Failure failure = e is Failure ? e : Failure(message: e.toString());
      onError(failure.message ?? 'unknown error occurred');
    }
  }
}

class AboutDevButton extends StatelessWidget {
  final AboutButton aboutButtonDetail;
  final VoidCallback onPressed;

  const AboutDevButton({
    Key? key,
    required this.aboutButtonDetail,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: RawMaterialButton(
        elevation: 0,
        highlightElevation: 0,
        onPressed: onPressed,
        highlightColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.l),
        ),
        fillColor: context.bgColors.$50,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 13.h,
        ),
        child: Row(
          children: [
            Text(
              aboutButtonDetail.text,
              style: context.primaryTypography.paragraph.medium,
            ),
            const Spacer(),
            SvgDecorator.square(
              dimension: 24.l,
              color: context.neutralColors.$400,
              child: SvgPicture.asset(aboutButtonDetail.vectorAssetPath),
            ),
          ],
        ),
      ),
    );
  }
}
