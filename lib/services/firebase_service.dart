import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static Future<void> init() async {
    await Firebase.initializeApp();
    // Enable offline persistence
    FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
  }
}
