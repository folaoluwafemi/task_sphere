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
      backgroundColor: context.palette.bgAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            30.boxHeight,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.m),
              child: TextField(
                decoration: InputDecorations.myDecoration(context.palette),
              ),
            ),
            30.boxHeight,
          ],
        ),
      ),
    );
  }
}
