part of 'analysis_source_interface.dart';

class FirebaseAnalysisSource
    with FirebaseErrorHandlerMixin, FirebaseSerializerUtils
    implements AnalysisSourceInterface {
  final CollectionReference _analysisCollection;

  FirebaseAnalysisSource({
    String? userId,
  }) : _analysisCollection = FirebaseFirestore.instance
            .collection(Keys.user)
            .doc(userId ?? UserManager().requireUser.uid)
            .collection(Keys.analysis);

  @override
  Future<void> createUserAnalyticsBucket(String userId) => handleError(
        _createUserAnalyticsBucket(userId),
      );

  Future<void> _createUserAnalyticsBucket(String userId) async {
    final Analytics analysis = UserAnalytics.create(
      action: AnalyticsAction.create,
      userId: userId,
    );
    await _analysisCollection.doc(analysis.id).set(analysis.toMap());
  }

  @override
  Future<Analysis> fetchAnalysis(Analysis analysis) => handleError(
        _fetchAnalysis(analysis),
      );

  Future<Analysis> _fetchAnalysis(Analysis analysis) async {
    final QuerySnapshot snapshot = await _analysisCollection.get();

    return listFromQuerySnapshot<Analytics>(snapshot, Analytics.fromMap);
  }

  @override
  Future<void> uploadAnalysis(Analysis analysis) => handleError(
        _uploadAnalysis(analysis),
      );

  Future<void> _uploadAnalysis(Analysis analysis) async {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (int i = 0; i < analysis.length; i++) {
      if (i % 300 == 0) {
        await batch.commit();
        batch = FirebaseFirestore.instance.batch();
      }

      final Analytics analytics = analysis[i];
      if (analytics is TodoAnalytics) continue;
      batch.set(
        _analysisCollection.doc(analytics.id),
        analytics.toMap(),
      );
    }

    await batch.commit();
  }
}
