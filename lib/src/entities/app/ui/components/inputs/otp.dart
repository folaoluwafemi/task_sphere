import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/entities/app/ui/components/inputs/input_field.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class OtpField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const OtpField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  @override
  void initState() {
    super.initState();

    focusNodes[0] = FocusNode(
      canRequestFocus: controllers[1].text.isEmpty,
    );
    focusNodes[1] = FocusNode(
      canRequestFocus:
          controllers[0].text.isNotEmpty && controllers[2].text.isEmpty,
    );
    focusNodes[2] = FocusNode(
      canRequestFocus:
          controllers[1].text.isNotEmpty && controllers[3].text.isEmpty,
    );

    focusNodes[3] = FocusNode(
      canRequestFocus: controllers[2].text.isNotEmpty,
    );
    addControllerListener();
  }

  void addControllerListener() {
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].addListener(() => textChangeListener(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Builder(
        builder: (context) {
          return Row(
            children: [
              Flexible(
                child: _OtpFieldItem(
                  focusNode: focusNodes[0],
                  controller: controllers[0],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
              ),
              8.boxWidth,
              Flexible(
                child: _OtpFieldItem(
                  focusNode: focusNodes[1],
                  controller: controllers[1],
                  onChanged: (value) {
                    if (value.isEmpty) {
                      FocusScope.of(context).previousFocus();
                    } else {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
              ),
              8.boxWidth,
              Flexible(
                child: _OtpFieldItem(
                  focusNode: focusNodes[2],
                  controller: controllers[2],
                  onChanged: (value) {
                    if (value.isEmpty) {
                      FocusScope.of(context).previousFocus();
                    } else {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
              ),
              8.boxWidth,
              Flexible(
                child: _OtpFieldItem(
                  focusNode: focusNodes[3],
                  controller: controllers[3],
                  onChanged: (value) {
                    if (value.isEmpty) {
                      FocusScope.of(context).previousFocus();
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  final List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  final List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  void textChangeListener(int n) {
    if (n > 0 && controllers[n].text.isEmpty && n != controllers.lastIndex) {
      if (controllers.anyAfter(n, (element) => element.text.isNotEmpty)) {
        controllers.forEachWhereAfter(
          index: n,
          where: (element) => element.text.isNotEmpty,
          action: (element) => element.clear(),
        );
      }
      return;
    }

    if (controllers.anyBefore(n, (element) => element.text.isEmpty)) {
      controllers[n].clear();

      for (int i = 0; i < n; i++) {
        if (controllers[i].text.isEmpty) {
          focusNodes[i].requestFocus();
        }
      }
    }

    onChanged();
  }

  void onChanged() {
    widget.onChanged(otp);
  }

  String get otp => controllers.fold(
        '',
        (previousValue, element) => previousValue + element.text,
      );

  @override
  void dispose() {
    for (FocusNode element in focusNodes) {
      element.dispose();
    }
    for (TextEditingController element in controllers) {
      element.dispose();
    }

    super.dispose();
  }
}

class _OtpFieldItem extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final ValueChanged<String> onChanged;

  const _OtpFieldItem({
    Key? key,
    this.focusNode,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52.h,
      child: InputField(
        controller: controller,
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
