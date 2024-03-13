// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
/// 
/// 
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
    apiKey: 'AIzaSyD0XhQAXfanVJVE7cu7QY3qxSojAWDWGD4',
    appId: '1:644895036873:web:7680864ffa0f8e2e4d8418',
    messagingSenderId: '644895036873',
    projectId: 'workersniffs',
    authDomain: 'workersniffs.firebaseapp.com',
    storageBucket: 'workersniffs.appspot.com',
    measurementId: 'G-4MF5ESE4N8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQ3E-eiwSRV0i4OoyLcnwuFoL9F8hNbiA',
    appId: '1:644895036873:android:078dec883358905e4d8418',
    messagingSenderId: '644895036873',
    projectId: 'workersniffs',
    storageBucket: 'workersniffs.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCH4L2Vuj38ajgqoYNbnsht3f1X2dQwbUQ',
    appId: '1:644895036873:ios:29e85916373908824d8418',
    messagingSenderId: '644895036873',
    projectId: 'workersniffs',
    storageBucket: 'workersniffs.appspot.com',
    iosBundleId: 'com.example.flutterWorkerSniffs',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCH4L2Vuj38ajgqoYNbnsht3f1X2dQwbUQ',
    appId: '1:644895036873:ios:fc41e2cff8f0c8684d8418',
    messagingSenderId: '644895036873',
    projectId: 'workersniffs',
    storageBucket: 'workersniffs.appspot.com',
    iosBundleId: 'com.example.flutterWorkerSniffs.RunnerTests',
  );
}
