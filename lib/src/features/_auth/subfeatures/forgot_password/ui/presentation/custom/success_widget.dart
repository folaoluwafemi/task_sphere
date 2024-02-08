part of '../forgot_password_screen.dart';

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        113.boxHeight,
        SizedBox.square(
          dimension: 114.l,
          child: Image.asset(
            Assets.simpleMail,
            fit: BoxFit.contain,
          ),
        ),
        36.boxHeight,
        Text(
          'Link sent',
          style: context.primaryTypography.title.large.asBold
              .withColor(context.neutralColors.$800),
        ),
        6.boxHeight,
        Text(
          'We understand that life happens, we’ll send a link to your email to reset your password.',
          style: context.secondaryTypography.paragraph.medium.copyWith(
            color: context.neutralColors.$700,
            fontWeight: FontWeight.normal,
          ),
        ),
        38.boxHeight,
        SmallButton(
          onPressed: () => context.goNamed(AppRoute.login.name),
          width: 354.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login to your account',
                style: context.primaryTypography.paragraph.medium.withColor(
                  context.neutralColors.$100,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
