import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyB3lsctqG-kPJWKqvGqfivQxgnA9jWx-QM',
        authDomain: '',
        projectId: 'e-commerce-9687',
        storageBucket: 'e-commerce-9687.firebasestorage.app',
        messagingSenderId: 'your-sender-id',
        appId: '1:512482198797:android:2b4672f409778a967a9c44',
        measurementId: 'your-measurement-id',
        databaseURL: "https://e-commerce-9687-default-rtdb.firebaseio.com/",
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      // Firebase configuration for Android
      return const FirebaseOptions(
        apiKey: 'AIzaSyB3lsctqG-kPJWKqvGqfivQxgnA9jWx-QM',
        authDomain: '',
        projectId: 'e-commerce-9687',
        storageBucket: 'e-commerce-9687.firebasestorage.app',
        messagingSenderId: 'your-sender-id',
        appId: '1:512482198797:android:2b4672f409778a967a9c44',
        measurementId: 'your-measurement-id',
        databaseURL: "https://e-commerce-9687-default-rtdb.firebaseio.com/",
      );
    }
    // Add configurations for other platforms (iOS, Android) if needed
    throw UnsupportedError('Unsupported platform');
  }
}
