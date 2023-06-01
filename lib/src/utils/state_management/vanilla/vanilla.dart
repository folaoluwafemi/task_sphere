import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';
import 'package:task_sphere/src/utils/state_management/state_management_utils.dart'
    show VanillaState;

part 'ioc/vanilla_holder.dart';

part 'utils/extension.dart';

abstract class VanillaNotifier<State>
    extends ValueNotifier<State> {
  VanillaNotifier(super.value) {
    _streamController.addStream(Stream.value(value));
    addListener(_streamListener);
  }

  void _streamListener() {
    _streamController.add(value);
  }

  Stream<State> get stream => _streamController.stream;

  final StreamController<State> _streamController = StreamController<State>();

  bool get isDisposed => _streamController.isClosed;

  State get state => value;

  set state(State state) {
    value = state;
  }

  @override
  void dispose() {
    removeListener(_streamListener);
    _streamController.close();
    super.dispose();
  }
}
