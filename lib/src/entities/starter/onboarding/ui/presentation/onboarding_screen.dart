import 'package:flutter/material.dart';
import 'package:task_sphere/src/entities/app/ui/components/modals/modal_card.dart';
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
      // backgroundColor: context.neutralColors.$100,
      backgroundColor: context.palette.secondary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            30.boxHeight,
            30.boxHeight,
            Center(
              child: Transform.scale(
                scale: 1,
                child: const ModalCard(
                  height: 98,
                  width: 400,
                  child: Column(
                    children: [],
                  ),
                ),
              ),
            ),
            60.boxHeight,
          ],
        ),
      ),
    );
  }
}
