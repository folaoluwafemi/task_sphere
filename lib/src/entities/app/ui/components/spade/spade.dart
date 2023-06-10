import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/entities/app/ui/components/spade/half_spade_painter.dart';
import 'package:task_sphere/src/entities/app/ui/components/spade/linked_spades_painter.dart';
import 'package:task_sphere/src/utils/functions/extensions/extensions.dart';

enum _SpadePainterType {
  half,
  linked,
}

enum SpadeOrientation {
  vertical,
  horizontal,
}

class Spade extends StatelessWidget {
  final double headSize;
  final double stemLength;
  final Color? firstHalfColor;
  final Color? secondHalfColor;
  final _SpadePainterType _type;
  final SpadeOrientation orientation;

  Spade.half({
    double? headSize,
    double? stemLength,
    Color? color,
    super.key,
    this.orientation = SpadeOrientation.horizontal,
  })  : firstHalfColor = color,
        secondHalfColor = color,
        headSize = headSize ?? 12.w,
        stemLength = stemLength ?? 28.w,
        _type = _SpadePainterType.half;

  Spade.linked({
    double? headSize,
    double? stemLength,
    this.firstHalfColor,
    this.secondHalfColor,
    this.orientation = SpadeOrientation.horizontal,
    super.key,
  })  : headSize = headSize ?? 12.w,
        stemLength = stemLength ?? 28.w,
        _type = _SpadePainterType.linked;

  @override
  Widget build(BuildContext context) {
    final Color firstHalfColor =
        this.firstHalfColor ?? context.palette.secondary;
    final Color secondHalfColor =
        this.secondHalfColor ?? context.palette.secondary;

    final CustomPainter painter = switch (_type) {
      _SpadePainterType.half => HalfSpadePainter(
          orientation: orientation,
          headSize: headSize,
          stemLength: stemLength,
          color: firstHalfColor,
        ),
      _SpadePainterType.linked => LinkedSpadePainter(
          headSize: headSize,
          stemLength: stemLength,
          firstHalfColor: firstHalfColor,
          secondHalfColor: secondHalfColor,
        ),
    };
    return SizedBox(
      height: headSize,
      width: switch (_type) {
        _SpadePainterType.half => headSize + stemLength,
        _SpadePainterType.linked => (headSize * 2) + stemLength,
      },
      child: CustomPaint(
        painter: painter,
      ),
    );
  }
}
