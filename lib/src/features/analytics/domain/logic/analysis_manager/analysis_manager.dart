import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/features/analytics/data/analytics_data_barrel.dart';
import 'package:task_sphere/src/features/analytics/domain/analytics_domain_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class AnalysisManager extends VanillaNotifier<Analysis>
    with BasicErrorHandlerMixin {
  final AnalysisSourceInterface _analyticsSource;
  final AnalyticsLocalBufferInterface _analyticsLocalBuffer;

  AnalysisManager._({
    required AnalysisSourceInterface analyticsSource,
    required AnalyticsLocalBufferInterface analyticsLocalBuffer,
  })  : _analyticsSource = analyticsSource,
        _analyticsLocalBuffer = analyticsLocalBuffer,
        super(analyticsLocalBuffer.getAnalysis());

  static final AnalysisManager instance = AnalysisManager._(
    analyticsSource: FirebaseAnalysisSource(),
    analyticsLocalBuffer: AnalysisLocalBuffer(),
  );

  factory AnalysisManager.default_() => instance;

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

    //
    // // print('')
    //
    //
    // debugPrint(
    //   '''
    //   buffer: ${buffer.whereType<TaskAnalytics>().toList().map((e) {
    //     return e
    //         .toMap()
    //         .entries
    //         .map((entry) => '\nkeytype: ${entry.key.runtimeType} | valueType: ${entry.value.runtimeType}\n');
    //   })}
    //
    //   ''',
    // );

    await clear();
  }

  Future<void> clear() async {
    await _analyticsLocalBuffer.clearBuffer();
    state = [];

    print('buffer cleared');
  }
}
