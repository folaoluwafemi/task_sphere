import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_sphere/firebase_options.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart' show StorageKeys;

abstract final class ApiClientsSetup {
  static Future<void> setup() async {
    await Hive.initFlutter();
    await Hive.openBox<List>(StorageKeys.analysis.box);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: false,
    );
  }
}
