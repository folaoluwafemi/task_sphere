part of '../search_screen.dart';

class _HistoryView extends StatelessWidget {
  final TextEditingController controller;

  const _HistoryView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VanillaBuilder<SearchVanilla, SearchState>(
      buildWhen: (previous, current) =>
          previous?.history != current.history ||
          previous?.history.length != current.history.length,
      builder: (context, state) {
        if (state.history.isEmpty) return const _EmptyHistoryView();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              74.boxHeight,
              Padding(
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
                        style: context
                            .secondaryTypography.paragraph.medium.asRegular
                            .withColor(context.neutralColors.$700),
                      ),
                    ),
                  ],
                ),
              ),
              24.boxHeight,
              ...state.history.map(
                (history) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: InkWell(
                    splashColor: context.neutralColors.$200,
                    highlightColor: context.neutralColors.$200,
                    onTap: () {
                      controller.text = history;
                      context.read<SearchVanilla>().searchFor(history);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      color: Colors.transparent,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          18.boxWidth,
                          SvgDecorator.square(
                            dimension: 20.l,
                            color: context.neutralColors.$800,
                            child: SvgPicture.asset(
                              VectorAssets.clock,
                            ),
                          ),
                          16.boxWidth,
                          Text(
                            history,
                            style: context
                                .secondaryTypography.paragraph.large.asRegular
                                .withColor(context.neutralColors.$800),
                          ),
                          const Spacer(),
                          SvgDecorator.square(
                            dimension: 24.l,
                            color: context.neutralColors.$500,
                            child: SvgPicture.asset(
                              VectorAssets.arrowUpRight,
                            ),
                          ),
                          18.boxWidth,
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _EmptyHistoryView extends StatelessWidget {
  const _EmptyHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
