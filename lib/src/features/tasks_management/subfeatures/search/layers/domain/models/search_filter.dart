import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

enum SearchFilter {
  all,
  tasks,
  todos,
  ;

  List<SearchResult> applyTo(List<SearchResult> results) => switch (this) {
        all => List.from(results),
        tasks => results.where((element) => element.value == null).toList(),
        todos => results.where((element) => element.value != null).toList(),
      }
        ..sort();

  Widget uiTabPill({
    required BuildContext context,
    required bool isActive,
  }) =>
      TabPill.colored(
        text: name.toFirstUpperCase(),
        state: isActive ? TabPillState.active : TabPillState.inactive,
        textStyle: context.secondaryTypography.paragraph.large.asMedium,
        borderRadius: 4.m,
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 5.h,
        ),
      );
}
