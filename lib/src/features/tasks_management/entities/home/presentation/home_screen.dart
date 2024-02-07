import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/entities/task/task_barrel.dart';
import 'package:task_sphere/src/entities/user/user_barrel.dart';
import 'package:task_sphere/src/features/_auth/auth_barrel.dart';
import 'package:task_sphere/src/features/analytics/analytics_barrel.dart';
import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

part 'custom/add_task_floating_button.dart';

part 'custom/drawer.dart';

part 'custom/empty_tasks_widget.dart';

part 'custom/home_header.dart';

part 'custom/home_view.dart';

part 'custom/menu_button.dart';

part 'custom/tasks_filter.dart';

part 'custom/top_contents.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showingDrawer = false;

  final ValueNotifier<double> drawerOffsetNotifier = ValueNotifier<double>(0);

  final double maxDrawerOffset = 212.w;

  void setDrawerOffsetValue(double value) {
    if (drawerOffsetNotifier.value == value) return;
    drawerOffsetNotifier.value = value.capBetween(0, maxDrawerOffset);
  }

  void toggleShowing([bool? show]) {
    return switch (show) {
      true => animate(to: maxDrawerOffset, toTheLeft: false),
      false => animate(to: 0, toTheLeft: true),
      null => drawerOffsetNotifier.value
              .isAroundOrGreaterThan(maxDrawerOffset, offBy: 5)
          ? animate(to: 0, toTheLeft: true)
          : animate(to: maxDrawerOffset, toTheLeft: false),
    };
  }

  void animateToExtreme({bool ifNotAtIt = true}) {
    if (ifNotAtIt) {
      if (drawerOffsetNotifier.value == 0 ||
          drawerOffsetNotifier.value == maxDrawerOffset) {
        return;
      }
    }

    final double extreme = lastDraggedDirectionIsNegative ? 0 : maxDrawerOffset;

    final double differenceValue = lastDraggedDirectionIsNegative
        ? drawerOffsetNotifier.value
        : maxDrawerOffset - drawerOffsetNotifier.value;

    animate(
      to: extreme,
      differenceValue: differenceValue,
      toTheLeft: lastDraggedDirectionIsNegative,
    );
  }

  void animate({
    required double to,
    required bool toTheLeft,
    double? differenceValue,
    int tick = 5,
    Duration duration = const Duration(milliseconds: 150),
  }) {
    final double from = drawerOffsetNotifier.value;
    differenceValue ??= maxDrawerOffset;

    final int maxTick = duration.inMilliseconds;

    Timer.periodic(Duration(milliseconds: tick), (timer) {
      final double tickDiff =
          (differenceValue! * (timer.tick * (tick / maxTick)))
              .capBetween(0, maxDrawerOffset);

      final double nextValue = toTheLeft ? from - tickDiff : from + tickDiff;

      if (timer.tick >= (maxTick / tick)) {
        setDrawerOffsetValue(to);
        timer.cancel();
        return;
      }

      setDrawerOffsetValue(nextValue);
    });
  }

  @override
  void dispose() {
    drawerOffsetNotifier.dispose();
    super.dispose();
  }

  bool lastDraggedDirectionIsNegative = false;

  @override
  Widget build(BuildContext context) {
    return InheritedVanilla<ProgressiveAnalyticsVanilla>(
      createNotifier: () => ProgressiveAnalyticsVanilla()..initialize(),
      child: InheritedVanilla<HomeVanilla>(
        createNotifier: () => HomeVanilla()..initialize(),
        child: Scaffold(
          backgroundColor: context.bgColors.$100,
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onHorizontalDragEnd: (details) => animateToExtreme(),
            onHorizontalDragUpdate: (details) {
              lastDraggedDirectionIsNegative = details.delta.dx.isNegative;

              setDrawerOffsetValue(
                drawerOffsetNotifier.value + details.delta.dx,
              );
            },
            child: ValueListenableBuilder<double>(
              valueListenable: drawerOffsetNotifier,
              builder: (_, drawerOffset, __) {
                drawerOffset = drawerOffset.capBetween(0, maxDrawerOffset);
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Transform.translate(
                      offset: Offset(drawerOffset - maxDrawerOffset, 0),
                      child: _Drawer(
                        drawerOffsetNotifier: drawerOffsetNotifier,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(drawerOffset, 0),
                      child: _HomeView(
                        showDrawer: toggleShowing,
                        drawerOffsetNotifier: drawerOffsetNotifier,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
