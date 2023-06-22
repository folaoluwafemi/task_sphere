part of '../search_screen.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(focusNodeListener);
    searchController.addListener(textControllerListener);
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  bool wasFocused = false;

  void textControllerListener() {
    context.read<SearchVanilla>().searchQuick(searchController.text.trim());
  }

  void focusNodeListener() {
    if (wasFocused && !searchFocusNode.hasFocus) {
      context.read<SearchVanilla>().maybeSearch(searchController.text.trim());
    }
    wasFocused = searchFocusNode.hasFocus;
  }

  void onDateFilterSet(SearchDateFilter dateFilter) {
    context.read<SearchVanilla>().changeDateFilter(dateFilter);
  }

  void showDateFilterPicker() {
    searchFocusNode.unfocus();
    showDialog(
      context: context,
      builder: (_) => DateFilterDialog(
        onDateFilterSet: onDateFilterSet,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopContents(
          searchController: searchController,
          focusNode: searchFocusNode,
        ),
        Expanded(
          child: ListenableBuilder(
            listenable: Listenable.merge([
              searchController,
              searchFocusNode,
            ]),
            builder: (_, __) {
              final bool hasFocus = searchFocusNode.hasFocus;
              final bool isEmpty = searchController.text.isEmpty;
              return Stack(
                children: [
                  hasFocus && isEmpty
                      ? HistoryView(controller: searchController)
                      : ResultsView(canChooseToShowFilter: !hasFocus),
                  if (hasFocus)
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 7.h, right: 8.h),
                        child: _SearchByDateButton(
                          onPressed: showDateFilterPicker,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
