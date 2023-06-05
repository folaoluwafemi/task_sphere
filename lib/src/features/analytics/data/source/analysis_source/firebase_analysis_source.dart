part of 'analysis_source_interface.dart';

class FirebaseAnalysisSource
    with FirebaseErrorHandlerMixin
    implements AnalysisSourceInterface {
  final CollectionReference _analysisCollection;

  FirebaseAnalysisSource({
    String? userId,
  }) : _analysisCollection = FirebaseFirestore.instance
            .collection(Keys.users)
            .doc(userId ?? UserManager.requireUser.uid)
            .collection(Keys.tasks);

  @override
  Future<void> createUserAnalyticsBucket(String userId) => handleError(
        _createUserAnalyticsBucket(userId),
      );

  Future<void> _createUserAnalyticsBucket(String userId) async {
    final Analytics analysis = Analytics(
      type: AnalyticsDataType.task,
    );
    FirebaseFirestore.instance
        .collection(Keys.users)
        .doc(UserManager.requireUser.uid)
        .collection(Keys.analysis).doc();
  }

  @override
  Future<Analysis> fetchAnalysis(Analysis analysis) => handleError(
        _fetchAnalysis(analysis),
      );

  Future<Analysis> _fetchAnalysis(Analysis analysis) async {
    // TODO: implement fetchAnalysis
    throw UnimplementedError();
  }

  @override
  Future<void> uploadAnalysis(Analysis analysis) => handleError(
        _uploadAnalysis(analysis),
      );

  Future<void> _uploadAnalysis(Analysis analysis) async {
    // TODO: implement uploadAnalysis
    throw UnimplementedError();
  }
}
