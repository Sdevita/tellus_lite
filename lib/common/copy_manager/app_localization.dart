import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  Map<String, String> _sentences;
  Map<String, String> _defaultSentences;

  Future<bool> load() async {
    String data = await rootBundle
        .loadString('assets/lang/${this.locale.toString()}.json');
    String defaultData = await rootBundle.loadString('assets/lang/en_EN.json');
    var defaultCopyLoaded = await _loadDefaultCopy(defaultData);
    var localizedCopy = await _loadLocalizedCopy(data);
    return localizedCopy || defaultCopyLoaded;
  }

  Future<bool> _loadDefaultCopy(String defaultData) async {
    if (defaultData == null) {
      return false;
    }
    Map<String, dynamic> _result = json.decode(defaultData);
    this._defaultSentences = new Map();
    _result.forEach((String key, dynamic value) {
      this._defaultSentences[key] = value.toString();
    });
    print("default copy loaded");
    return _result != null &&
        _defaultSentences != null &&
        _defaultSentences.length > 0;
  }

  Future<bool> _loadLocalizedCopy(String data) async {
    if (data == null) {
      return false;
    }
    Map<String, dynamic> _result = json.decode(data);
    this._sentences = new Map();
    _result.forEach((String key, dynamic value) {
      this._sentences[key] = value.toString();
    });
    print("${this.locale.languageCode} copy loaded");
    return _result != null && _sentences != null && _sentences.length > 0;
  }

  String trans(String key) {
    if (this._sentences.containsKey(key)) {
      return this._sentences[key];
    } else {
      return _loadDefaultValue(key);
    }
  }

  _loadDefaultValue(String key) {
    if (this._defaultSentences.containsKey(key)) {
      return this._defaultSentences[key];
    } else {
      return "";
    }
  }
}
