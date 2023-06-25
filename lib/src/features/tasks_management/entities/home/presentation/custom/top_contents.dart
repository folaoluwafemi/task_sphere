part of '../home_screen.dart';

class _TopContents extends StatelessWidget {
  final ValueNotifier<double> drawerOffsetNotifier;
  final VoidCallback showDrawer;

  const _TopContents({
    required this.drawerOffsetNotifier,
    required this.showDrawer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MenuButton(
          drawerOffsetNotifier: drawerOffsetNotifier,
          toggleDrawer: showDrawer,
        ),
        16.boxWidth,
        VanillaBuilder<ProgressiveAnalyticsVanilla, ProgressiveAnalysisState>(
          buildWhen: (previous, current) {
            return previous?.dailyStreak != current.dailyStreak;
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder<User?>(
                  valueListenable: UserManager().notifier,
                  builder: (_, user, __) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      UserManager().user;
                    });
                    if (user == null || user.firstname == null) {
                      return const SizedBox.shrink();
                    }
                    return Text(
                      'Hi, ${user.firstname ?? ''}',
                      style:
                          context.primaryTypography.paragraph.medium.copyWith(
                        color: state.dailyStreak == 0
                            ? context.palette.primary
                            : context.palette.neutrals.$800,
                      ),
                    );
                  },
                ),
                state.dailyStreak == 0
                    ? Flexible(
                        child: Text(
                          'Start your productivity streak today.',
                          overflow: TextOverflow.ellipsis,
                          style: context
                              .primaryTypography.paragraph.small.asRegular
                              .withColor(context.neutralColors.$700),
                        ),
                      )
                    : Text.rich(
                        TextSpan(
                          text: 'Streak',
                          children: [
                            TextSpan(
                              text: ' | ',
                              style: context
                                  .secondaryTypography.paragraph.small.asMedium
                                  .withColor(context.neutralColors.$400),
                            ),
                            TextSpan(
                              text: 'Day ${state.dailyStreak} 🔥',
                              style: context
                                  .primaryTypography.paragraph.small.asMedium
                                  .copyWith(color: context.palette.primary),
                            ),
                          ],
                        ),
                        style: context
                            .secondaryTypography.paragraph.small.asMedium
                            .withColor(context.neutralColors.$600),
                      ),
              ],
            );
          },
        ),
        const Spacer(),
        IconButton(
          onPressed: () => context.goNamed(AppRoute.search.name),
          icon: SvgDecorator(
            color: context.neutralColors.$800,
            child: SvgPicture.asset(
              VectorAssets.search,
            ),
          ),
        ),
        6.boxWidth,
        // IconButton(
        //   onPressed: () {},
        //   icon: SvgDecorator(
        //     color: context.neutralColors.$800,
        //     child: SvgPicture.asset(
        //       VectorAssets.nightMoon,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
