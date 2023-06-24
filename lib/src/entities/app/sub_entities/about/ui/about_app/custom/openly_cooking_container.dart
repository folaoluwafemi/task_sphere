part of '../about_app_screen.dart';

class _OpenlyCookingContainer extends StatefulWidget {
  const _OpenlyCookingContainer({Key? key}) : super(key: key);

  @override
  State<_OpenlyCookingContainer> createState() =>
      _OpenlyCookingContainerState();
}

class _OpenlyCookingContainerState extends State<_OpenlyCookingContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: TaskCardContainer(
        gutterWidth: 59.w,
        gutterThickness: 6.h,
        child: Container(
          padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 84.w,
                height: 68.h,
                child: Image.asset(
                  Assets.openSourced,
                  fit: BoxFit.contain,
                ),
              ),
              10.boxHeight,
              Text(
                'Openly cooking!',
                style: context.primaryTypography.title.large
                    .withColor(context.palette.secondary),
              ),
              10.boxHeight,
              Text(
                'TaskSphere is proudly open source.',
                style: context.primaryTypography.paragraph.small
                    .withColor(context.palette.primary),
              ),
              24.boxHeight,
              // Text(
              //   TaskSphereInfo.weAreOpenSourced,
              //   style: context.secondaryTypography.paragraph.medium.asRegular
              //       .withColor(context.neutralColors.$800),
              // ),

              Text.rich(
                TextSpan(
                  text: 'Check out TaskSphere\'s inner workings on ',
                  style: context.secondaryTypography.paragraph.medium.asRegular
                      .withColor(context.neutralColors.$800),
                  children: [
                    TextSpan(
                      text: 'GitHub',
                      style: context
                          .secondaryTypography.paragraph.medium.asRegular
                          .copyWith(
                        color: context.neutralColors.$600,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchLink(TaskSphereInfo.githubLink),
                    ),
                    const TextSpan(
                      text: ' and draw inspiration from its delightful ',
                    ),
                    TextSpan(
                      text: 'Figma design',
                      style: context
                          .secondaryTypography.paragraph.medium.asRegular
                          .copyWith(
                        color: context.neutralColors.$600,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => launchLink(TaskSphereInfo.figmaLink),
                    ),
                    const TextSpan(
                      text: '. While not everyone may want to contribute,'
                          ' you\'re welcome to explore and get a peek behind the scenes.'
                          ' TaskSphere\'s code and design are publicly available for'
                          ' viewing, giving you a chance to see how it all comes together!',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> launchLink(String url) async {
    try {
      await url_launcher.launchUrl(Uri.parse(url));
    } catch (e) {
      debugPrint('error $e');
      final Failure failure = e is Failure ? e : Failure(message: e.toString());
      if (!mounted) return;
      AlertType.error.show(
        context,
        text: failure.message ?? ErrorMessages.unknown,
      );
    }
  }
}
