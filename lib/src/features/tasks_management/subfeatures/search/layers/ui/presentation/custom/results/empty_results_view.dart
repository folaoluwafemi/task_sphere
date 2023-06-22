part of 'results_view.dart';

class _EmptyResultsView extends StatelessWidget {
  const _EmptyResultsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          170.boxHeight,
          Column(
            children: [
              SvgDecorator(
                width: 99.97.w,
                height: 116.h,
                color: context.neutralColors.$400,
                child: SvgPicture.asset(
                  VectorAssets.searchGhost,
                  fit: BoxFit.contain,
                ),
              ),
              28.boxHeight,
              SizedBox(
                width: 299.w,
                child: Text(
                  'Oops, no search results. Try searching for a different term',
                  textAlign: TextAlign.center,
                  style: context.primaryTypography.paragraph.medium
                      .withColor(context.neutralColors.$800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
