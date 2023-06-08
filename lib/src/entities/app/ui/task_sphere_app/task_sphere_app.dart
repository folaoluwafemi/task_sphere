import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'custom/task_sphere_wrapper.dart';

class TaskSphereApp extends StatelessWidget {
  const TaskSphereApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('building');
    return TaskSphereWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        builder: (context, child) => ResponsivenessWrapper(
          designSize: const Size(390, 844),
          useMediaQuery: true,
          builder: (context) => Theme(
            data: AppTheme.light,
            child: child!,
          ),
        ),
        color: AppColors.orange,
        routerConfig: AppRouter.routerConfig,
      ),
    );
  }
}
