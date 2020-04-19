import 'package:flutter/material.dart';
import 'package:telluslite/common/base_widget.dart';
import 'package:telluslite/common/widgets/app_bar.dart';
import 'package:telluslite/navigation/Routes.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        appBar: TellusAppBar(
          leftIcon: Icons.arrow_back_ios, onLeftButtonTapped: () {
          Routes.sailor.pop();
        },),
        body: Center(
    child: Text("Settings"),)
    ,
    );
  }
}
