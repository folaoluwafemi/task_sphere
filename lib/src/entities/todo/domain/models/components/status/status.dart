import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'status_widget.dart';

enum Status {
  todo(1, 'Todo', 'To-do', VectorAssets.todo),
  done(2, 'Done', 'Completed', VectorAssets.done),
  canceled(-1, 'Canceled', 'Canceled', VectorAssets.canceled),
  ;

  final String text, styledText, vectorAsset;
  final int multiplier;

  const Status(this.multiplier, this.text, this.styledText, this.vectorAsset);

  Widget get widget => _StatusWidget(status: this);

  factory Status.fromName(String name) {
    name = name.cleanLower;
    return switch (name) {
      'todo' => todo,
      'done' => done,
      'canceled' => canceled,
      _ => throw UnsupportedError('$name is not supported'),
    };
  }
}
