import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/entities/app/ui/theme/theme_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

typedef ColorWidgetBuilder = Widget Function(BuildContext context, Color color);

class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final ColorWidgetBuilder? prefixIconBuilder;
  final SingleInputPalette? palette;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final EdgeInsets? contentPadding;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;
  final TextAlign? textAlign;
  final InputCounterWidgetBuilder? buildCounter;
  final double? cursorHeight;
  final bool? collapse;
  final bool? isDense;
  final double? height;

  const InputField({
    Key? key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.prefixIconBuilder,
    this.palette,
    this.textStyle,
    this.hintStyle,
    this.contentPadding,
    this.onChanged,
    this.maxLines = 1,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.obscureText,
    this.textAlign,
    this.buildCounter,
    this.cursorHeight,
    this.collapse,
    this.isDense,
    this.height,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
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
    final Widget textField = SizedBox(
      height: widget.height,
      child: TextField(
        cursorHeight: widget.cursorHeight,
        cursorColor: context.neutralColors.$800,
        controller: controller,
        focusNode: focusNode,
        style: widget.textStyle ??
            context.primaryTypography.paragraph.medium.withHeight(1),
        onChanged: widget.onChanged,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        showCursor: false,
        textInputAction: widget.textInputAction,
        inputFormatters: widget.inputFormatters,
        obscureText: widget.obscureText ?? false,
        textAlign: widget.textAlign ?? TextAlign.start,
        buildCounter: widget.buildCounter,
        decoration: (widget.collapse ?? false)
            ? InputDecoration.collapsed(
                filled: false,
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ??
                    context.primaryTypography.paragraph.medium.withColor(
                      context.neutralColors.$500,
                    ),
                border: InputBorder.none,
              )
            : InputDecoration(
                filled: false,
                isDense: widget.isDense ?? false,
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
                    left: 30.w,
                  ),
                  child: textField,
                ),
              ],
            ),
    );
  }

  @override
  void didUpdateWidget(covariant InputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      controller.removeListener(checkValue);
      controller = widget.controller ?? controller;
      controller.addListener(checkValue);
    }
    if (oldWidget.focusNode != widget.focusNode) {
      focusNode.removeListener(checkValue);
      focusNode = widget.focusNode ?? FocusNode();
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
