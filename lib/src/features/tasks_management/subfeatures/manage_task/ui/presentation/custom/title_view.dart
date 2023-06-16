part of '../task_screen.dart';

class _TitleView extends StatelessWidget {
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDescriptionChanged;

  const _TitleView({
    required this.onTitleChanged,
    required this.onDescriptionChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.bgColors.$50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CloseButton(),
          22.boxHeight,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: _TitleFields(
              onTitleChanged: (value) {},
              onDescriptionChanged: (value) {},
            ),
          ),
          30.boxHeight,
        ],
      ),
    );
  }
}
