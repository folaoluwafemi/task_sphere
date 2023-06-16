part of '../login_screen.dart';

class _LoginOrLoadWidget extends StatelessWidget {
  const _LoginOrLoadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VanillaBuilder<LoginVanilla, LoginState>(
      buildWhen: (previous, current) => previous?.loading != current.loading,
      builder: (context, state) {
        return Center(
          child: Column(
            children: !state.loading
                ? [
                    24.boxHeight,
                    InkWell(
                      onTap: () => context.goNamed(AppRoute.signUp.name),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'I’m new here. Sign me up',
                            style: context
                                .primaryTypography.paragraph.medium.asMedium
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
                  ]
                : [
                    38.boxHeight,
                    const LoaderWidget(),
                    12.boxHeight,
                    Text(
                      'Logging you into your account',
                      style:
                          context.secondaryTypography.paragraph.large.asMedium,
                    ),
                  ],
          ),
        );
      },
    );
  }
}
