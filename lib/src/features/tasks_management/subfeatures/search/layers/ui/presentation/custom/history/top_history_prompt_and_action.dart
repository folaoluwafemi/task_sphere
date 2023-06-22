part of 'history_view.dart';

class _TopHistoryPromptAndAction extends StatelessWidget {
  const _TopHistoryPromptAndAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Row(
        children: [
          Text(
            'RECENT SEARCHES',
            style: context.primaryTypography.paragraph.small.asMedium
                .withColor(context.palette.primary),
          ),
          const Spacer(),
          InkWell(
            onTap: context.read<SearchVanilla>().clearHistory,
            child: Text(
              'Clear all',
              style: context.secondaryTypography.paragraph.medium.asRegular
                  .withColor(context.neutralColors.$700),
            ),
          ),
        ],
      ),
    );
  }
}
