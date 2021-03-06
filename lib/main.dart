import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/theme/theme_changer.dart';
import 'package:telluslite/push_notification/push_notification_manager.dart';

import 'common/copy_manager/app_localization_delegate.dart';
import 'common/theme/Themes.dart';
import 'feature/splash/splash_page.dart';
import 'feature/splash/splash_viewmodel.dart';
import 'navigation/Routes.dart';

void main() async {
  Routes.createRoutes();
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
  Widget build(BuildContext context) {
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
      navigatorKey: Routes.sailor.navigatorKey,
      onGenerateRoute: Routes.sailor.generator(),
      supportedLocales: getSupportedLocale(),
      localizationsDelegates: getLocalizationsDelegate(),
      home : ChangeNotifierProvider<SplashViewModel>(
          create: (_) => SplashViewModel(), child: SplashPage())
    );
  }

  // add here new supported locale
  List<Locale> getSupportedLocale() {
    List<Locale> supportedLocales = List();
    supportedLocales.add(Locale('en', 'EN'));
    supportedLocales.add(Locale('it', 'IT'));

    return supportedLocales;
  }

  List<LocalizationsDelegate> getLocalizationsDelegate() {
    List<LocalizationsDelegate> localizationDelegates = List();
    localizationDelegates.add(AppLocalizationsDelegate());
    localizationDelegates.add(GlobalMaterialLocalizations.delegate);
    localizationDelegates.add(GlobalCupertinoLocalizations.delegate);
    return localizationDelegates;
  }

  ///
  Locale searchLocaleFromLanguage(Locale locale, List<Locale> lista) {
    for (Locale l in lista) {
      if (l.languageCode == locale.languageCode) {
        return l;
      }
    }
    return null;
  }

  @override
  void didChangePlatformBrightness() {
    print(WidgetsBinding.instance.window
        .platformBrightness); // should print Brightness.light / Brightness.dark when you switch
    super.didChangePlatformBrightness(); // make sure you call this
  }
}
