import 'package:flutter/material.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart'
    show ApiClientsSetup, TaskSphereApp;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiClientsSetup.setup();
  runApp(const TaskSphereApp());
}
