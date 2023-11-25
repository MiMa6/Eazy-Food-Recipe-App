// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDz1Hnpx-6xRksubC45oDGjjbcFpw9zPeM',
    appId: '1:472283287056:web:bd8e11d941860e5d0e4495',
    messagingSenderId: '472283287056',
    projectId: 'receipe-app-43857',
    authDomain: 'receipe-app-43857.firebaseapp.com',
    storageBucket: 'receipe-app-43857.appspot.com',
    measurementId: 'G-Y8BZV8QJFE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZ0MT5IpptfBzEfsQ-BxqZP-50oibTMTk',
    appId: '1:472283287056:android:76fbc63100d107390e4495',
    messagingSenderId: '472283287056',
    projectId: 'receipe-app-43857',
    storageBucket: 'receipe-app-43857.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAiKzOGSqm3FmcgD9X-bOt7RPNdYm0b7iw',
    appId: '1:472283287056:ios:7a0896c1f399f99d0e4495',
    messagingSenderId: '472283287056',
    projectId: 'receipe-app-43857',
    storageBucket: 'receipe-app-43857.appspot.com',
    iosBundleId: 'com.example.recipeApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAiKzOGSqm3FmcgD9X-bOt7RPNdYm0b7iw',
    appId: '1:472283287056:ios:49ae82b550dc87a80e4495',
    messagingSenderId: '472283287056',
    projectId: 'receipe-app-43857',
    storageBucket: 'receipe-app-43857.appspot.com',
    iosBundleId: 'com.example.recipeApp.RunnerTests',
  );
}