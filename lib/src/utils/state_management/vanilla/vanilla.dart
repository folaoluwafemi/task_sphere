import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:task_sphere/src/utils/state_management/state_managment_utils.dart';

abstract class VanillaNotifier<State extends VanillaState>
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

  @override
  void dispose() {
    removeListener(_streamListener);
    _streamController.close();
    super.dispose();
  }
}
