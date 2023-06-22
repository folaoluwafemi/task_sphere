part of 'date_filter_dialog.dart';

class _ModalStepperSection extends StatelessWidget {
  const _ModalStepperSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StepperDivider(),
        ModalCard(
          borderRadius: Ui.circularBorderBottom(8.l),
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 14.h, 24.w, 16.h),
            child: Row(
              children: [
                SvgDecorator.square(
                  dimension: 20.l,
                  color: context.palette.secondary,
                  child: SvgPicture.asset(VectorAssets.info),
                ),
                9.boxWidth,
                Expanded(
                  child: Text(
                    'Pick a date for specific search results, or select both dates to search within the range.',
                    style: context.secondaryTypography.paragraph.small
                        .withColor(context.palette.secondary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
