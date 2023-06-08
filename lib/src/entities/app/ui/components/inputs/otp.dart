import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_sphere/src/entities/app/ui/components/inputs/input_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class CodeFields extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const CodeFields({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State createState() => _CodeFieldsState();
}

class _CodeFieldsState extends State<CodeFields> {
  bool isLightTheme = false;

  @override
  void initState() {
    super.initState();

    focusNode1 = FocusNode(
      canRequestFocus: text2.isEmpty,
    );
    focusNode2 = FocusNode(
      canRequestFocus: text1.isNotEmpty && text3.isEmpty,
    );
    focusNode3 = FocusNode(
      canRequestFocus: text2.isNotEmpty && text4.isEmpty,
    );

    focusNode4 = FocusNode(
      canRequestFocus: text3.isNotEmpty,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Builder(
        builder: (context) {
          return Row(
            children: [
              Flexible(
                child: CodeField(
                  focusNode: focusNode1,
                  lightTheme: isLightTheme,
                  onChanged: (value) {
                    text1 = value;
                    if (value.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                    widget.onChanged(otp);
                  },
                ),
              ),
              8.boxWidth,
              Flexible(
                child: CodeField(
                  focusNode: focusNode2,
                  lightTheme: isLightTheme,
                  onChanged: (value) {
                    text2 = value;
                    if (value.isEmpty) {
                      FocusScope.of(context).previousFocus();
                    } else {
                      FocusScope.of(context).nextFocus();
                    }
                    widget.onChanged(otp);
                  },
                ),
              ),
              8.boxWidth,
              Flexible(
                child: CodeField(
                  focusNode: focusNode3,
                  lightTheme: isLightTheme,
                  onChanged: (value) {
                    text3 = value;
                    if (value.isEmpty) {
                      FocusScope.of(context).previousFocus();
                    } else {
                      FocusScope.of(context).nextFocus();
                    }
                    widget.onChanged(otp);
                  },
                ),
              ),
              8.boxWidth,
              Flexible(
                child: CodeField(
                  focusNode: focusNode4,
                  lightTheme: isLightTheme,
                  onChanged: (value) {
                    text4 = value;
                    if (value.isEmpty) {
                      FocusScope.of(context).previousFocus();
                    }
                    widget.onChanged(otp);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  late final FocusNode focusNode1;

  late final FocusNode focusNode2;

  late final FocusNode focusNode3;

  late final FocusNode focusNode4;

  String text1 = '';
  String text2 = '';
  String text3 = '';
  String text4 = '';

  String get otp => '$text1$text2$text3$text4';

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    super.dispose();
  }
}

class CodeField extends StatelessWidget {
  final FocusNode? focusNode;
  final bool lightTheme;
  final ValueChanged<String> onChanged;

  const CodeField({
    Key? key,
    this.focusNode,
    required this.onChanged,
    required this.lightTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52.h,
      child: InputField(
        isDense: true,
        height: 30.h,
        cursorHeight: 30.h,
        textStyle: context.primaryTypography.title.large,
        contentPadding: EdgeInsets.only(
          top: 14.h,
          bottom: 8.h,
        ),
        focusNode: focusNode,
        maxLines: 1,
        maxLength: 1,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textAlign: TextAlign.center,
        buildCounter: (
          context, {
          int? currentLength,
          bool? isFocused,
          maxLength,
        }) =>
            const SizedBox.shrink(),
      ),
    );
  }
}
