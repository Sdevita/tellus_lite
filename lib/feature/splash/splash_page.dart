import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/feature/splash/splash_viewmodel.dart';
import 'package:telluslite/push_notification/push_notification_manager.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  SplashViewModel viewModel;
  StreamSubscription _notificationSubscription;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await viewModel.init(context);
      _notificationSubscription = PushNotificationsManager()
          .notificationStream
          .stream
          .asBroadcastStream()
          .listen((notification) {
        if (notification != null) {
          viewModel.pushNavigation(context, notification);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _notificationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of(context);

    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Text(
          "Tellus",
          style: TextStyle(fontSize: 50, color: Colors.white),
        ),
      ),
    );
  }
}
