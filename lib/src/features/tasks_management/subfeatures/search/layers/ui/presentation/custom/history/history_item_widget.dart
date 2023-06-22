part of 'history_view.dart';

class _HistoryItemWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String history;

  const _HistoryItemWidget({
    required this.history,
    required this.controller,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: context.neutralColors.$200,
      highlightColor: context.neutralColors.$200,
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            18.boxWidth,
            SvgDecorator.square(
              dimension: 20.l,
              color: context.neutralColors.$800,
              child: SvgPicture.asset(
                VectorAssets.clock,
              ),
            ),
            16.boxWidth,
            Text(
              history,
              style: context.secondaryTypography.paragraph.large.asRegular
                  .withColor(context.neutralColors.$800),
            ),
            const Spacer(),
            SvgDecorator.square(
              dimension: 24.l,
              color: context.neutralColors.$500,
              child: SvgPicture.asset(
                VectorAssets.arrowUpRight,
              ),
            ),
            18.boxWidth,
          ],
        ),
      ),
    );
  }
}
