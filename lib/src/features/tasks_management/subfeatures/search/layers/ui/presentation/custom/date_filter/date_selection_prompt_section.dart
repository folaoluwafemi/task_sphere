part of 'date_filter_dialog.dart';

class _DateSelectionPromptSection extends StatelessWidget {
  final _DateFilterType? type;
  final SearchDateFilter? filter;
  final VoidCallback? onStartDatePressed;
  final VoidCallback? onEndDatePressed;

  const _DateSelectionPromptSection({
    this.type,
    this.filter,
    this.onStartDatePressed,
    this.onEndDatePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.bgColors.$50,
        borderRadius: (filter == null && type == null)
            ? Ui.circularBorderTop(8.l)
            : Ui.circularBorder(8.l),
      ),
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          14.boxHeight,
          Text(
            'SEARCH BY DATE | CHOOSE DATE:',
            style: context.primaryTypography.paragraph.small.asMedium,
          ),
          24.boxHeight,
          Center(
            child: DateRangePicker(
              startActive: type == null ? null : type == _DateFilterType.start,
              startDate: filter?.startDate,
              onStartDatePressed: onStartDatePressed,
              onEndDatePressed: onEndDatePressed,
              endDate: filter?.endDate,
            ),
          ),
          24.boxHeight,
        ],
      ),
    );
  }
}
