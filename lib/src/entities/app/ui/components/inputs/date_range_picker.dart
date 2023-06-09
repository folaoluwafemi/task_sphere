import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/entities/app/ui/components/spade/spade.dart';
import 'package:task_sphere/src/utils/functions/extensions/extensions.dart';

typedef DateRange = ({
  DateTime? startDate,
  DateTime? endDate,
});

class DateRangePicker extends StatefulWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final VoidCallback? onStartDatePressed;
  final VoidCallback? onEndDatePressed;

  const DateRangePicker({
    Key? key,
    this.startDate,
    this.endDate,
    this.onStartDatePressed,
    this.onEndDatePressed,
  }) : super(key: key);

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTime? get startDate => widget.startDate;

  DateTime? get endDate => widget.endDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(6.m),
          onTap: widget.onStartDatePressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.m),
              color: context.neutralColors.$100,
              border: Border.all(
                color: context.neutralColors.$500,
                width: 0.5.l,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
            child: Text(
              startDate?.formatSimpleDate() ?? '-- -- --',
              style: context.secondaryTypography.paragraph.large.asRegular,
            ),
          ),
        ),
        16.boxWidth,
        Spade.linked(
          firstHalfColor: switch (startDate) {
            null => context.neutralColors.$400,
            _ => context.palette.primary,
          },
          secondHalfColor: switch (endDate) {
            null => context.neutralColors.$400,
            _ => context.palette.primary,
          },
        ),
        16.boxWidth,
        InkWell(
          borderRadius: BorderRadius.circular(6.m),
          onTap: startDate == null ? null : widget.onEndDatePressed,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.m),
              color: context.neutralColors.$100,
              border: Border.all(
                color: startDate == null
                    ? context.neutralColors.$400
                    : context.neutralColors.$500,
                width: 0.5.l,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
            child: Text(
              endDate?.formatSimpleDate() ?? '-- -- --',
              style: context.secondaryTypography.paragraph.large.asRegular
                  .withColor(
                startDate == null ? context.neutralColors.$500 : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
