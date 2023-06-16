part of '../task_screen.dart';

class _TitleView extends StatelessWidget {
  const _TitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.bgColors.$50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          76.boxHeight,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: const _TitleFields(),
          ),
          30.boxHeight,
        ],
      ),
    );
  }
}
