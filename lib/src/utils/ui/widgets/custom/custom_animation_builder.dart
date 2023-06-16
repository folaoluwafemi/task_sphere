import 'package:flutter/widgets.dart';

typedef CustomAnimationBuilderCallback = Widget Function(
  BuildContext context,
  double value,
);

class CustomAnimationBuilder extends StatefulWidget {
  final Duration duration;
  final CustomAnimationBuilderCallback builder;
  final AnimationBehavior animationBehavior;
  final bool shouldRepeat;

  const CustomAnimationBuilder({
    Key? key,
    required this.duration,
    required this.builder,
    this.animationBehavior = AnimationBehavior.normal,
    this.shouldRepeat = false,
  }) : super(key: key);

  @override
  State<CustomAnimationBuilder> createState() => _CustomAnimationBuilderState();
}

class _CustomAnimationBuilderState extends State<CustomAnimationBuilder>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: widget.duration,
    lowerBound: 0,
    upperBound: 1,
    animationBehavior: AnimationBehavior.preserve,
  );

  late final Animation<double> animation;

  @override
  void initState() {
    animation = Tween<double>(begin: 0, end: 1).animate(
      controller,
    );
    if (widget.shouldRepeat) {
      controller.repeat();
    } else {
      controller.forward();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => widget.builder(context, animation.value),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
