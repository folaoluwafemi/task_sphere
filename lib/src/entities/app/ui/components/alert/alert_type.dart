part of 'alert.dart';

enum AlertType {
  info(VectorAssets.info),
  success(VectorAssets.check),
  error(VectorAssets.close);

  final String svgAsset;

  const AlertType(this.svgAsset);

  Future<void> show(
    BuildContext context, {
    required String text,
    Duration delay = const Duration(seconds: 5),
  }) async {
    final OverlayEntry entry = OverlayEntry(
      builder: (context) => AlertOverlayEntry(
        text: text,
        type: this,
        delay: delay,
      ),
    );
    Overlay.of(context).insert(entry);
    await Future.delayed(
      delay,
      () => entry.remove(),
    );
  }
}

class AlertOverlayEntry extends StatefulWidget {
  final String text;
  final AlertType type;
  final Duration delay;

  const AlertOverlayEntry({
    Key? key,
    required this.text,
    required this.type,
    required this.delay,
  }) : super(key: key);

  @override
  State<AlertOverlayEntry> createState() => _AlertOverlayEntryState();
}

class _AlertOverlayEntryState extends State<AlertOverlayEntry> {
  void startChecker() {
    Future.delayed(
      widget.delay - const Duration(milliseconds: 200),
      () => setState(() {
        shouldDescend = true;
      }),
    );
  }

  bool shouldDescend = false;

  @override
  void initState() {
    super.initState();
    startChecker();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Material(
          color: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Builder(
              builder: (context) {
                final Size alertSize = Alert._computeHeight(
                      widget.text,
                      context.primaryTypography.paragraph.small.asMedium,
                      context.mediaQuery.size.width - 60.w,
                    ) +
                    Offset(38.w.doubled, 9.h.doubled);

                if (shouldDescend) {
                  return CustomAnimationBuilder(
                    key: const ValueKey('__descend__ | __animation__'),
                    duration: const Duration(milliseconds: 200),
                    shouldRepeat: false,
                    builder: (context, value) {
                      final double height = Tween<double>(begin: 100.h, end: 0)
                          .transform(Curves.easeOut.transform(value));
                      return Alert._custom(
                        text: widget.text,
                        type: widget.type,
                        lineHeight: height < 0 ? 0 : height,
                        size: alertSize,
                      );
                    },
                  );
                }
                return CustomAnimationBuilder(
                  key: const ValueKey("__ascend__ -|- __animation__"),
                  duration: const Duration(milliseconds: 1000),
                  shouldRepeat: false,
                  builder: (context, value) {
                    final double height =
                        100.h * Curves.bounceOut.transform(value);
                    return Alert._custom(
                      text: widget.text,
                      type: widget.type,
                      lineHeight: height < 0 ? 0 : height,
                      size: alertSize,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
