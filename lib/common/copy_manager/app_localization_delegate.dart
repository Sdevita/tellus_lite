import 'package:flutter/material.dart';

import 'app_localization.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    List<String> listaLocale = List();
    listaLocale.add("en_EN");
    listaLocale.add("it_IT");

    if (listaLocale.contains(locale.toString())) {
      return true;
    }

    return false;
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    print("[StringManager] Load ${locale.languageCode} configuration ");
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
