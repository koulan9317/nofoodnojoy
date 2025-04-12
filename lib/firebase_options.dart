// ignore_for_file: constant_identifier_names

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyDGpF5v66LS1vLsSEEZfMuNT8Mq9aPi5gI",
    authDomain: "nofoodnojoy.firebaseapp.com",
    projectId: "nofoodnojoy",
    storageBucket: "nofoodnojoy.firebasestorage.app",
    messagingSenderId: "471291820662",
    appId: "1:471291820662:web:eb4f455221545df9d53d57",
  );
}
