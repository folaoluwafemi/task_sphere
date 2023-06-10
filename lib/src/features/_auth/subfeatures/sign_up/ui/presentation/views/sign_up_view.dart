part of '../sign_up_screen.dart';

class _SignUpView extends StatefulWidget {
  const _SignUpView({Key? key}) : super(key: key);

  @override
  State<_SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<_SignUpView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.w, 290.h, 18.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create an account',
            style: context.primaryTypography.title.large,
          ),
          6.boxHeight,
          Text(
            'Join the productivity clan on TaskSphere',
            style: context.secondaryTypography.paragraph.medium.asRegular,
          ),
          52.boxHeight,
          Text(
            'Email address',
            style: context.secondaryTypography.paragraph.large.asMedium
                .withColor(context.neutralColors.$700),
          ),
          8.boxHeight,
          InputFormField(
            hintText: 'Enter your email address',
            keyboardType: TextInputType.emailAddress,
            validator: Validators.emailValidator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            prefixIconBuilder: (_, color) => CustomColorFilter(
              color: color,
              child: SvgPicture.asset(
                VectorAssets.mail,
              ),
            ),
          ),
          32.boxHeight,
          Text(
            'Password',
            style: context.secondaryTypography.paragraph.large.asMedium
                .withColor(context.neutralColors.$700),
          ),
          8.boxHeight,
          PasswordFormField(
            hintText: 'Enter your email address',
            validator: Validators.emailValidator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            prefixIconBuilder: (_, color) => CustomColorFilter(
              color: color,
              child: SvgPicture.asset(
                VectorAssets.password,
              ),
            ),
          ),
          48.boxHeight,
          LargeButton(
            color: context.palette.primary,
            onPressed: onJoinButtonPressed,
            width: 354.w,
            height: 50.h,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox.square(
                  dimension: 24.l,
                  child: SvgPicture.asset(
                    VectorAssets.add,
                  ),
                ),
                6.boxWidth,
                Text(
                  'Join TaskSphere',
                  style: context.buttonTextStyle.withColor(
                    context.bgColors.$50,
                  ),
                ),
              ],
            ),
          ),
          24.boxHeight,
          Center(
            child: InkWell(
              onTap: () => context.goNamed(AppRoute.login.name),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Already have an account? Login',
                    style: context.primaryTypography.paragraph.medium.asMedium
                        .withSize(15.sp),
                  ),
                  8.boxWidth,
                  SizedBox.square(
                    dimension: 24.l,
                    child: SvgPicture.asset(
                      VectorAssets.arrowsRight,
                    ),
                  ),
                ],
              ),
            ),
          ),
          26.boxHeight,
        ],
      ),
    );
  }

  void onJoinButtonPressed() {}
}
