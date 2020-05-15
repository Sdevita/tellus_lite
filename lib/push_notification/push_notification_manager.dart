import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  StreamController<Map<String, dynamic>> notificationStream;

  bool _initialized = false;

  String _token;

  String get token => _token;

  Future<void> enable() async {
    if (!_initialized) {
      if (Platform.isIOS) {
        // For iOS request permission first.
        await _firebaseMessaging.requestNotificationPermissions();
        _firebaseMessaging.onIosSettingsRegistered
            .listen((IosNotificationSettings settings) {
          print("Settings registered: $settings");
        });
      }
      // For testing purposes print the Firebase Messaging token
      _token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $_token");
      developer.log("FirebaseMessaging token: $_token");
      await _firebaseMessaging.subscribeToTopic("tellus");

      _initialized = true;
    }
  }

  // NOTE call ever before enable()
  void init() {
    notificationStream = StreamController();

    _firebaseMessaging.configure(
      //onBackgroundMessage: Platform.isIOS ? null : backgroundMessageHandler,
      onMessage: (Map<String, dynamic> message) async {
        developer.log("onMessage: $message");
        notificationStream.sink.add(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        developer.log("onLaunch: $message");
        notificationStream.sink.add(message);
      },
      onResume: (Map<String, dynamic> message) async {
        developer.log("onResume: $message");
        notificationStream.sink.add(message);
      },
    );
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
