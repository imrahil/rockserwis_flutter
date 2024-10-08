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
    apiKey: 'AIzaSyDfdaTKVzVxYp23m43-GKzglcboSjDWdFs',
    appId: '1:833618886347:web:2bfe82dcf517ec749be54e',
    messagingSenderId: '833618886347',
    projectId: 'rockcaster',
    authDomain: 'rockcaster.firebaseapp.com',
    storageBucket: 'rockcaster.appspot.com',
    measurementId: 'G-PBSDE2883V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1doVY_iYqlTXuwgwEWHJMnqMAfX7L2DA',
    appId: '1:833618886347:android:697e3e508e8615e19be54e',
    messagingSenderId: '833618886347',
    projectId: 'rockcaster',
    storageBucket: 'rockcaster.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCY7TblL6PV9Bg_HT_LaN4q57fk7AWNNa4',
    appId: '1:833618886347:ios:72f6d20404ec8c3b9be54e',
    messagingSenderId: '833618886347',
    projectId: 'rockcaster',
    storageBucket: 'rockcaster.appspot.com',
    iosBundleId: 'com.imrahil.rockserwisPodcaster',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCY7TblL6PV9Bg_HT_LaN4q57fk7AWNNa4',
    appId: '1:833618886347:ios:72f6d20404ec8c3b9be54e',
    messagingSenderId: '833618886347',
    projectId: 'rockcaster',
    storageBucket: 'rockcaster.appspot.com',
    iosBundleId: 'com.imrahil.rockserwisPodcaster',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDfdaTKVzVxYp23m43-GKzglcboSjDWdFs',
    appId: '1:833618886347:web:84f65fc00a9bee1e9be54e',
    messagingSenderId: '833618886347',
    projectId: 'rockcaster',
    authDomain: 'rockcaster.firebaseapp.com',
    storageBucket: 'rockcaster.appspot.com',
    measurementId: 'G-S9HX1Q7JWM',
  );

}