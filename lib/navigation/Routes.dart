import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/feature/home/home_page.dart';
import 'package:telluslite/feature/home/home_viewmodel.dart';
import 'package:telluslite/feature/login/login_page.dart';
import 'package:telluslite/feature/login/login_viewmodel.dart';
import 'package:telluslite/feature/map_filters/filters_screen.dart';
import 'package:telluslite/feature/map_filters/filters_viewmodel.dart';
import 'package:telluslite/feature/settings_page/settings.dart';
import 'package:telluslite/feature/settings_page/settings_viewmodel.dart';
import 'package:telluslite/feature/splash/splash_page.dart';
import 'package:telluslite/feature/splash/splash_viewmodel.dart';

class Routes {
  static const String settingsRoute = "/settings";
  static const String home = "/home";
  static const String login = "/login";
  static const String mapFilters = "/mapFilters";
  static const String splash = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        final Map<String, dynamic> notification = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => notification != null
                ? HomeViewModel(notificationModel: notification)
                : HomeViewModel(),
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
      case mapFilters:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ChangeNotifierProvider<FiltersViewModel>(
            create: (_) => FiltersViewModel(),
            child: FiltersScreen(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case splash:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<SplashViewModel>(
                create: (_) => SplashViewModel(), child: SplashPage()));
    }
  }
}
