part of 'history_view.dart';

class _EmptyHistoryView extends StatelessWidget {
  const _EmptyHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Spacer(
            flex: 10,
          ),
          SizedBox.square(
            dimension: 253.l,
            child: Image.asset(
              Assets.noSearchHistory,
              fit: BoxFit.contain,
            ),
          ),
          9.boxHeight,
          SizedBox(
            width: 237.w,
            child: Text(
              'Your most recent searches would appear here',
              textAlign: TextAlign.center,
              style: context.primaryTypography.paragraph.medium
                  .withColor(context.neutralColors.$800),
            ),
          ),
          const Spacer(
            flex: 17,
          ),
        ],
      ),
    );
  }
}
