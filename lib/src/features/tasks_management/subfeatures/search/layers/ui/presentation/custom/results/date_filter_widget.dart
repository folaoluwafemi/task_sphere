part of 'results_view.dart';

class _DateFilterWidget extends StatelessWidget {
  final SearchDateFilter filter;

  const _DateFilterWidget({
    Key? key,
    required this.filter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 16.h,
          width: 12.w,
          child: Transform.rotate(
            angle: 180.toRadians,
            child: Spade.half(
              color: context.palette.primary,
              orientation: SpadeOrientation.vertical,
              stemLength: 16.h,
            ),
          ),
        ),
        Positioned(
          top: 10.h,
          child: Container(
            decoration: BoxDecoration(
              color: context.bgColors.$50,
              borderRadius: BorderRadius.circular(4.l),
              border: Border.all(
                color: context.neutralColors.$400,
                width: 1.l,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 8.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  formatDate(filter.startDate),
                  style: context.secondaryTypography.paragraph.small
                      .withColor(context.neutralColors.$800)
                      .withHeight(1),
                ),
                if (filter.endDate != null) ...[
                  16.boxWidth,
                  Text(
                    '----',
                    style: context.secondaryTypography.paragraph.small.asRegular
                        .withColor(context.neutralColors.$400)
                        .withHeight(1),
                  ),
                  16.boxWidth,
                  Text(
                    formatDate(filter.endDate!),
                    style: context.secondaryTypography.paragraph.small.asRegular
                        .withColor(context.neutralColors.$800)
                        .withHeight(1),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  String formatDate(DateTime date) {
    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    final String year = date.year.toString();
    return '$day $month $year';
  }
}
