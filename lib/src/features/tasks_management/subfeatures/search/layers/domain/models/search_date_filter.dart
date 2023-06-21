class SearchDateFilter {
  final DateTime startDate;
  final DateTime? endDate;

  const SearchDateFilter({
    required this.startDate,
    this.endDate,
  });

  SearchDateFilter copyWith({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return SearchDateFilter(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
