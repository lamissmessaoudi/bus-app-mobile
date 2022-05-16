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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBdu0YWtHaquE345_6pXut19rdG7sw7Vig',
    appId: '1:511175768670:web:0e97737368b14f82a5d2cf',
    messagingSenderId: '511175768670',
    projectId: 'softun-bus-14211',
    authDomain: 'softun-bus-14211.firebaseapp.com',
    databaseURL: 'https://softun-bus-14211-default-rtdb.firebaseio.com',
    storageBucket: 'softun-bus-14211.appspot.com',
    measurementId: 'G-46XSJ305Y0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDV6vNpgFrSQ_1pLeNjg_luDZzOrrf6hls',
    appId: '1:511175768670:android:49339c94b77880daa5d2cf',
    messagingSenderId: '511175768670',
    projectId: 'softun-bus-14211',
    databaseURL: 'https://softun-bus-14211-default-rtdb.firebaseio.com',
    storageBucket: 'softun-bus-14211.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwMxX9p9jMGYgkfRFJGcnxLGWeX3tZh98',
    appId: '1:511175768670:ios:e59674ed389082b0a5d2cf',
    messagingSenderId: '511175768670',
    projectId: 'softun-bus-14211',
    databaseURL: 'https://softun-bus-14211-default-rtdb.firebaseio.com',
    storageBucket: 'softun-bus-14211.appspot.com',
    iosClientId: '511175768670-j2roansu1icgjn34m5bjulfthfobbsqb.apps.googleusercontent.com',
    iosBundleId: 'com.example.softunBusMobile',
  );
}