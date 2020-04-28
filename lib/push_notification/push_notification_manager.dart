import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer' as developer;

class PushNotificationsManager {

  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance = PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  bool _initialized = false;

  String _token;

  String get token => _token;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      // For testing purposes print the Firebase Messaging token
      _token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $_token");
      developer.log("FirebaseMessaging token: $_token");

      _initialized = true;
    }
  }
}