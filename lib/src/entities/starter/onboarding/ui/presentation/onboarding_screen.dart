import 'package:flutter/material.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: context.palette.primary,
      ),
      backgroundColor: context.palette.bgAccent.withOpacity(0.5),
      body: Center(
        child: Transform.scale(
          scale: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TabPill.monochrome(
                text: 'ALL (15)',
                state: TabPillState.inactive,
                onPressed: () {},
              ),
              30.boxHeight,
              const TabPill.monochrome(
                text: 'ALL (15)',
                state: TabPillState.active,
              ),
              30.boxHeight,
              const TabPill.colored(
                text: 'ALL (15)',
                state: TabPillState.selected,
              ),
              30.boxHeight,
              const TabPill.colored(
                text: 'ALL (15)',
                state: TabPillState.unselected,
              ),
              30.boxHeight,
            ],
          ),
        ),
      ),
    );
  }
}
