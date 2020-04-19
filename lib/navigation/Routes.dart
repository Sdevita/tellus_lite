import 'package:sailor/sailor.dart';
import 'package:telluslite/feature/settings_page/settings.dart';

class Routes{
  static final sailor = Sailor();

  static final String settingsRoute = "/settings";

  static void createRoutes() {
    sailor.addRoute(SailorRoute(
      name: settingsRoute,
      builder: (context, args, params) {
        return Settings();
      },
    ));
  }
}