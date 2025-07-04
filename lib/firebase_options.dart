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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBuQDP59rNuymAQ8M6hLEQmkid5lADV7IQ',
    appId: '1:1080273996839:web:078f20bc8cdcf0e5f91202',
    messagingSenderId: '1080273996839',
    projectId: 'lets-stream-c09e3',
    authDomain: 'lets-stream-c09e3.firebaseapp.com',
    storageBucket: 'lets-stream-c09e3.firebasestorage.app',
    measurementId: 'G-3H0XKRKCYX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDgW2XVC4YhB9wwhe8JxrcX-uFZ0RY6W-o',
    appId: '1:1080273996839:android:474376ff255d817df91202',
    messagingSenderId: '1080273996839',
    projectId: 'lets-stream-c09e3',
    storageBucket: 'lets-stream-c09e3.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBx5FOHBYyy9qYZatBZbG10HovQgwLtGmw',
    appId: '1:1080273996839:ios:7af0b636f58f8f5ef91202',
    messagingSenderId: '1080273996839',
    projectId: 'lets-stream-c09e3',
    storageBucket: 'lets-stream-c09e3.firebasestorage.app',
    iosClientId: '1080273996839-3n5ag98e0c7o8gecctn3ij8tjr8ct60l.apps.googleusercontent.com',
    iosBundleId: 'com.example.letsstreamFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBx5FOHBYyy9qYZatBZbG10HovQgwLtGmw',
    appId: '1:1080273996839:ios:7af0b636f58f8f5ef91202',
    messagingSenderId: '1080273996839',
    projectId: 'lets-stream-c09e3',
    storageBucket: 'lets-stream-c09e3.firebasestorage.app',
    iosClientId: '1080273996839-3n5ag98e0c7o8gecctn3ij8tjr8ct60l.apps.googleusercontent.com',
    iosBundleId: 'com.example.letsstreamFlutter',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBuQDP59rNuymAQ8M6hLEQmkid5lADV7IQ',
    appId: '1:1080273996839:web:99896dc243678237f91202',
    messagingSenderId: '1080273996839',
    projectId: 'lets-stream-c09e3',
    authDomain: 'lets-stream-c09e3.firebaseapp.com',
    storageBucket: 'lets-stream-c09e3.firebasestorage.app',
    measurementId: 'G-WYQNR6FFXZ',
  );
}
