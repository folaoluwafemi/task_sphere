import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class InputFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final ColorWidgetBuilder? prefixIconBuilder;
  final SingleInputPalette? palette;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final EdgeInsets? contentPadding;
  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  const InputFormField({
    Key? key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.prefixIconBuilder,
    this.palette,
    this.textStyle,
    this.hintStyle,
    this.contentPadding,
    this.autovalidateMode,
    this.validator,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  State<InputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  late final TextEditingController controller;
  late final FocusNode focusNode;

  late final SingleInputPalette palette =
      widget.palette ?? context.inputPalette.singleFieldPalette;

  late SingleInputColors colors = palette.focused;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
    controller.addListener(checkValue);
    focusNode.addListener(checkValue);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkValue();
  }

  void setPalette(SingleInputColors colors) {
    if (this.colors == colors) return;
    setState(() {
      this.colors = colors;
    });
  }

  void checkValue() {
    if (controller.text.isEmpty && focusNode.hasFocus) {
      return setPalette(palette.focused);
    }
    if (controller.text.isEmpty && !focusNode.hasFocus) {
      return setPalette(palette.empty);
    }
    if (controller.text.isNotEmpty && focusNode.hasFocus) {
      return setPalette(palette.focused);
    }
    if (controller.text.isNotEmpty && !focusNode.hasFocus) {
      return setPalette(palette.filled);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextFormField textField = TextFormField(
      controller: controller,
      focusNode: focusNode,
      style: widget.textStyle ??
          context.primaryTypography.paragraph.medium.withHeight(1),
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        filled: false,
        contentPadding: EdgeInsets.zero,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            context.primaryTypography.paragraph.medium.withColor(
              context.neutralColors.$500,
            ),
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
      ),
    );
    return Container(
      decoration: BoxDecoration(
        color: colors.fillColor,
        borderRadius: BorderRadius.circular(10.m),
        border: Border.all(
          color: colors.borderColor,
          width: 1,
        ),
      ),
      padding: widget.contentPadding ??
          EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 2.h,
          ),
      child: widget.prefixIconBuilder == null
          ? textField
          : Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: 24.w,
                  height: 24.h,
                  child: Center(
                    child: widget.prefixIconBuilder!(
                      context,
                      colors.prefixIconColor,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 40.w,
                  ),
                  child: textField,
                ),
              ],
            ),
    );
  }

  @override
  void didUpdateWidget(covariant InputFormField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      controller.removeListener(checkValue);
      controller = widget.controller ?? controller;
      controller.addListener(checkValue);
    }
    if (oldWidget.focusNode != widget.focusNode) {
      focusNode.removeListener(checkValue);
      focusNode = widget.focusNode ?? focusNode;
      focusNode.addListener(checkValue);
    }
  }

  @override
  void dispose() {
    controller.removeListener(checkValue);
    focusNode.removeListener(checkValue);
    if (widget.controller == null) controller.dispose();
    if (widget.focusNode == null) focusNode.dispose();
    super.dispose();
  }
}
