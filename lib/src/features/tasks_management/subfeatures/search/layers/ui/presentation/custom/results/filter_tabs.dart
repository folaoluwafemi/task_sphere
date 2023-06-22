part of 'results_view.dart';

class _FilterTabs extends StatelessWidget {
  final SearchFilter currentFilter;

  const _FilterTabs({
    Key? key,
    required this.currentFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.w, 8.h, 18.w, 0),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 4.h,
        children: SearchFilter.values.map(
          (tabFilter) {
            return GestureDetector(
              onTap: () => context.read<SearchVanilla>().changeSearchFilterTo(
                    tabFilter,
                  ),
              child: tabFilter.uiTabPill(
                context: context,
                isActive: tabFilter == currentFilter,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
