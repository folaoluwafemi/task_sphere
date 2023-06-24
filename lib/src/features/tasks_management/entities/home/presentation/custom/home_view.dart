part of '../home_screen.dart';

class _HomeView extends StatefulWidget {
  final VoidCallback showDrawer;
  final ValueNotifier<double> drawerOffsetNotifier;

  const _HomeView({
    Key? key,
    required this.showDrawer,
    required this.drawerOffsetNotifier,
  }) : super(key: key);

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  Future<void> onTaskCardPressed(Task task) async {
    await context.pushNamed(AppRoute.task.name, extra: task);

    if (!mounted) return;
    context.read<HomeVanilla>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Stack(
        children: [
          RefreshIndicator(
            color: context.palette.primary,
            onRefresh: () async {
              await context.read<ProgressiveAnalyticsVanilla>().refresh();
              if (!mounted) return;
              await context.read<HomeVanilla>().refresh();
            },
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                VanillaBuilder<HomeVanilla, HomeState>(
                  buildWhen: (previous, current) =>
                      previous?.filter != current.filter,
                  builder: (context, state) {
                    if (state.filter != TasksFilter.all) {
                      return const SliverToBoxAdapter();
                    }
                    return MultiSliver(
                      pushPinnedChildren: true,
                      children: [
                        SliverPinnedHeader(
                          child: Container(
                            padding: EdgeInsets.only(
                              left: 18.w,
                              top: 18.h,
                              bottom: 0.h,
                            ),
                            color: context.bgColors.$100,
                            child: _TopContents(
                              drawerOffsetNotifier: widget.drawerOffsetNotifier,
                              showDrawer: widget.showDrawer,
                            ),
                          ),
                        ),
                        41.sliverBoxHeight,
                        const SliverToBoxAdapter(
                          child: ProgressiveAnalyticsWidget(),
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
                    );
                  },
                ),
                VanillaBuilder<HomeVanilla, HomeState>(
                  buildWhen: (previous, current) =>
                      previous?.currentTasks != current.currentTasks ||
                      previous?.currentTasks.length !=
                          current.currentTasks.length ||
                      previous?.loading != current.loading,
                  builder: (context, state) {
                    if (state.allTasks.isEmpty && state.loading) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(top: 200.h),
                          child: Center(
                            child: LoaderWidget(
                              color: context.palette.primary,
                            ),
                          ),
                        ),
                      );
                    }

                    if (state.allTasks.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: EmptyTasksWidget(),
                      );
                    }

                    return MultiSliver(
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
                                sliver: SliverInfiniteList(
                                  loadingBuilder: (context) => Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 30.h,
                                        bottom: 130.h,
                                      ),
                                      child: LoaderWidget(
                                        color: context.palette.primary,
                                      ),
                                    ),
                                  ),
                                  isLoading: state.loading,
                                  onFetchData: () {
                                    context.read<HomeVanilla>().fetchTasks();
                                  },
                                  itemCount: state.currentTasks.length,
                                  hasReachedMax: state.hasReachedLimit,
                                  separatorBuilder: (_, __) => 16.boxHeight,
                                  itemBuilder: (_, index) => GestureDetector(
                                    onTap: () => onTaskCardPressed(
                                      state.currentTasks[index],
                                    ),
                                    child: TaskCard(
                                      task: state.currentTasks[index],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                150.sliverBoxHeight,
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(bottom: 24.h, right: 24.w),
            child: AddTaskFloatingButton(
              drawerOffsetNotifier: widget.drawerOffsetNotifier,
            ),
          ),
        ],
      ),
    );
  }
}
