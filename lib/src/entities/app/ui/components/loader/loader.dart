import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/entities/app/ui/components/spade/spade.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class LoaderWidget extends StatefulWidget {
  final Color? color;

  const LoaderWidget({
    Key? key,
    this.color,
  }) : super(key: key);

  @override
  State<LoaderWidget> createState() => _LoaderWidgetState();
}

class _LoaderWidgetState extends State<LoaderWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18.l,
      child: CustomAnimationBuilder(
        duration: const Duration(milliseconds: 1000),
        shouldRepeat: true,
        builder: (context, value) {
          final double minSize = 6.m;
          final double maxSize = 18.l;

          final bool firstRun = value < 0.5;

          if (firstRun) {
            value = value * 2;

            final double head1Size = Tween<double>(
              begin: minSize,
              end: maxSize,
            ).transform(value);

            final double head2Size = Tween<double>(
              begin: maxSize,
              end: minSize,
            ).transform(value);

            return Spade.linked(
              firstHalfColor: widget.color,
              secondHalfColor: widget.color,
              head1Size: head2Size,
              head2Size: head1Size,
              stemLength: 12.w,
            );
          }

          value = (value - 0.5) * 2;

          final double head1Size = Tween<double>(
            begin: minSize,
            end: maxSize,
          ).transform(value);

          final double head2Size = Tween<double>(
            begin: maxSize,
            end: minSize,
          ).transform(value);

          return Spade.linked(
            firstHalfColor: widget.color,
            secondHalfColor: widget.color,
            head1Size: head1Size,
            head2Size: head2Size,
            stemLength: 12.w,
          );
        },
      ),
    );
  }
}
