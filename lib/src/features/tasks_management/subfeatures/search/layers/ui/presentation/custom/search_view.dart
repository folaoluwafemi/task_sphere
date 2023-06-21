part of '../search_screen.dart';

class _SearchView extends StatefulWidget {
  const _SearchView({Key? key}) : super(key: key);

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopContents(
          searchController: searchController,
          focusNode: searchFocusNode,
        ),
        ListenableBuilder(
          listenable: Listenable.merge([
            searchController,
            searchFocusNode,
          ]),
          builder: (_, __) {
            final bool hasFocus = searchFocusNode.hasFocus;
            final bool isEmpty = searchController.text.isEmpty;
            // if (hasFocus && !isEmpty) {
            return _HistoryView(controller: searchController);
            // }
            // return const _ResultsView();
          },
        ),
      ],
    );
  }
}

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
    widget.searchController.clear();
  }

  void onSubmitted(String _) {
    onSearchPressed();
  }

  void onBackPressed() {
    if (widget.focusNode.hasFocus) {
      context.read<SearchVanilla>().clearQuery();
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
          GestureDetector(
            onTap: onBackPressed,
            child: SvgDecorator.square(
              dimension: 24.l,
              color: context.neutralColors.$700,
              child: SvgPicture.asset(VectorAssets.arrowLeft),
            ),
          ),
          24.boxWidth,
          Expanded(
            child: TextField(
              // autofocus: true,
              controller: widget.searchController,
              focusNode: widget.focusNode,
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
            listenable:
                Listenable.merge([widget.searchController, widget.focusNode]),
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
