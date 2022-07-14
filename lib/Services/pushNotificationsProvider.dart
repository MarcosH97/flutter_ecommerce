import 'package:firebase_messaging/firebase_messaging.dart';

class PushNProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _firebaseMessagingOnResume = FirebaseMessaging.onMessageOpenedApp;
  final _firebaseMessagingOnMessage = FirebaseMessaging.onMessage;
  initNotifications() {
    _firebaseMessaging.requestPermission();

    _firebaseMessaging.getToken().then((token) {
      print("NOTIFICATION TOKEN: " + token.toString());

      // fRdRnUhrTYmeT_sW9Vu73-:APA91bEOjWYFHp6uWfw5PlvoDhQv2UXSsMv-qzxVqBJXJ6lO3jPgIwL_b6XcKPB9ESF0JF-p9NPZ8bQLGjJSxlep3w4_eEE1PYkGLEMGV2G2cBDE2Q49rgTh9Wv9KUm_zqxaWqnoEory
    });
    _firebaseMessagingOnMessage.listen((event) {});

    _firebaseMessagingOnResume.listen((event) {});
  }
}
