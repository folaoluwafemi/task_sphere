import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

enum _TabPillType {
  monochrome,
  colored;

  Color backgroundColor(BuildContext context, TabPillState state) =>
      state.backgroundColor(context);

  Color borderColor(BuildContext context, TabPillState state) =>
      state.borderColor(context);

  Color textColor(BuildContext context, TabPillState state) =>
      state.textColor(context);
}

enum TabPillState {
  selected,
  unselected,
  inactive,
  active;

  Color backgroundColor(BuildContext context) => switch (this) {
        TabPillState.selected => context.neutralColors.$800,
        TabPillState.unselected => context.bgColors.$50,
        TabPillState.inactive => context.bgColors.$50,
        TabPillState.active => context.palette.bgAccent,
      };

  Color borderColor(BuildContext context) => switch (this) {
        TabPillState.selected => context.neutralColors.$800,
        TabPillState.unselected => context.neutralColors.$500,
        TabPillState.inactive => context.neutralColors.$400,
        TabPillState.active => context.palette.secondary,
      };

  Color textColor(BuildContext context) => switch (this) {
        TabPillState.selected => context.bgColors.$50,
        TabPillState.unselected => context.neutralColors.$600,
        TabPillState.inactive => context.neutralColors.$600,
        TabPillState.active => context.neutralColors.$800,
      };
}

class TabPill extends StatelessWidget {
  final String text;
  final TabPillState state;
  final _TabPillType _type;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final double? borderRadius;
  final EdgeInsets? padding;

  const TabPill.monochrome({
    required this.text,
    required this.state,
    this.onPressed,
    this.textStyle,
    this.borderRadius,
    super.key,
    this.padding,
  }) : _type = _TabPillType.monochrome;

  const TabPill.colored({
    required this.text,
    required this.state,
    this.onPressed,
    this.textStyle,
    this.borderRadius,
    super.key,
    this.padding,
  }) : _type = _TabPillType.colored;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: Ui.circularBorder(borderRadius ?? 6.m),
      child: Container(
        decoration: BoxDecoration(
          color: _type.backgroundColor(context, state),
          borderRadius: Ui.circularBorder(6.m),
          border: Border.all(
            color: _type.borderColor(context, state),
            width: 1,
          ),
        ),
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 5.h,
            ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: (textStyle ??
                  context.primaryTypography.paragraph.medium.copyWith(
                    fontSize: 10.sp,
                    letterSpacing: 0.5,
                  ))
              .withColor(_type.textColor(context, state)),
        ),
      ),
    );
  }
}
