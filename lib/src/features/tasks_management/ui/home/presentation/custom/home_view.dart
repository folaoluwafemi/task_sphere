part of '../home_screen.dart';

class _HomeView extends StatelessWidget {
  final VoidCallback showDrawer;
  final ValueNotifier<double> drawerOffsetNotifier;

  const _HomeView({
    Key? key,
    required this.showDrawer,
    required this.drawerOffsetNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        65.boxHeight,
        Padding(
          padding: EdgeInsets.only(left: 18.w),
          child: Row(
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
                        style:
                            context.primaryTypography.paragraph.medium.copyWith(
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
          ),
        ),
        20.boxHeight,
        SizedBox(
          width: context.screenWidth,
          child: Placeholder(
            strokeWidth: 1,
          ),
        ),
      ],
    );
  }
}

class MenuButton extends StatelessWidget {
  final ValueNotifier<double> drawerOffsetNotifier;
  final VoidCallback toggleDrawer;

  const MenuButton({
    Key? key,
    required this.drawerOffsetNotifier,
    required this.toggleDrawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleDrawer,
      borderRadius: Ui.circularBorder(6.m),
      child: ValueListenableBuilder<double>(
        valueListenable: drawerOffsetNotifier,
        builder: (_, offset, __) {
          final bool showing = !offset.isAround(0);
          return Container(
            width: 40.l,
            height: 40.l,
            decoration: BoxDecoration(
              borderRadius: Ui.circularBorder(6.l),
              color: context.neutralColors.$200,
            ),
            child: Center(
              child: SvgDecorator.square(
                dimension: showing ? 20.l : 12.l,
                color: context.neutralColors.$800,
                child: SvgPicture.asset(
                  showing ? VectorAssets.closeX : VectorAssets.fourDots,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
