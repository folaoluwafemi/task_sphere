import 'package:flutter/material.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          VanillaBuilder<ThemeVanilla, ThemeMode>(
            builder: (context, themeMode) {
              print('builder called with change $themeMode');
              return MaterialButton(
                child: Icon(
                  themeMode == ThemeMode.light
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color: themeMode == ThemeMode.dark
                      ? Colors.white
                      : Colors.black87,
                ),
                onPressed: () => context.read<ThemeVanilla>().toggle(),
              );
            },
          ),
          const Center(
            child: Text(
              'Onboarding Screen',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
