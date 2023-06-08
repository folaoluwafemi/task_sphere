import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'ioc/vanilla_holder.dart';

part 'utils/extension.dart';

abstract class VanillaNotifier<State> extends ValueNotifier<State> {
  VanillaNotifier(super.value) {
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
    if (value == state) return;
    value = state;
  }

  @override
  void dispose() {
    removeListener(_streamListener);
    _streamController.close();
    super.dispose();
  }
}
