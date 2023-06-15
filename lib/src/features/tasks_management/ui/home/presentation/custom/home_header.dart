part of '../home_screen.dart';

class HomeHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 55.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 18.w),
      color: context.bgColors.$100,
      child: AnimatedSwitcher(
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        duration: const Duration(milliseconds: 500),
        child: shrinkOffset > 0
            ? const Align(
                alignment: Alignment.centerLeft,
                child: TasksFilterWidget(),
              )
            : Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'MOST RECENT TASKS',
                  style: context.primaryTypography.paragraph.small.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    height: 2,
                    letterSpacing: 0.5,
                    color: context.neutralColors.$700,
                  ),
                ),
              ),
      ),
    );
  }

  @override
  double get maxExtent => 55.h;

  @override
  double get minExtent => 55.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    if (oldDelegate is! HomeHeader) return true;
    if (oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent) return true;

    return false;
  }
}
