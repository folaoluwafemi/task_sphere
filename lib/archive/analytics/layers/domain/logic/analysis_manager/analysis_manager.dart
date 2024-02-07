import 'package:task_sphere/archive/analytics/layers/data/analytics_data_barrel.dart';
import 'package:task_sphere/archive/analytics/layers/domain/analytics_domain_barrel.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

class AnalysisManager extends VanillaNotifier<Analysis>
    with BasicErrorHandlerMixin {
  final AnalyticsLocalBufferInterface _analyticsLocalBuffer;

  AnalysisManager._({
    required AnalysisSourceInterface analyticsSource,
    required AnalyticsLocalBufferInterface analyticsLocalBuffer,
  })  : _analyticsLocalBuffer = analyticsLocalBuffer,
        super(analyticsLocalBuffer.getAnalysis());

  static AnalysisManager _instance = AnalysisManager._(
    analyticsSource: FirebaseAnalysisSource(),
    analyticsLocalBuffer: AnalysisLocalBuffer(),
  );

  static void _reinitialize() {
    _instance = AnalysisManager._(
      analyticsSource: FirebaseAnalysisSource(),
      analyticsLocalBuffer: AnalysisLocalBuffer(),
    );
  }

  Future<void> addAnalytics(Analytics analytics) => handleError(
        _addAnalytics(analytics),
      );

  Future<void> _addAnalytics(Analytics analytics) async {
    final List<Analytics> currentAnalysis = state.copy;

    final List<Analytics> newAnalysis = [...currentAnalysis, analytics];

    await _analyticsLocalBuffer.saveAnalysis(newAnalysis);

    state = newAnalysis;
  }

  Future<void> flushBuffer() => handleError(
        _flushBuffer(),
        catcher: (failure) {
          Future.delayed(const Duration(seconds: 2), () {
            if (AppRouter.navigatorKey.currentContext != null) {
              AlertType.error.show(
                AppRouter.navigatorKey.currentContext!,
                text: 'An error occurred uploading your analytics!!',
              );
            }
          });
        },
      );

  Future<void> _flushBuffer() async {
    final List<Analytics> buffer = _analyticsLocalBuffer.getAnalysis();
    if (buffer.isEmpty) return;

    // await _analyticsSource.uploadAnalysis(buffer);

    await clear();
  }

  Future<void> clear() async {
    await _analyticsLocalBuffer.clearBuffer();
    state = [];
  }
}
