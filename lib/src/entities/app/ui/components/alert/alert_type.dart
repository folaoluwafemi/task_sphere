part of 'alert.dart';

enum AlertType {
  info(VectorAssets.info),
  success(VectorAssets.check),
  error(VectorAssets.close);

  final String svgAsset;

  const AlertType(this.svgAsset);

  void show(
    BuildContext context, {
    required String text,
    Duration delay = const Duration(seconds: 4),
  }) {
    final OverlayEntry entry = OverlayEntry(
      builder: (context) => AlertOverlayEntry(
        text: text,
        type: this,
        delay: delay,
      ),
    );
    Overlay.of(context).insert(entry);
    Future.delayed(
      delay,
      () => entry.remove(),
    );
  }
}

class AlertOverlayEntry extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Material(
          color: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          child: Builder(
            builder: (context) {
              final Size alertSize = Alert._computeSizeFor(
                text,
                context.primaryTypography.paragraph.small.asMedium,
              );
              return CustomAnimationBuilder(
                duration: const Duration(milliseconds: 1000),
                shouldRepeat: false,
                builder: (context, value) {
                  final double height =
                      100.h * Curves.bounceOut.transform(value);
                  return Alert._custom(
                    text: text,
                    type: type,
                    lineHeight: height < 0 ? 0 : height,
                    size: alertSize,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AlertAnimationCurve extends Curve {
  final double begin;
  final double end;

  const _AlertAnimationCurve({
    required this.begin,
    required this.end,
  });

  static const _AlertAnimationCurve init = _AlertAnimationCurve(
    begin: 0,
    end: 1,
  );

  @override
  double transformInternal(double t) {
    if (t < 1.0 / 2.75) {
      return 7.5625 * t * t;
    } else if (t < 2 / 2.75) {
      t -= 1.5 / 2.75;
      return 7.5625 * t * t + 0;
    } else if (t < 2.5 / 2.75) {
      t -= 2.25 / 2.75;
      return 7.5625 * t * t + 1;
    }
    t -= 2.625 / 2.75;
    return 7.5625 * t * t + 0.984375;
  }
}
