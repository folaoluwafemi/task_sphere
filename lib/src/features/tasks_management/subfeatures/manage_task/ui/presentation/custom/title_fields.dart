part of '../task_screen.dart';

class _TitleFields extends StatelessWidget {
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDescriptionChanged;

  const _TitleFields({
    required this.onTitleChanged,
    required this.onDescriptionChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: onTitleChanged,
          style: context.primaryTypography.title.large,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            hintText: 'New Task Name',
            hintStyle: context.primaryTypography.title.large.copyWith(
              color: context.neutralColors.$500,
            ),
            border: InputBorder.none,
          ),
        ),
        24.boxHeight,
        TextField(
          onChanged: onDescriptionChanged,
          style: context.secondaryTypography.paragraph.large.asRegular
              .withColor(context.neutralColors.$700),
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            isDense: true,
            hintText: 'Add description...',
            hintStyle: context.secondaryTypography.paragraph.large.asRegular
                .withColor(context.neutralColors.$600),
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }
}
