import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TaskSphereApp());
}

asdla() {
  Parse().initialize(
    appId,
    serverUrl,
  );
}
