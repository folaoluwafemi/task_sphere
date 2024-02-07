import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

part 'date_filter_widget.dart';

part 'empty_results_view.dart';

part 'filter_tabs.dart';

part 'loader_parent.dart';

class ResultsView extends StatelessWidget {
  final bool canChooseToShowFilter;

  const ResultsView({
    Key? key,
    required this.canChooseToShowFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VanillaBuilder<SearchVanilla, SearchState>(
      builder: (context, state) {
        return LoaderParent(
          shouldLoad: state.loading,
          child: CustomScrollView(
            slivers: [
              8.sliverBoxHeight,
              SliverPinnedHeader(
                child: !canChooseToShowFilter
                    ? 30.boxHeight
                    : state.dateFilter != null
                        ? _DateFilterWidget(filter: state.dateFilter!)
                        : _FilterTabs(currentFilter: state.filter),
              ),
              32.sliverBoxHeight,
              state.currentResults.isEmpty
                  ? const SliverToBoxAdapter(child: _EmptyResultsView())
                  : SliverPadding(
                      padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 150.h),
                      sliver: SliverList.separated(
                        itemCount: state.currentResults.length,
                        separatorBuilder: (context, index) => 16.boxHeight,
                        itemBuilder: (context, index) {
                          final SearchResult result =
                              state.currentResults[index];
                          return GestureDetector(
                            onTap: () => context.pushNamed(
                              AppRoute.task.name,
                              extra: result.task,
                            ),
                            child: result.isTask
                                ? TaskCard(task: result.task)
                                : TodoItemWidget(todo: result.value!),
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
