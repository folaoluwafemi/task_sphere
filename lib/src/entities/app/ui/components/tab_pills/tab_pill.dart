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

  Color backgroundColor(BuildContext context) {
    switch (this) {
      case TabPillState.selected:
        return context.neutralColors.$800;
      case TabPillState.unselected:
      case TabPillState.inactive:
        return context.bgColors.$50;
      case TabPillState.active:
        return context.palette.bgAccent;
    }
  }

  Color borderColor(BuildContext context) {
    switch (this) {
      case TabPillState.selected:
        return context.neutralColors.$800;
      case TabPillState.unselected:
        return context.neutralColors.$500;
      case TabPillState.inactive:
        return context.neutralColors.$400;
      case TabPillState.active:
        return context.palette.secondary;
    }
  }

  Color textColor(BuildContext context) {
    switch (this) {
      case TabPillState.selected:
        return context.bgColors.$50;
      case TabPillState.unselected:
      case TabPillState.inactive:
        return context.neutralColors.$600;
      case TabPillState.active:
        return context.neutralColors.$800;
    }
  }
}

class TabPill extends StatelessWidget {
  final String text;
  final TabPillState state;
  final _TabPillType _type;
  final VoidCallback? onPressed;

  const TabPill.monochrome({
    required this.text,
    required this.state,
    this.onPressed,
    super.key,
  }) : _type = _TabPillType.monochrome;

  const TabPill.colored({
    required this.text,
    required this.state,
    this.onPressed,
    super.key,
  }) : _type = _TabPillType.colored;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: Ui.circularBorder(6.m),
      child: Container(
        decoration: BoxDecoration(
          color: _type.backgroundColor(context, state),
          borderRadius: Ui.circularBorder(6.m),
          border: Border.all(
            color: _type.borderColor(context, state),
            width: 1,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 5.h,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: context.primaryTypography.paragraph.medium.copyWith(
            color: _type.textColor(context, state),
            fontSize: 10.sp,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
