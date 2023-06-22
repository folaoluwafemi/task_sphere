part of 'date_filter_dialog.dart';

class _DatePickerSection extends StatelessWidget {
  final ValueChanged<DateTime> onDateChanged;
  final VoidCallback onDonePressed;
  final DateTime? maxDate;

  const _DatePickerSection({
    Key? key,
    required this.onDateChanged,
    required this.onDonePressed,
    this.maxDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        11.boxHeight,
        Container(
          height: 270.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11.l),
            color: context.bgColors.$50,
          ),
          child: CupertinoDatePicker(
            initialDateTime: maxDate ??
                DateTime.now().subtract(
                  const Duration(days: 7),
                ),
            maximumDate: maxDate ?? DateTime.now(),
            dateOrder: DatePickerDateOrder.dmy,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: onDateChanged,
          ),
        ),
        24.boxHeight,
        LargeButton(
          onPressed: onDonePressed,
          color: context.neutralColors.$700,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgDecorator.square(
                  dimension: 24.l,
                  color: context.bgColors.$50,
                  child: SvgPicture.asset(
                    VectorAssets.checkWeighted,
                  ),
                ),
                9.boxWidth,
                Text(
                  'Done',
                  style:
                      context.buttonTextStyle.withColor(context.bgColors.$50),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
