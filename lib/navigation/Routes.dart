import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:telluslite/feature/drawer_menu/drawer_viewmodel.dart';
import 'package:telluslite/feature/login/login_page.dart';
import 'package:telluslite/feature/login/login_viewmodel.dart';
import 'package:telluslite/feature/map/map_page.dart';
import 'package:telluslite/feature/map/map_viewmodel.dart';
import 'package:telluslite/feature/map_filters/filters_screen.dart';
import 'package:telluslite/feature/map_filters/filters_viewmodel.dart';
import 'package:telluslite/feature/settings_page/settings.dart';
import 'package:telluslite/feature/settings_page/settings_viewmodel.dart';
import 'package:telluslite/feature/splash/splash_page.dart';
import 'package:telluslite/feature/splash/splash_viewmodel.dart';

class Routes {
  static final sailor = Sailor(
      options: SailorOptions(
          defaultTransitions: [SailorTransition.slide_from_right]));

  static const String settingsRoute = "/settings";
  static const String map = "/map";
  static const String login = "/login";
  static const String mapFilters = "/mapFilters";
  static const String splash = "/";

  static bool isCurrent(String routeName) {
    bool isCurrent = false;
    sailor.navigatorKey.currentState.popUntil((route) {
      print(route.settings.name);
      print(routeName);
      if (route.settings.name == routeName) {
        isCurrent = true;
        print("isTrue");
      }
      return true;
    });
    print("isCurrent: $isCurrent");
    return isCurrent;
  }

  static void createRoutes() {
    // MAP ROUTE
    sailor.addRoute(SailorRoute(
      name: map,
      builder: (context, args, params) {
        final Map<String, dynamic> notification = params.param("notification");
        return ChangeNotifierProvider(
          create: (_) => DrawerViewModel(),
          child: ChangeNotifierProvider(
            create: (_) => notification != null
                ? MapViewModel(notificationModel: notification)
                : MapViewModel(),
            child: MapPage(),
          ),
        );
      },
      params: [
        SailorParam<Map<String, dynamic>>(
            name: "notification", isRequired: false)
      ],
    ));

    // SETTINGS ROUTE
    sailor.addRoute(SailorRoute(
        name: settingsRoute,
        builder: (context, args, params) {
          return ChangeNotifierProvider(
            create: (_) => DrawerViewModel(),
            child: ChangeNotifierProvider<SettingsViewModel>(
              create: (_) => SettingsViewModel(),
              child: Settings(),
            ),
          );
        }));

    // SPLASH ROUTE
    sailor.addRoute(SailorRoute(
        name: splash,
        builder: (context, args, params) {
          return ChangeNotifierProvider<SplashViewModel>(
              create: (_) => SplashViewModel(), child: SplashPage());
        }));

    // LOGIN ROUTE
    sailor.addRoute(SailorRoute(
        name: login,
        builder: (context, args, params) {
          return ChangeNotifierProvider<LoginViewModel>(
            create: (_) => LoginViewModel(),
            child: LoginPage(),
          );
        }));

    // MAP FILTERS ROUTE
    sailor.addRoute(SailorRoute(
        name: mapFilters,
        builder: (context, args, params) {
          return ChangeNotifierProvider<FiltersViewModel>(
            create: (_) => FiltersViewModel(),
            child: FiltersScreen(),
          );
        },
        defaultTransitions: [SailorTransition.slide_from_bottom],
        defaultTransitionCurve: Curves.fastLinearToSlowEaseIn));
  }

}
