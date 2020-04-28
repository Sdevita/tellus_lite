import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:telluslite/common/theme/theme_changer.dart';
import 'package:telluslite/feature/home/home_page.dart';
import 'package:telluslite/feature/home/home_viewmodel.dart';
import 'package:telluslite/push_notification/push_notification_manager.dart';

import 'common/theme/Themes.dart';
import 'navigation/Routes.dart';

void main() async {
  Routes.createRoutes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    PushNotificationsManager().init();
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) {
        ThemeChanger themeChanger = ThemeChanger();
        themeChanger.setLightMode(context);
        return themeChanger;
      },
      child: MaterialAppWithTheme()
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme.themeData,
      home: ChangeNotifierProvider(
        create: (_) => HomeViewModel(),
        child: HomePage(),
      ),
      navigatorKey: Routes.sailor.navigatorKey,
      onGenerateRoute: Routes.sailor.generator(),
      navigatorObservers: [
        SailorLoggingObserver(),
      ],
    );
  }

}
