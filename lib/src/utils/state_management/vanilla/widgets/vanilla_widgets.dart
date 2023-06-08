import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'vanilla_builder.dart';

part 'vanilla_listener.dart';

typedef VanillaWidgetBuilder<T> = Widget Function(
  BuildContext context,
  T state,
);

typedef VanillaListenerCallback<T> = void Function(
  T? previous,
  T current,
);

typedef VanillaSelectorCallback<T> = bool Function(
  T? previous,
  T current,
);
