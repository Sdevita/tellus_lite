import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/theme/theme_changer.dart';
import 'package:telluslite/common/widgets/Ec_text.dart';
import 'package:telluslite/feature/splash/splash_viewmodel.dart';
import 'package:telluslite/persistent/repositories/secure_store_repository.dart';
import 'package:telluslite/push_notification/push_notification_manager.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with WidgetsBindingObserver {
  SplashViewModel viewModel;
  ThemeChanger themeChanger;
  StreamSubscription _notificationSubscription;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkDarkMode(context);
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

  _checkDarkMode(BuildContext context) async {
    SecureStoreRepository secureStoreRepository = SecureStoreRepository();
    bool isDarkMode = await secureStoreRepository.hasDarkModeSaved();
    if (isDarkMode) {
      themeChanger?.setDarkMode(context);
    }
  }

  @override
  void dispose() {
    _notificationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of(context);
    themeChanger = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: ECText(
          "Tellus",
          fontSize: 50,
          fontWeight: FontWeight.w400,
          autoResize: true,
          color: Colors.white,
        ),
      ),
    );
  }
}
