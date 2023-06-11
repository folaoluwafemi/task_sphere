import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_sphere/src/entities/app/ui/components/components_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'alert_type.dart';

class Alert extends StatelessWidget {
  final String text;
  final double? lineHeight;
  final AlertType _type;
  final Size? size;

  const Alert._custom({
    Key? key,
    required this.text,
    this.lineHeight,
    required this.size,
    required AlertType type,
  })  : _type = type,
        super(key: key);

  const Alert.info({
    Key? key,
    required this.text,
    this.lineHeight,
  })  : _type = AlertType.info,
        size = null,
        super(key: key);

  const Alert.error({
    Key? key,
    required this.text,
    this.lineHeight,
  })  : _type = AlertType.error,
        size = null,
        super(key: key);

  const Alert.success({
    Key? key,
    required this.text,
    this.lineHeight,
  })  : _type = AlertType.success,
        size = null,
        super(key: key);

  static Size _computeHeight(
    String text,
    TextStyle style,
    double width,
  ) {
    text = text.linesRemoved;

    final TextSpan span = TextSpan(
      text: text,
      style: style,
    );

    final TextPainter textPainter = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    textPainter.layout();

    double lines = (textPainter.size.width / width).ceilToDouble();

    if (textPainter.size.width > width) {
      lines = lines + 1;
      return Size(textPainter.size.width, textPainter.height * lines) +
          Offset(
            0,
            9.h.doubled,
          );
    }

    return Size(textPainter.width, textPainter.height * lines);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style = context.primaryTypography.paragraph.small.asMedium
        .withColor(context.bgColors.$50);

    final Size size = this.size ??
        _computeHeight(
              text,
              context.primaryTypography.paragraph.small.asMedium,
              //60 here is the margin horizontal of the alert
              context.mediaQuery.size.width - 60.w,
            ) +
            Offset(38.w.doubled, 9.h.doubled);

    return SizedBox(
      width: size.width,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -17.w,
                child: SvgPicture.asset(
                  _type.svgAsset,
                  width: 24.w,
                ),
              ),
              ClipRRect(
                borderRadius: Ui.circularBorder(8),
                child: ClipPath(
                  clipper: AlertGutterClipper(
                    verticalHeight: 16.h,
                    depth: 2.w,
                    radius: 4.w,
                  ),
                  child: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: CustomPaint(
                      painter: AlertPainter(
                        color: context.alertColors.background,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                // padding: EdgeInsets.symmetric(horizontal: 38.w, vertical: 9.h),
                padding: EdgeInsets.symmetric(horizontal: 38.w),
                child: Text(
                  text.linesRemoved,
                  textAlign: TextAlign.center,
                  style: style,
                ),
              )
            ],
          ),
          SizedBox(
            width: 3,
            height: lineHeight ?? 55.h,
            child: CustomPaint(
              painter: AlertTailPainter(
                height: lineHeight ?? 55.h,
                color: context.alertColors.background,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
