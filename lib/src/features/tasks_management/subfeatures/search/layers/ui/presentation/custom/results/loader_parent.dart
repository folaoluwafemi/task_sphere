part of 'results_view.dart';

class LoaderParent extends StatelessWidget {
  final bool shouldLoad;
  final Widget child;

  const LoaderParent({
    Key? key,
    required this.shouldLoad,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (shouldLoad)
          Container(
            color: context.neutralColors.$800.withOpacity(0.1),
            padding: EdgeInsets.only(bottom: 70.h),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: LoaderWidget(
                color: context.palette.primary,
              ),
            ),
          ),
      ],
    );
  }
}
