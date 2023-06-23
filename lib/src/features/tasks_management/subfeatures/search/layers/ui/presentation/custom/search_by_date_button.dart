part of '../search_screen.dart';

class _SearchByDateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SearchByDateButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        color: context.bgColors.$100,
        padding: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 8.h,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgDecorator.square(
              dimension: 16.l,
              color: context.neutralColors.$700,
              child: SvgPicture.asset(VectorAssets.calendar),
            ),
            5.boxWidth,
            Text(
              'Search by date',
              style: context.primaryTypography.paragraph.small.asMedium,
            ),
          ],
        ),
      ),
    );
  }
}
