import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'custom/app_wrapper.dart';

class TaskSphereApp extends StatelessWidget {
  const TaskSphereApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.routerConfig,
    );
  }
}
