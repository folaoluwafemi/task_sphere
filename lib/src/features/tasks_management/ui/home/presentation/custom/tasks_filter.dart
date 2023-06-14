part of '../home_screen.dart';

class TasksFilterWidget extends StatelessWidget {
  const TasksFilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VanillaBuilder<HomeVanilla, HomeState>(
      builder: (context, state) {
        final TasksFilter current = state.filter;
        return Container(
          color: context.bgColors.$100,
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
          child: Wrap(
            spacing: 12.w,
            runSpacing: 8.h,
            children: [
              ...TasksFilter.values.map(
                (filter) => TabPill.monochrome(
                  onPressed: () {
                    context.read<HomeVanilla>().setFilter(filter);
                  },
                  text: '${filter.name.toUpperCase()}'
                      ' (${filter.count(state.allTasks)})',
                  state: filter == current
                      ? TabPillState.selected
                      : TabPillState.unselected,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
