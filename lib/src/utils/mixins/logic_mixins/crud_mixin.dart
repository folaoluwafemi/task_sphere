import 'package:vanilla_state/vanilla_state.dart';

mixin VanillaCrudMixin<State> on VanillaNotifier<State?> {
  State? get readData => state;

  void createData(State data) {
    state = data;
  }

  void deleteData() {
    state = null;
  }
}
