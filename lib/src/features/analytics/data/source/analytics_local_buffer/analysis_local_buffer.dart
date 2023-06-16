part of 'analysis_local_buffer_interface.dart';

class AnalysisLocalBuffer
    with BasicErrorHandlerMixin
    implements AnalyticsLocalBufferInterface {
  final Box<List> _box;

  AnalysisLocalBuffer._({
    Box<List>? box,
  }) : _box = box ?? Hive.box<List>(StorageKeys.analysis.box);

  AnalysisLocalBuffer.new_({
    Box<List>? box,
  }) : _box = Hive.box(StorageKeys.analysis.box) {
    _instance = this;
  }

  static AnalysisLocalBuffer _instance = AnalysisLocalBuffer._();

  factory AnalysisLocalBuffer() => _instance;

  @override
  Future<void> clearBuffer() => handleError(_clearBuffer());

  Future<void> _clearBuffer() async {
    await _box.clear();
  }

  @override
  Analysis getAnalysis() => handleSyncError(_getAnalysis());

  Analysis _getAnalysis() {
    final List<Map>? analysis =
        _box.get(StorageKeys.analysis.key)?.cast<Map>().toList();

    if (analysis == null) return Analysis.empty(growable: true);

    return AnalysisUtils.fromSerializerList(analysis.cast());
  }

  @override
  Future<void> push(Analytics analytics) => handleError(
        _pushAnalytics(analytics),
      );

  Future<void> _pushAnalytics(Analytics analytics) async {
    final List<Analytics> currentAnalysis = getAnalysis().copy;

    final List<Analytics> newAnalysis = [...currentAnalysis, analytics];

    await saveAnalysis(newAnalysis);
  }

  @override
  Future<void> saveAnalysis(Analysis analysis) => handleError(
        _saveAnalysis(analysis),
      );

  Future<void> _saveAnalysis(Analysis analysis) async {
    await _box.clear();

    await _box.put(StorageKeys.analysis.key, analysis.toSerializerList());
  }
}
