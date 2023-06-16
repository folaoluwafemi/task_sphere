part of '../task_screen.dart';


class _CloseButton extends StatelessWidget {
  const _CloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: Ui.circularBorder(50),
      onTap: context.pop,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 18.w),
        child: SvgDecorator.square(
          dimension: 24.l,
          color: context.neutralColors.$800,
          child: SvgPicture.asset(VectorAssets.cancelFilled),
        ),
      ),
    );
  }
}
