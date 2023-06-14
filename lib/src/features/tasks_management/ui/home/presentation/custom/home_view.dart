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
                  SliverToBoxAdapter(
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
                    delegate: HomeHeader(),
                  ),
                  SliverClip(
                    child: MultiSliver(
                      children: [
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

