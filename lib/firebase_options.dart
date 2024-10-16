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
    apiKey: 'AIzaSyALSDJA-WP17vmu4mLThdHeuN20yG6mNKU',
    appId: '1:375816575279:web:71dac5368e7dd8075ee9da',
    messagingSenderId: '375816575279',
    projectId: 'apac-task',
    authDomain: 'apac-task.firebaseapp.com',
    storageBucket: 'apac-task.appspot.com',
    measurementId: 'G-9EYJ5NBCK4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBsWDvtValIlQD1KglEQXzo6HxqWCIZ-kI',
    appId: '1:375816575279:android:a4d6123f7c6957285ee9da',
    messagingSenderId: '375816575279',
    projectId: 'apac-task',
    storageBucket: 'apac-task.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCWPWoPmLv0qSS6T2CnfZ5ZowplgqVjEjQ',
    appId: '1:375816575279:ios:31de0216efb759c15ee9da',
    messagingSenderId: '375816575279',
    projectId: 'apac-task',
    storageBucket: 'apac-task.appspot.com',
    iosBundleId: 'com.apac.ecommerce.apacECommerce',
  );
}
