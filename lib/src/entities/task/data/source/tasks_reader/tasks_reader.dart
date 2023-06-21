part of 'tasks_reader_interface.dart';

class TasksReader extends VanillaNotifier<List<Task>>
    with FirebaseErrorHandlerMixin
    implements TasksReaderInterface {
  final CollectionReference _tasks;
  final TasksBufferInterface _buffer;

  TasksReader._({
    required String? userId,
    TasksBufferInterface? buffer,
  })  : _tasks = FirebaseFirestore.instance
            .collection(Keys.user)
            .doc(userId ?? UserManager.requireUser.uid)
            .collection(Keys.tasks),
        _buffer = buffer ?? TasksBuffer(),
        super([]);

  static final TasksReader instance = TasksReader._(
    userId: UserManager.requireUser.uid,
  );

  factory TasksReader() => instance;

  @override
  List<Task> get tasks => List.from(state)..sort();

  @override
  Future<List<Task>> fetch({
    bool aFresh = false,
    bool more = true,
  }) =>
      handleError(
        _fetchTasks(fetchAfresh: aFresh, fetchMore: more),
        catcher: (failure) => state,
      );

  Query? _nextQuery;

  Future<List<Task>> _fetchTasks({
    required bool fetchAfresh,
    required bool fetchMore,
  }) async {
    if (fetchAfresh) _nextQuery = null;

    _nextQuery ??= _tasks.orderBy(Keys.createdAt, descending: true);

    final QuerySnapshot snapshot = await _nextQuery!.get();

    if (snapshot.docs.isEmpty) {
      state = [];
      return state;
    }

    _nextQuery = _nextQuery!.startAfterDocument(snapshot.docs.last).limit(25);

    final List<Task> tasks = snapshot.docs
        .map((e) => Task.fromMap((e.data() as Map).cast()))
        .toList();

    if (fetchAfresh) state.clear();

    state = List.from(state)..addAll(tasks);

    await _buffer.addMultiple(tasks);

    return this.tasks;
  }

  @override
  void clearCurrentTasks() {
    state = List.from([]);
    _nextQuery = null;
  }
}
