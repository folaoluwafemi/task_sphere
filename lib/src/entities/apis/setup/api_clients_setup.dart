import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_sphere/firebase_options.dart';

abstract final class ApiClientsSetup {
  static Future<void> setup() async {
    await _setupFirebase();
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
