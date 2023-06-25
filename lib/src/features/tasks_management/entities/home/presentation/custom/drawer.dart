part of '../home_screen.dart';

enum DrawerItem {
  aboutApp('About app', VectorAssets.about, AppRoute.about),
  trash('Trash', VectorAssets.delete, AppRoute.search),
  settings('Settings', VectorAssets.setting, AppRoute.home),
  ;

  final String text, vectorAsset;
  final AppRoute route;

  const DrawerItem(this.text, this.vectorAsset, this.route);
}

class _Drawer extends StatelessWidget {
  final ValueNotifier<double> drawerOffsetNotifier;

  const _Drawer({
    Key? key,
    required this.drawerOffsetNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 212.w,
      height: context.screenHeight,
      decoration: BoxDecoration(
        color: context.bgColors.$50,
        border: Border.symmetric(
          vertical: BorderSide(
            color: context.neutralColors.$400,
            width: 1.w,
          ),
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18.w, right: 24.w),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                72.boxHeight,
                SizedBox.square(
                  dimension: 45.m,
                  child: SvgPicture.asset(
                    VectorAssets.logo,
                  ),
                ),
                56.boxHeight,
                ...DrawerItem.values.take(1).map(
                      (item) => InkWell(
                        borderRadius: Ui.circularBorder(7.l),
                        onTap: () {
                          drawerOffsetNotifier.value = 0;
                          context.goNamed(item.route.name);
                        },
                        child: _DrawerItemWidget(item: item),
                      ),
                    ),
                48.boxHeight,
                Text(
                  'COMING SOON',
                  style: context.primaryTypography.paragraph.small.asRegular,
                ),
                16.boxHeight,
                const Opacity(
                  opacity: 0.5,
                  child: _DisabledOptions(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 32.w, bottom: 66.h),
              child: SafeArea(
                top: false,
                child: RawMaterialButton(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: Ui.circularBorder(7.l),
                  ),
                  onPressed: logout,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgDecorator.square(
                        dimension: 16.l,
                        child: SvgPicture.asset(
                          VectorAssets.share,
                        ),
                      ),
                      6.boxHeight,
                      Text(
                        'Log out',
                        style: context.primaryTypography.paragraph.medium
                            .copyWith(color: AppColors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void logout() {
    AuthRepository().logout().then((value) {
      UserManager().deleteUser();
      AppRouter.navigatorKey.currentContext?.goNamed(AppRoute.onboarding.name);
    });
  }
}

class _DisabledOptions extends StatelessWidget {
  const _DisabledOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ...DrawerItem.values.skip(1).map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: _DrawerItemWidget(item: item),
              ),
            ),
      ],
    );
  }
}

class _DrawerItemWidget extends StatelessWidget {
  final DrawerItem item;

  const _DrawerItemWidget({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: Ui.circularBorder(7.l),
        color: context.neutralColors.$100,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgDecorator.square(
            dimension: 24.l,
            color: context.palette.primary,
            child: SvgPicture.asset(item.vectorAsset),
          ),
          10.boxWidth,
          Text(
            item.text,
            style: context.primaryTypography.paragraph.medium,
          ),
        ],
      ),
    );
  }
}
