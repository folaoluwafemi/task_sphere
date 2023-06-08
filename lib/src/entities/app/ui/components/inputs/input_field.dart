import 'package:flutter/widgets.dart';
import 'package:task_sphere/src/entities/app/ui/theme/data/input/inputs.dart';

typedef ColorWidgetBuilder = Widget Function(BuildContext context, Color color);

class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final ColorWidgetBuilder? prefixIconBuilder;
  final SingleInputColors? style;

  const InputField({Key? key}) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
