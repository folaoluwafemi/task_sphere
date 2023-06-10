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

  static Size _computeSizeFor(String text, TextStyle style) {
    text = text.isEmpty ? ' ' : text;
    final TextSpan span = TextSpan(
      text: text,
      style: style,
    );
    final TextPainter textPainter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      textWidthBasis: TextWidthBasis.longestLine,
    )..layout();

    if (textPainter.minIntrinsicWidth == textPainter.maxIntrinsicWidth) {
      return textPainter.size +
          Offset(
            38.w.doubled,
            9.h.doubled,
          );
    }

    final Size size = Size(
      textPainter.width - 38.w.doubled,
      textPainter.height - 9.h.doubled,
    );

    textPainter.layout(
      minWidth: size.width,
      maxWidth: size.width,
    );

    return textPainter.size +
        Offset(
          38.w.doubled,
          9.h.doubled,
        );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style = context.primaryTypography.paragraph.small.asMedium
        .withColor(context.bgColors.$50);

    final Size size = this.size ?? _computeSizeFor(text, style);

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
                  key: UniqueKey(),
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
                padding: EdgeInsets.symmetric(horizontal: 38.w, vertical: 9.h),
                child: Text(
                  text,
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
