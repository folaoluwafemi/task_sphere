part of '../search_screen.dart';

class _TopContents extends StatefulWidget {
  final TextEditingController searchController;
  final FocusNode focusNode;

  const _TopContents({
    Key? key,
    required this.searchController,
    required this.focusNode,
  }) : super(key: key);

  @override
  State<_TopContents> createState() => _TopContentsState();
}

class _TopContentsState extends State<_TopContents> {
  void onClosePressed() {
    widget.searchController.clear();
    widget.focusNode.unfocus();
    context.read<SearchVanilla>().clearQuery();
  }

  void onSearchPressed() {
    widget.focusNode.unfocus();
    final String query = widget.searchController.text.trim();
    context.read<SearchVanilla>().searchFor(query);
  }

  void onSubmitted(String _) {
    onSearchPressed();
  }

  void onBackPressed(BuildContext context) {
    final SearchVanilla vanilla = context.read<SearchVanilla>();

    if (widget.focusNode.hasFocus || vanilla.state.hasActiveFilter) {
      vanilla.clearQuery();
      vanilla.clearFilters();
      return widget.focusNode.unfocus();
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.bgColors.$50,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
      child: Row(
        children: [
          Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () => onBackPressed(context),
                child: SvgDecorator.square(
                  dimension: 24.l,
                  color: context.neutralColors.$700,
                  child: SvgPicture.asset(VectorAssets.arrowLeft),
                ),
              );
            },
          ),
          24.boxWidth,
          Expanded(
            child: TextField(
              autofocus: true,
              controller: widget.searchController,
              focusNode: widget.focusNode,
              textInputAction: TextInputAction.search,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Search for task, todo e.t.c',
                hintStyle: context.secondaryTypography.paragraph.large.asRegular
                    .withColor(context.neutralColors.$600),
                border: InputBorder.none,
              ),
            ),
          ),
          24.boxWidth,
          ListenableBuilder(
            listenable: Listenable.merge([
              widget.searchController,
              widget.focusNode,
            ]),
            builder: (context, child) {
              final bool hasFocus = widget.focusNode.hasFocus;
              final bool isEmpty = widget.searchController.text.isEmpty;
              if (hasFocus && !isEmpty) {
                return InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: onSearchPressed,
                  child: SvgDecorator.square(
                    dimension: 24.l,
                    color: context.neutralColors.$800,
                    child: SvgPicture.asset(VectorAssets.search),
                  ),
                );
              }
              if (!hasFocus && !isEmpty) {
                return InkWell(
                  borderRadius: BorderRadius.circular(12.r),
                  onTap: onClosePressed,
                  child: SvgDecorator.square(
                    dimension: 24.l,
                    color: context.neutralColors.$800,
                    child: SvgPicture.asset(VectorAssets.cancelFilled),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
