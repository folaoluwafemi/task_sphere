import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';

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

  bool get isWithinProperLimit {
    if (endDate == null) {
      return true;
    }
    return startDate.isBefore(endDate!);
  }

  List<SearchResult> applyFilterTo(List<SearchResult> results) {
    if (endDate == null) {
      return results.where((result) {
        return result.createdAt.isAfter(startDate);
      }).toList();
    }

    return results.where((result) {
      return result.createdAt.isAfter(startDate) &&
          result.createdAt.isBefore(endDate!);
    }).toList();
  }
}
