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
    apiKey: 'AIzaSyB5R7C7KULI_o3cu9TDWKLeplw7NxTo5wc',
    appId: '1:49725548961:web:ddd93123b837a4993e43e0',
    messagingSenderId: '49725548961',
    projectId: 'leavemanagement-ddb45',
    authDomain: 'leavemanagement-ddb45.firebaseapp.com',
    storageBucket: 'leavemanagement-ddb45.appspot.com',
    measurementId: 'G-BDL26CKYJ6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDjvEvqhw0-exV5twAXgDj1zJ4Gao4qK0o',
    appId: '1:49725548961:android:2a413e5ab97303473e43e0',
    messagingSenderId: '49725548961',
    projectId: 'leavemanagement-ddb45',
    storageBucket: 'leavemanagement-ddb45.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBUcdtHvp4IJ0xA9uVyoQ3FJg2Z7Tw0PRs',
    appId: '1:49725548961:ios:9e77911f8f23ffab3e43e0',
    messagingSenderId: '49725548961',
    projectId: 'leavemanagement-ddb45',
    storageBucket: 'leavemanagement-ddb45.appspot.com',
    iosClientId: '49725548961-cposfu5arpmik5bkms6h881bpkajl2ur.apps.googleusercontent.com',
    iosBundleId: 'com.smartreach.leavemanagement',
  );
}
