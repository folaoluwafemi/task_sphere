import 'dart:math';

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
  final double head1Size;
  final double head2Size;
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
        head2Size = headSize ?? 12.w,
        head1Size = headSize ?? 12.w,
        stemLength = stemLength ?? 28.w,
        _type = _SpadePainterType.half;

  Spade.linked({
    double? head1Size,
    double? head2Size,
    double? stemLength,
    this.firstHalfColor,
    this.secondHalfColor,
    this.orientation = SpadeOrientation.horizontal,
    super.key,
  })  : head1Size = head1Size ?? 12.w,
        head2Size = head2Size ?? 12.w,
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
          headSize: head1Size,
          stemLength: stemLength,
          color: firstHalfColor,
        ),
      _SpadePainterType.linked => LinkedSpadePainter(
          head1Size: head1Size,
          head2Size: head2Size,
          stemLength: stemLength,
          firstHalfColor: firstHalfColor,
          secondHalfColor: secondHalfColor,
        ),
    };
    return SizedBox(
      height: max(head1Size, head2Size),
      width: switch (_type) {
        _SpadePainterType.half => head1Size + stemLength,
        _SpadePainterType.linked => (head1Size + head2Size) + stemLength,
      },
      child: CustomPaint(
        key: UniqueKey(),
        painter: painter,
      ),
    );
  }
}
