import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/theme/theme_changer.dart';
import 'common/theme/Themes.dart';
import 'navigation/Routes.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return ChangeNotifierProvider<ThemeChanger>(
        create: (_) {
          ThemeChanger themeChanger = ThemeChanger();
          themeChanger.setLightMode(context);
          return themeChanger;
        },
        child: MaterialAppWithTheme());
  }
}

class MaterialAppWithTheme extends StatelessWidget with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme.themeData,
      darkTheme: Themes.darkTheme(context),
      initialRoute: Routes.login,
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
