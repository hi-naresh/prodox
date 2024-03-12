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
    apiKey: 'AIzaSyCnbgWOAXonbMlMoDLWknXqySHs94xjf3A',
    appId: '1:1017842887963:web:83715f0ca374c92a6ff7be',
    messagingSenderId: '1017842887963',
    projectId: 'prodox-bae03',
    authDomain: 'prodox-bae03.firebaseapp.com',
    storageBucket: 'prodox-bae03.appspot.com',
    measurementId: 'G-B1J1TCYM78',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJ9JOb_qZw3Z9ChLJtvi4jBfJCaFqWTK8',
    appId: '1:1017842887963:android:c6639c78543bd5f86ff7be',
    messagingSenderId: '1017842887963',
    projectId: 'prodox-bae03',
    storageBucket: 'prodox-bae03.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6lN5YS76GNaZpqhH6r5WgSbiIfZrduUo',
    appId: '1:1017842887963:ios:3e833f9af0d204516ff7be',
    messagingSenderId: '1017842887963',
    projectId: 'prodox-bae03',
    storageBucket: 'prodox-bae03.appspot.com',
    androidClientId: '1017842887963-61oaptao85shsuvtajlgur1bt9to6kjl.apps.googleusercontent.com',
    iosClientId: '1017842887963-di608udf2chbne82av1cien4633avc9r.apps.googleusercontent.com',
    iosBundleId: 'com.prodox.beta.prodox',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD6lN5YS76GNaZpqhH6r5WgSbiIfZrduUo',
    appId: '1:1017842887963:ios:63a379e1091f060b6ff7be',
    messagingSenderId: '1017842887963',
    projectId: 'prodox-bae03',
    storageBucket: 'prodox-bae03.appspot.com',
    androidClientId: '1017842887963-61oaptao85shsuvtajlgur1bt9to6kjl.apps.googleusercontent.com',
    iosClientId: '1017842887963-kk0nph3e5deuq8ue378v5gp4i5n533j6.apps.googleusercontent.com',
    iosBundleId: 'com.prodox.beta.prodox.prodox.RunnerTests',
  );
}
