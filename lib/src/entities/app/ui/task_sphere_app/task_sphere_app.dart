import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'custom/task_sphere_wrapper.dart';

class TaskSphereApp extends StatelessWidget {
  const TaskSphereApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TaskSphereWrapper(
      child: VanillaBuilder<ThemeVanilla, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: AppTheme.light,
            darkTheme: ThemeData.dark().copyWith(
              primaryColor: Colors.black87.withBlue(255),
            ),
            routerConfig: AppRouter.routerConfig,
          );
        },
      ),
    );
  }
}
