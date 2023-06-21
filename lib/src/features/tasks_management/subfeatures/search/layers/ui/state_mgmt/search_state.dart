part of 'search_vanilla.dart';

enum SearchFilter {
  all,
  tasks,
  todos,
  ;
}

class SearchState extends VanillaStateWithStatus {
  final List<SearchResult> allResults;
  final List<SearchResult> currentResults;
  final List<String> history;
  final SearchFilter filter;
  final SearchDateFilter? dateFilter;

  const SearchState({
    this.allResults = const [],
    this.currentResults = const [],
    this.history = const [],
    this.filter = SearchFilter.all,
    this.dateFilter,
    bool success = false,
    bool loading = false,
    Failure? error,
  }) : super(
          success: success,
          loading: loading,
          error: error,
        );

  @override
  SearchState copyWith({
    List<SearchResult>? allResults,
    List<SearchResult>? currentResults,
    List<String>? history,
    SearchFilter? filter,
    SearchDateFilter? dateFilter,
    bool? success,
    bool? loading,
    Failure? error,
  }) {
    return SearchState(
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
      ];
}

class SearchDateFilter {
  final DateTime startDate;
  final DateTime? endDate;

  const SearchDateFilter({
    required this.startDate,
    this.endDate,
  });
}

class SearchResult {
  final Task task;
  final Todo? value;

  const SearchResult({
    required this.task,
    this.value,
  });
}
