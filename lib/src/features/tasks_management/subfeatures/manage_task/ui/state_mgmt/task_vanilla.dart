import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'task_state.dart';

class TaskVanilla extends VanillaNotifier<TaskState>
    with BasicErrorHandlerMixin, VanillaUtilsMixin {
  final TasksRepoInterface _repo;

  TaskVanilla({
    required Task? task,
    TasksRepoInterface? repo,
  })  : _repo = repo ?? TasksRepository(),
        super(TaskState(task: task));

  Future<void> initialize() => handleError(_initialize());

  Future<void> _initialize() async {
    if (state.isNew) return;
    await save();
    await _reFetch();
  }

  Future<void> createNewTask() => handleError(
        _createNewTask(),
        catcher: notifyOnError,
      );

  Future<void> _createNewTask() async {
    if (!state.isNew) return;
    notifyLoading();
    await _repo.createTask(state.task);
    notifySuccess();
  }

  Future<void> updateTitle(String title) => handleError(
        _updateTitle(title),
        catcher: notifyOnError,
      );

  Future<void> _updateTitle(String title) async {
    await _createNewTask();
    if (state.task.title == title) return;
    state = state.copyWith(task: state.task.copyWith(title: title));
    await _save();
  }

  Future<void> updateDescription(String description) => handleError(
        _updateDescription(description),
        catcher: notifyOnError,
      );

  Future<void> _updateDescription(String description) async {
    await _createNewTask();
    if (state.task.description == description) return;
    state = state.copyWith(task: state.task.copyWith(description: description));
    await _save();
  }

  Future<void> addTodo(Todo todo) => handleError(
        _addTodo(todo),
        catcher: notifyOnError,
      );

  Future<void> _addTodo(Todo todo) async {
    await _createNewTask();
    state = state.copyWith(
      task: state.task.copyWith(
        todos: [...state.task.todos, todo],
      ),
    );
    await _save();
  }

  Future<void> updateTodo(Todo todo) => handleError(
        _updateTodo(todo),
        catcher: notifyOnError,
      );

  Future<void> _updateTodo(Todo todo) async {
    notifyLoading();

    final List<Todo> todos = state.task.todos.copy;

    todos.replaceWhere([todo], (element) => element.id == todo.id);

    await _repo.updateTodos(todos, taskId: state.task.id);
    await _reFetch();
  }

  Future<void> updateTodos(List<Todo> todos) => handleError(
        _updateTodos(todos),
        catcher: notifyOnError,
      );

  Future<void> _updateTodos(List<Todo> todos) async {
    state = state.copyWith(
      task: state.task.copyWith(
        todos: List.from(todos),
      ),
    );
    await _save();
  }

  Future<bool> deleteEmptyTask() => handleError(
        _deleteEmptyTask(),
        catcher: (failure) {
          notifyOnError(failure);
          return true;
        },
      );

  Future<bool> _deleteEmptyTask() async {
    if (!state.task.isEmpty) return false;
    notifyLoading();

    await Future.delayed(const Duration(seconds: 2));

    await _repo.deleteTask(state.task.id);

    notifySuccess();
    return true;
  }

  Future<void> save() => handleError(_save(), catcher: notifyOnError);

  Future<void> _save() async {
    notifyLoading();

    await Future.delayed(const Duration(seconds: 2));

    await _repo.updateTask(state.task);

    notifySuccess();
  }

  Future<void> reFetch() => handleError(_reFetch(), catcher: notifyOnError);

  Future<void> _reFetch() async {
    notifyLoading();

    final List<Todo> todos = await _repo.readTodos(taskId: state.task.id);
    todos.sort();

    notifySuccess(
      state: state.copyWith(task: state.task.copyWith(todos: todos)),
    );
  }
}
