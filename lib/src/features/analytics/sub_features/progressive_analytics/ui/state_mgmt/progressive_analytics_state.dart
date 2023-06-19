part of 'progressive_analytics_vanilla.dart';

/// DateTime = day
/// int = productivity point

class ProgressiveAnalysisState extends VanillaStateWithStatus {
  final ProgressiveAnalysis progressiveAnalysis;

  const ProgressiveAnalysisState({
    required this.progressiveAnalysis,
    super.success = false,
    super.loading = false,
    super.error,
  });

  @override
  ProgressiveAnalysisState copyWith({
    ProgressiveAnalysis? progressiveAnalysis,
    bool? success,
    bool? loading,
    Failure? error,
  }) {
    return ProgressiveAnalysisState(
      progressiveAnalysis: progressiveAnalysis ?? this.progressiveAnalysis,
      success: success ?? this.success,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        progressiveAnalysis,
        success,
        loading,
        error,
      ];
}

typedef ProgressiveAnalysis = Map<DateTime, int>;

extension on ProgressiveAnalysis {
  DateTime? maybeKeyWithin(DateTime dateTime) {
    return keys.toList().firstWhereOrNull((key) {
      return key.containsTimeWithinDay(dateTime);
    });
  }
}
