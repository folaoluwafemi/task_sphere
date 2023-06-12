import 'package:flutter/widgets.dart';

class SvgDecorator extends StatelessWidget {
  final Color? color;
  final Widget child;
  final double? width;
  final double? height;

  const SvgDecorator({
    this.width,
    this.height,
    this.color,
    required this.child,
    Key? key,
  }) : super(key: key);

  SvgDecorator.size({
    Key? key,
    required Size size,
    this.color,
    required this.child,
  })  : width = size.width,
        height = size.height,
        super(key: key);

  const SvgDecorator.square({
    Key? key,
    required double dimension,
    this.color,
    required this.child,
  })  : width = dimension,
        height = dimension,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget child_ = SizedBox(
      height: height,
      width: width,
      child: child,
    );
    return color == null
        ? child_
        : ColorFiltered(
            colorFilter: ColorFilter.mode(
              color!,
              BlendMode.srcIn,
            ),
            child: child_,
          );
  }
}
