import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/feature/home/home_page.dart';
import 'package:telluslite/feature/home/home_viewmodel.dart';
import 'package:telluslite/feature/login/login_page.dart';
import 'package:telluslite/feature/login/login_viewmodel.dart';
import 'package:telluslite/feature/settings_page/settings.dart';
import 'package:telluslite/feature/settings_page/settings_viewmodel.dart';

class Routes {
  static const String settingsRoute = "/settings";
  static const String home = "/home";
  static const String login = "/login";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => HomeViewModel(),
            child: HomePage(),
          ),
        );
      case settingsRoute:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<SettingsViewModel>(
                create: (_) => SettingsViewModel(), child: Settings()));
      case login:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<LoginViewModel>(
                create: (_) => LoginViewModel(), child: LoginPage()));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
