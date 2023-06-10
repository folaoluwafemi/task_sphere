import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TaskSphereApp());
}
