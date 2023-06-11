import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'custom/drawer.dart';

part 'custom/home_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void showDrawer() {
    toggleShowing();
  }

  bool showingDrawer = false;

  final ValueNotifier<double> drawerOffsetNotifier = ValueNotifier<double>(0);

  final double maxDrawerOffset = 212.w;

  void setDrawerOffsetValue(double value) {
    if (drawerOffsetNotifier.value == value) return;
    drawerOffsetNotifier.value = value;
  }

  void toggleShowing([bool? show]) {
    return switch (show) {
      true => animate(to: maxDrawerOffset, toTheLeft: false),
      false => animate(to: 0, toTheLeft: true),
      null => drawerOffsetNotifier.value.isAround(maxDrawerOffset, offBy: 5)
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
    int tick = 25,
    Duration duration = const Duration(milliseconds: 200),
  }) {
    differenceValue ??= maxDrawerOffset;

    final int maxTick = duration.inMilliseconds;

    double currentOffsetValue = drawerOffsetNotifier.value;

    final double tickDiffValue = differenceValue * (tick / maxTick);

    Timer.periodic(Duration(milliseconds: tick), (timer) {
      currentOffsetValue = toTheLeft
          ? currentOffsetValue - tickDiffValue
          : currentOffsetValue + tickDiffValue;

      if (timer.tick >= maxTick / tick) {
        setDrawerOffsetValue(to);
        timer.cancel();
      }

      setDrawerOffsetValue(currentOffsetValue);
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
    return Scaffold(
      backgroundColor: context.bgColors.$100,
      body: Stack(
        children: [
          GestureDetector(
            onHorizontalDragEnd: (details) => animateToExtreme(),
            onHorizontalDragUpdate: (details) {
              lastDraggedDirectionIsNegative = details.delta.dx.isNegative;

              setDrawerOffsetValue(
                drawerOffsetNotifier.value + details.delta.dx,
              );
            },
            child: Container(
              color: context.palette.primary.withOpacity(0.2),
              width: context.screenWidth,
              height: context.screenHeight,
            ),
          ),
          ValueListenableBuilder<double>(
            valueListenable: drawerOffsetNotifier,
            builder: (_, drawerOffset, __) {
              drawerOffset = drawerOffset.capBetween(0, maxDrawerOffset);
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Transform.translate(
                    offset: Offset(drawerOffset - maxDrawerOffset, 0),
                    child: _Drawer(),
                  ),
                  Transform.translate(
                    offset: Offset(drawerOffset, 0),
                    child: _HomeView(
                      showDrawer: showDrawer,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
