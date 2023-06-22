part of '../about_design_dev_screen.dart';

class _BackButton extends StatelessWidget {
  const _BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: context.pop,
      child: SizedBox(
        height: 20.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgDecorator.square(
              dimension: 16.l,
              color: context.neutralColors.$700,
              child: SvgPicture.asset(VectorAssets.arrowLeft),
            ),
            8.boxWidth,
            Text(
              'Go back',
              style: context.secondaryTypography.paragraph.medium.asRegular,
            ),
          ],
        ),
      ),
    );
  }
}
