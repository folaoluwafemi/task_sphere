part of 'search_vanilla.dart';

class SearchState extends VanillaStateWithStatus {
  final List<SearchResult> allResults;
  final List<SearchResult> currentResults;
  final List<String> history;
  final SearchFilter filter;
  final SearchDateFilter? dateFilter;
  final String query;

  const SearchState({
    this.allResults = const [],
    this.currentResults = const [],
    required this.history,
    this.filter = SearchFilter.all,
    this.dateFilter,
    this.query = '',
    bool success = false,
    bool loading = false,
    Failure? error,
  }) : super(
          success: success,
          loading: loading,
          error: error,
        );

  SearchState updateStartDateFilter(DateTime startDate) {
    return copyWith(
      dateFilter: dateFilter == null
          ? SearchDateFilter(startDate: startDate)
          : dateFilter!.copyWith(startDate: startDate),
    );
  }

  SearchState updateEndDateFilter(DateTime endDate) {
    if (dateFilter?.startDate == null) {
      throw Failure(message: 'Date filter or start date must be set');
    }

    return copyWith(dateFilter: dateFilter!.copyWith(endDate: endDate));
  }

  @override
  SearchState copyWith({
    List<SearchResult>? allResults,
    List<SearchResult>? currentResults,
    List<String>? history,
    String? query,
    SearchFilter? filter,
    SearchDateFilter? dateFilter,
    bool? success,
    bool? loading,
    Failure? error,
  }) {
    return SearchState(
      query: query ?? this.query,
      allResults: allResults ?? this.allResults,
      currentResults: currentResults ?? this.currentResults,
      history: history ?? this.history,
      filter: filter ?? this.filter,
      dateFilter: dateFilter ?? this.dateFilter,
      success: success ?? this.success,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        allResults,
        currentResults,
        history,
        filter,
        dateFilter,
        success,
        loading,
        error,
        query,
      ];
}
