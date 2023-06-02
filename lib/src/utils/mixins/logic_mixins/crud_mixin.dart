import 'package:task_sphere/src/utils/state_management/state_management_utils.dart';

mixin VanillaCrudMixin<State> on VanillaNotifier<State?> {
  State? get readData => state;

  void createData(State data) {
    state = data;
  }

  void deleteData() {
    state = null;
  }
}
