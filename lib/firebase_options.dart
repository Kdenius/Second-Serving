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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAh6wYaj5yRNC6kISgNvUjXQyAJohsup94',
    appId: '1:134168287655:web:996170bb008e7331527e82',
    messagingSenderId: '134168287655',
    projectId: 'secondserving-6fde9',
    authDomain: 'secondserving-6fde9.firebaseapp.com',
    storageBucket: 'secondserving-6fde9.appspot.com',
    measurementId: 'G-KF7XC9B0EY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_o4R0VrhnhO-6dxnDNoIeuM0aHMz5zlE',
    appId: '1:134168287655:android:bcc2d63c00c09e98527e82',
    messagingSenderId: '134168287655',
    projectId: 'secondserving-6fde9',
    storageBucket: 'secondserving-6fde9.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAh6wYaj5yRNC6kISgNvUjXQyAJohsup94',
    appId: '1:134168287655:web:ea4dada489a780d6527e82',
    messagingSenderId: '134168287655',
    projectId: 'secondserving-6fde9',
    authDomain: 'secondserving-6fde9.firebaseapp.com',
    storageBucket: 'secondserving-6fde9.appspot.com',
    measurementId: 'G-833LM20RT4',
  );
}
