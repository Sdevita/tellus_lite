import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/theme/theme_changer.dart';
import 'package:telluslite/persistent/repositories/secure_store_repository.dart';
import 'package:telluslite/push_notification/push_notification_manager.dart';

import 'common/theme/Themes.dart';
import 'navigation/Routes.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var dark = await SecureStoreRepository().hasDarkModeSaved();
      setState(() {
        isDarkMode = dark;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return ChangeNotifierProvider<ThemeChanger>(
        create: (_) {
          ThemeChanger themeChanger = ThemeChanger();
          isDarkMode
              ? themeChanger.setLightMode(context)
              : themeChanger.setLightMode(context);
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
  @override
  void initState() {
    PushNotificationsManager().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme.themeData,
      darkTheme: Themes.darkTheme(context),
      initialRoute: Routes.splash,
      onGenerateRoute: Routes.generateRoute,
    );
  }

  @override
  void didChangePlatformBrightness() {
    print(WidgetsBinding.instance.window
        .platformBrightness); // should print Brightness.light / Brightness.dark when you switch
    super.didChangePlatformBrightness(); // make sure you call this
  }
}
