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
    apiKey: 'AIzaSyBvu2PyyTKD2pZHtRfCJxg8NBL0Xjt4yzM',
    appId: '1:146517873593:web:9a0fd01d613ed54aacdc68',
    messagingSenderId: '146517873593',
    projectId: 'flutter-osemeador-51045',
    authDomain: 'flutter-osemeador-51045.firebaseapp.com',
    storageBucket: 'flutter-osemeador-51045.appspot.com',
    measurementId: 'G-PW8SNG26EC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAAZaorjQ8X8NJI1ILIQCG2XgNH3r2vvpE',
    appId: '1:146517873593:android:8641d046ef5d94eaacdc68',
    messagingSenderId: '146517873593',
    projectId: 'flutter-osemeador-51045',
    storageBucket: 'flutter-osemeador-51045.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBcMvR_ijGHYEOiNZa3CADSETimx2UolsE',
    appId: '1:146517873593:ios:12bb8f91ce2162c7acdc68',
    messagingSenderId: '146517873593',
    projectId: 'flutter-osemeador-51045',
    storageBucket: 'flutter-osemeador-51045.appspot.com',
    iosBundleId: 'com.example.flutterosemeador',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBcMvR_ijGHYEOiNZa3CADSETimx2UolsE',
    appId: '1:146517873593:ios:12bb8f91ce2162c7acdc68',
    messagingSenderId: '146517873593',
    projectId: 'flutter-osemeador-51045',
    storageBucket: 'flutter-osemeador-51045.appspot.com',
    iosBundleId: 'com.example.flutterosemeador',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBvu2PyyTKD2pZHtRfCJxg8NBL0Xjt4yzM',
    appId: '1:146517873593:web:ba86e656f1562363acdc68',
    messagingSenderId: '146517873593',
    projectId: 'flutter-osemeador-51045',
    authDomain: 'flutter-osemeador-51045.firebaseapp.com',
    storageBucket: 'flutter-osemeador-51045.appspot.com',
    measurementId: 'G-G46MEXPFNP',
  );
}