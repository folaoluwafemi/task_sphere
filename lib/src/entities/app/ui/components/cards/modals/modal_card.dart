import 'package:flutter/widgets.dart';
import 'package:task_sphere/src/entities/app/ui/components/components_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class ModalCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? gutterHeight;
  final BorderRadius? borderRadius;

  const ModalCard({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.gutterHeight,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius ?? Ui.circularBorder(8),
        child: ClipPath(
          clipper: ModalCardClipper(
            gutterRadius: 4,
            gutterHeight: gutterHeight,
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
