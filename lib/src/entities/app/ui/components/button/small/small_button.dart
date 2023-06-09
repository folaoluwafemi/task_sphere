import 'package:flutter/widgets.dart';
import 'package:task_sphere/src/entities/app/ui/components/components_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class SmallButton extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? gutterWidth;

  const SmallButton({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.gutterWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipPath(
        key: UniqueKey(),
        clipper: SmallButtonBezierClipper(
          horizontalLength: 20,
          verticalHeight: 10,
          depth: 2,
          radius: 1,
        ),
        child: ClipPath(
          clipper: SmallButtonGutterClipper(
            horizontalLength: 20,
            verticalHeight: 10,
            depth: 2,
            radius: 1,
          ),
          child: Container(
            color: context.bgColors.$50,
            child: child,
          ),
        ),
      ),
    );
  }
}
