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
    return SafeArea(
      top: true,
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              MultiSliver(
                pushPinnedChildren: true,
                children: [
                  // SliverPinnedHeader(
                  //   child: Padding(
                  //     padding: EdgeInsets.only(left: 18.w),
                  //     child: Text(
                  //       'Today',
                  //       style: context.primaryTypography.title.large,
                  //     ),
                  //   ),
                  // ),
                  SliverPinnedHeader(
                    child: Container(
                      padding: EdgeInsets.only(left: 18.w, top: 18.h),
                      color: context.bgColors.$100,
                      child: _TopContents(
                        drawerOffsetNotifier: drawerOffsetNotifier,
                        showDrawer: showDrawer,
                      ),
                    ),
                  ),
                  43.sliverBoxHeight,
                  const SliverToBoxAdapter(
                    child: _ProgressiveAnalyticsWidget(),
                  ),
                  24.sliverBoxHeight,
                  SliverToBoxAdapter(
                    child: Divider(
                      height: 1.h,
                      thickness: 1.h,
                      color: context.neutralColors.$400,
                    ),
                  ),
                ],
              ),
              MultiSliver(
                pushPinnedChildren: true,
                children: [
                  18.sliverBoxHeight,
                  SliverPersistentHeader(
                    floating: false,
                    pinned: true,
                    delegate: MyHeader(),
                  ),

                  // SliverPinnedHeader(
                  //   child: Padding(
                  //     padding: EdgeInsets.only(left: 18.w),
                  //     child: Text(
                  //       'Today',
                  //       style: context.primaryTypography.title.large,
                  //     ),
                  //   ),
                  // ),
                  16.sliverBoxHeight,
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    sliver: SliverList.separated(
                      itemCount: FakeData.tasks.length,
                      separatorBuilder: (_, __) => 16.boxHeight,
                      itemBuilder: (_, index) => TaskCard(
                        task: FakeData.tasks[index],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(bottom: 24.h, right: 24.w),
            child: AddTaskFloatingButton(
              drawerOffsetNotifier: drawerOffsetNotifier,
            ),
          ),
        ],
      ),
    );
  }
}

class MyHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    print('double shrink offset: $shrinkOffset');
    print('overlaps content: $overlapsContent');
    final bool showOptions = shrinkOffset > 0;

    return Container(
      height: 45.h,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 18.w),
      child: showOptions
          ? const TasksFilterWidget()
          : Text(
              'MOST RECENT TASKS',
              style: context.primaryTypography.paragraph.small.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 10.sp,
                height: 2,
                letterSpacing: 0.5,
                color: context.neutralColors.$700,
              ),
            ),
    );
  }

  @override
  double get maxExtent => 40.h;

  @override
  double get minExtent => 20.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    if (oldDelegate is! MyHeader) return true;
    if (oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent) return true;

    return false;
  }
}
