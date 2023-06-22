part of '../about_design_dev_screen.dart';

class _StackedText extends StatelessWidget {
  const _StackedText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Stack(
        children: [
          SizedBox(
            width: 265.w,
            child: Text(
              'About TaskSphere’s design and development',
              style: context.primaryTypography.title.large
                  .withColor(context.bgColors.$50),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: SizedBox(
              width: 265.w,
              child: Text(
                'About TaskSphere’s design and development',
                style: context.primaryTypography.title.large,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
