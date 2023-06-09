import 'package:flutter/widgets.dart';
import 'package:task_sphere/src/entities/app/ui/components/components_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class TaskCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? gutterWidth;

  const TaskCard({
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
      child: ClipRRect(
        borderRadius: Ui.circularBorder(15.l),
        child: ClipPath(
          clipper: TaskCardClipper(
            gutterRadius: 4,
            gutterThickness: 4,
            gutterWidth: gutterWidth,
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
