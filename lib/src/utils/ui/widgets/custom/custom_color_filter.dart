import 'package:flutter/widgets.dart';

class CustomColorFilter extends StatelessWidget {
  final Color color;
  final Widget child;

  const CustomColorFilter({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      child: child,
    );
  }
}
