// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAIxLN56uFPvl7B--gq4zWQZ1lXjkA65Ec',
    appId: '1:549933558018:web:eb0e0e25115ecbd2a7fa1b',
    messagingSenderId: '549933558018',
    projectId: 'gymsystem-cbe58',
    authDomain: 'gymsystem-cbe58.firebaseapp.com',
    storageBucket: 'gymsystem-cbe58.firebasestorage.app',
    measurementId: 'G-W471SJZRQ2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAaK0PDFX3EwTT1cL2Ryf9X9NWv5ID6c3E',
    appId: '1:549933558018:android:fd3b31c46cd1801ba7fa1b',
    messagingSenderId: '549933558018',
    projectId: 'gymsystem-cbe58',
    storageBucket: 'gymsystem-cbe58.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANl-WEKZLtXXUbeTBg0mP4OU6uzQDfYWs',
    appId: '1:549933558018:ios:a94cd2901423e402a7fa1b',
    messagingSenderId: '549933558018',
    projectId: 'gymsystem-cbe58',
    storageBucket: 'gymsystem-cbe58.firebasestorage.app',
    iosBundleId: 'com.example.gymsystem',
  );
}
