import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/theme/theme_changer.dart';
import 'package:telluslite/push_notification/push_notification_manager.dart';

import 'common/theme/Themes.dart';
import 'navigation/Routes.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    PushNotificationsManager().init();
    return ChangeNotifierProvider<ThemeChanger>(
        create: (_) {
          ThemeChanger themeChanger = ThemeChanger();
          themeChanger.setLightMode(context);
          return themeChanger;
        },
        child: MaterialAppWithTheme());
  }
}

class MaterialAppWithTheme extends StatefulWidget {
  @override
  _MaterialAppWithThemeState createState() => _MaterialAppWithThemeState();
}

class _MaterialAppWithThemeState extends State<MaterialAppWithTheme>
    with WidgetsBindingObserver {
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");

  StreamSubscription _notificationSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notificationSubscription = PushNotificationsManager()
          .notificationStream
          .stream
          .asBroadcastStream()
          .listen((notification) {
        if (notification != null) {
          _goToMapView(context, notification);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme.themeData,
      darkTheme: Themes.darkTheme(context),
      initialRoute: Routes.login,
      onGenerateRoute: Routes.generateRoute,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _notificationSubscription?.cancel();
  }

  @override
  void didChangePlatformBrightness() {
    print(WidgetsBinding.instance.window
        .platformBrightness); // should print Brightness.light / Brightness.dark when you switch
    super.didChangePlatformBrightness(); // make sure you call this
  }

  _goToMapView(BuildContext context, Map<String, dynamic> notificationModel) {
    navigatorKey.currentState.pushNamedAndRemoveUntil(
        Routes.home, (route) => false,
        arguments: notificationModel);
  }
}
