part of 'date_filter_dialog.dart';

class _ButtonSection extends StatelessWidget {
  final VoidCallback onPressed;

  const _ButtonSection({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        24.boxHeight,
        LargeButton(
          onPressed: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgDecorator.square(
                  dimension: 24.l,
                  color: context.bgColors.$50,
                  child: SvgPicture.asset(VectorAssets.searchPlus),
                ),
                6.boxWidth,
                Text(
                  'Apply search filter',
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
