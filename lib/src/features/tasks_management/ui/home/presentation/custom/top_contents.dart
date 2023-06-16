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
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder<User?>(
              valueListenable: UserManager.notifier,
              builder: (_, user, __) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  UserManager.user;
                });
                if (user == null || user.firstname == null) {
                  return const SizedBox.shrink();
                }
                return Text(
                  'Hi, ${user.firstname ?? ''}',
                  style: context.primaryTypography.paragraph.medium.copyWith(
                    color: context.palette.primary,
                  ),
                );
              },
            ),
            Text(
              'Be more productive today 🔥',
              style: context.primaryTypography.paragraph.small.asRegular,
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: SvgDecorator(
            color: context.neutralColors.$800,
            child: SvgPicture.asset(
              VectorAssets.search,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgDecorator(
            color: context.neutralColors.$800,
            child: SvgPicture.asset(
              VectorAssets.nightMoon,
            ),
          ),
        ),
      ],
    );
  }
}
