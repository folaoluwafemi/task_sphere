part of '../home_screen.dart';

enum DrawerItems {
  trash('Trash', VectorAssets.delete, AppRoute.trash),
  settings('Settings', VectorAssets.setting, AppRoute.settings),
  ;

  final String text, vectorAsset;
  final AppRoute route;

  const DrawerItems(this.text, this.vectorAsset, this.route);
}

class _Drawer extends StatelessWidget {
  const _Drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 212.w,
      decoration: BoxDecoration(
        color: context.bgColors.$50,
        border: Border.symmetric(
          vertical: BorderSide(
            color: context.neutralColors.$400,
            width: 1.w,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 18.w, right: 24.w),
        child: Column(
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
            ...DrawerItems.values.map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: GestureDetector(
                  // borderRadius: Ui.circularBorder(7.l),
                  onTap: () {
                    //TODO: implement
                  },
                  child: Container(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 2.w),
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
                        style:
                            context.primaryTypography.paragraph.medium.copyWith(
                          color: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            66.boxHeight,
          ],
        ),
      ),
    );
  }

  void logout() {
    AuthRepository().logout().then((value) {
      UserManager.deleteUser();
      AppRouter.navigatorKey.currentContext?.goNamed(AppRoute.onboarding.name);
    });
  }
}
