part of '../onboarding_screen.dart';

class _OnboardingView extends StatelessWidget {
  const _OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            children: [
              42.boxHeight,
              Row(
                children: [
                  SizedBox.square(
                    dimension: 39.l,
                    child: SvgPicture.asset(
                      VectorAssets.logo,
                    ),
                  ),
                  10.boxWidth,
                  SizedBox(
                    width: 48.w,
                    height: 30.h,
                    child: SvgPicture.asset(
                      VectorAssets.taskSphereText,
                    ),
                  ),
                ],
              ),
              54.boxHeight,
              SizedBox(
                height: 148.h,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Text(
                        'Elevate your productivity with task management and productivity insights. Start now!',
                        style: context.primaryTypography.title.large.asBold
                            .withColor(
                          context.palette.bg.$50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: Text(
                        'Elevate your productivity with task management and productivity insights. Start now!',
                        style: context.primaryTypography.title.large.asBold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        21.boxHeight,
        Padding(
          padding: EdgeInsets.only(left: 37.w),
          child: SizedBox.square(
            dimension: 303.m,
            child: Image.asset(
              Assets.onboardingIllustration,
              fit: BoxFit.contain,
            ),
          ),
        ),
        46.boxHeight,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: LargeButton(
            width: 354.w,
            height: 50.h,
            onPressed: () => context.goNamed(AppRoute.signUp.name),
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
        ),
        24.boxHeight,
        Center(
          child: InkWell(
            onTap: () => context.goNamed(AppRoute.login.name),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Login to my account',
                  style: context.primaryTypography.paragraph.medium.asMedium,
                ),
                8.boxWidth,
                SvgDecorator.square(
                  color: context.palette.neutrals.$800.withOpacity(0.4),
                  dimension: 24.l,
                  child: SvgPicture.asset(
                    VectorAssets.arrowsRight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
