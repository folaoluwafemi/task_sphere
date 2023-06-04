import 'package:task_sphere/src/features/analytics/data/analytics_data_barrel.dart';
import 'package:task_sphere/src/features/analytics/domain/analytics_domain_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class AnalysisManager extends VanillaNotifier<Analysis>
    with BasicErrorHandlerMixin {
  final AnalyticsSourceInterface _analyticsSource;
  final AnalyticsLocalBufferInterface _analyticsLocalBuffer;

  AnalysisManager({
    required AnalyticsSourceInterface analyticsSource,
    required AnalyticsLocalBufferInterface analyticsLocalBuffer,
  })  : _analyticsSource = analyticsSource,
        _analyticsLocalBuffer = analyticsLocalBuffer,
        super(analyticsLocalBuffer.getAnalysis());

  Future<void> addAnalytics(Analytics analytics) => handleError(
        _addAnalytics(analytics),
      );

  Future<void> _addAnalytics(Analytics analytics) async {
    final List<Analytics> currentAnalysis = state.copy;

    final List<Analytics> newAnalysis = [...currentAnalysis, analytics];

    await _analyticsLocalBuffer.saveAnalysis(newAnalysis);

    state = newAnalysis;
  }

  Future<void> flushBuffer() => handleError(_flushBuffer());

  Future<void> _flushBuffer() async {
    final List<Analytics> buffer = _analyticsLocalBuffer.getAnalysis();

    await _analyticsSource.uploadAnalysis(buffer);

    await clear();
  }

  Future<void> clear() async {
    await _analyticsLocalBuffer.clearBuffer();
    state = [];
  }
}