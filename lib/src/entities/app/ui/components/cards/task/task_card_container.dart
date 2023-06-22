import 'package:flutter/widgets.dart';
import 'package:task_sphere/src/entities/app/ui/components/components_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class TaskCardContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? gutterWidth;
  final double? gutterThickness;
  final double? gutterRadius;

  const TaskCardContainer({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.gutterWidth,
    this.gutterThickness,
    this.gutterRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: Ui.circularBorder(15.l),
        child: ClipPath(
          clipper: TaskCardClipper(
            gutterRadius: gutterRadius ?? 4,
            gutterThickness: gutterThickness ?? 4,
            gutterWidth: gutterWidth, //defaults to [44.h]
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
