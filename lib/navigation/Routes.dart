import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:telluslite/feature/settings_page/settings.dart';
import 'package:telluslite/feature/settings_page/settings_viewmodel.dart';

class Routes {
  static final sailor = Sailor(
      options: SailorOptions(
          defaultTransitions: [SailorTransition.slide_from_right]));

  static final String settingsRoute = "/settings";

  static void createRoutes() {
    sailor.addRoute(SailorRoute(
      name: settingsRoute,
      builder: (context, args, params) {
        return ChangeNotifierProvider<SettingsViewModel>(
            create: (_) => SettingsViewModel(), child: Settings());
      },
    ));
  }
}
