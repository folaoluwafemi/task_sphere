import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'button_section.dart';

part 'date_picker_section.dart';

part 'date_selection_prompt_section.dart';

part 'modal_stepper_section.dart';

class DateFilterDialog extends StatefulWidget {
  final ValueChanged<SearchDateFilter> onDateFilterSet;

  const DateFilterDialog({
    Key? key,
    required this.onDateFilterSet,
  }) : super(key: key);

  @override
  State<DateFilterDialog> createState() => _DateFilterDialogState();
}

enum _DateFilterType {
  start,
  end,
}

class _DateFilterDialogState extends State<DateFilterDialog> {
  final ValueNotifier<SearchDateFilter?> dateFilterNotifier =
      ValueNotifier(null);
  final ValueNotifier<_DateFilterType?> selectingType = ValueNotifier(null);

  @override
  void dispose() {
    dateFilterNotifier.dispose();
    selectingType.dispose();
    super.dispose();
  }

  void applyFilter() {
    if (dateFilterNotifier.value == null) {
      return Navigator.of(context).pop();
    }

    final SearchDateFilter filter = dateFilterNotifier.value!;
    if (!filter.isWithinProperLimit) {
      AlertType.info.show(context, text: 'Start date must be before end date');
      return;
    }

    widget.onDateFilterSet(filter);
    Navigator.of(context).pop();
  }

  void onStartDatePressed() {
    selectingType.value = _DateFilterType.start;
  }

  void onDateChanged(DateTime change, _DateFilterType type) {
    currentDate = change;
    dateFilterNotifier.value = SearchDateFilter(
      startDate: (type == _DateFilterType.start
          ? change
          : dateFilterNotifier.value?.startDate)!,
      endDate: (type == _DateFilterType.end
          ? change
          : dateFilterNotifier.value?.endDate),
    );
  }

  DateTime? currentDate;

  void onAcceptChangesPressed() {
    if (dateFilterNotifier.value == null) {
      selectingType.value = null;
      return;
    }
    final SearchDateFilter filter = dateFilterNotifier.value!;
    if (!filter.isWithinProperLimit) {
      AlertType.info.show(context, text: 'Start date must be before end date');
      return;
    }
    selectingType.value = null;
  }

  void onEndDatePressed() {
    selectingType.value = _DateFilterType.end;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Dialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
          child: ListenableBuilder(
            listenable: Listenable.merge([
              dateFilterNotifier,
              selectingType,
            ]),
            builder: (context, child) {
              final _DateFilterType? type = selectingType.value;
              final SearchDateFilter? filter = dateFilterNotifier.value;
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _DateSelectionPromptSection(
                    filter: filter,
                    type: type,
                    onStartDatePressed: onStartDatePressed,
                    onEndDatePressed: onEndDatePressed,
                  ),
                  Builder(
                    builder: (context) {
                      if (type != null) {
                        return _DatePickerSection(
                          maxDate: type == _DateFilterType.start
                              ? filter?.endDate
                              : DateTime.now(),
                          onDonePressed: onAcceptChangesPressed,
                          onDateChanged: (value) => onDateChanged(value, type),
                        );
                      }

                      if (filter != null) {
                        return _ButtonSection(
                          onPressed: applyFilter,
                        );
                      }

                      return const _ModalStepperSection();
                    },
                  ),
                  66.boxHeight,
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
