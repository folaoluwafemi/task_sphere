import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_sphere/firebase_options.dart';
import 'package:task_sphere/src/utils/constants/constants_barrel.dart';

abstract final class ApiClientsSetup {
  static Future<void> setup() async {
    await _setupHive();
    await _setupFirebase();
  }

  static Future<void> _setupHive() async {
    await Hive.initFlutter();

    Hive.openBox<Map>(StorageKeys.authCredentials.box);
    Hive.openBox<Map>(StorageKeys.user.box);
  }

  static Future<void> _setupFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: false,
    );
  }
}
