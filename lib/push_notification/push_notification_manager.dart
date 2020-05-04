import 'dart:developer' as developer;

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  bool _initialized = false;

  String _token;

  String get token => _token;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      await _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.onIosSettingsRegistered
          .listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });
      await _firebaseMessaging.subscribeToTopic("tellus");
      _firebaseMessaging.configure(
        //onBackgroundMessage: Platform.isIOS ? null : backgroundMessageHandler,
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        },
      );

      // For testing purposes print the Firebase Messaging token
      _token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $_token");
      developer.log("FirebaseMessaging token: $_token");

      _initialized = true;
    }
  }

  static Future<dynamic> backgroundMessageHandler(
      Map<String, dynamic> message) {
    print("_backgroundMessageHandler");
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      print("_backgroundMessageHandler data: ${data}");
    }
  }
}
