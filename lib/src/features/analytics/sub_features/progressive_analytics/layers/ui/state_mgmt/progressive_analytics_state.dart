part of 'progressive_analytics_vanilla.dart';

class ProgressiveAnalysisState extends VanillaStateWithStatus {
  final List<ProductivitySnapshot> historySnapshots;

  const ProgressiveAnalysisState({
    required this.historySnapshots,
    super.success = false,
    super.loading = false,
    super.error,
  });

  @override
  ProgressiveAnalysisState copyWith({
    List<ProductivitySnapshot>? historySnapshots,
    bool? success,
    bool? loading,
    Failure? error,
  }) {
    return ProgressiveAnalysisState(
      historySnapshots: historySnapshots ?? this.historySnapshots,
      success: success ?? this.success,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        historySnapshots,
        success,
        loading,
        error,
      ];
}
