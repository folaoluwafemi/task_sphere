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
      mainAxisSize: MainAxisSize.min,
      children: [
        RawMaterialButton(
          onPressed: widget.onStartDatePressed,
          focusElevation: 2,
          elevation: 2,
          highlightElevation: 2,
          padding: EdgeInsets.all(2.m),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.m),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.m),
              color: context.neutralColors.$100,
              border: Border.all(
                color: context.neutralColors.$500,
                width: 0.5.l,
              ),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
            child: SizedBox(
              width: 85.w,
              child: Center(
                child: Text(
                  startDate?.formatSimpleDate() ?? '-- -- --',
                  overflow: TextOverflow.visible,
                  maxLines: 1,
                  style: context.secondaryTypography.paragraph.large.asRegular,
                ),
              ),
            ),
          ),
        ),
        14.boxWidth,
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
        14.boxWidth,
        RawMaterialButton(
          focusElevation: 2,
          elevation: 2,
          highlightElevation: 2,
          padding: EdgeInsets.all(2.m),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.m),
          ),
          onPressed: startDate == null ? null : widget.onEndDatePressed,
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
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.h),
            child: SizedBox(
              width: 85.w,
              child: Center(
                child: Text(
                  endDate?.formatSimpleDate() ?? '-- -- --',
                  overflow: TextOverflow.visible,
                  maxLines: 1,
                  style: context.secondaryTypography.paragraph.large.asRegular
                      .withColor(
                    startDate == null ? context.neutralColors.$500 : null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
