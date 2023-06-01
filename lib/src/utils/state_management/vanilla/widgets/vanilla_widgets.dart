import 'package:flutter/material.dart';
import 'package:task_sphere/src/utils/extensions/extensions.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'vanilla_builder.dart';

part 'vanilla_listener.dart';

typedef VanillaWidgetBuilder<T extends VanillaState> = Widget Function(
  BuildContext context,
  T state,
);

typedef VanillaListenerCallback<T extends VanillaState> = void Function(
  T? previous,
  T current,
);

typedef VanillaSelectorCallback<T extends VanillaState> = bool Function(
  T? previous,
  T current,
);
