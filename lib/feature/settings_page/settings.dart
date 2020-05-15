import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/base_widget.dart';
import 'package:telluslite/common/theme/theme_changer.dart';
import 'package:telluslite/common/widgets/appbar/app_bar.dart';
import 'package:telluslite/feature/settings_page/settings_viewmodel.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsViewModel viewModel;
  ThemeChanger themeChanger;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of(context);
    themeChanger = Provider.of(context);
    return BaseWidget(
      loader: viewModel.loader,
      appBar: TellusAppBar(
        leftIcon: Icons.arrow_back_ios,
        onLeftButtonTapped: () {
          Navigator.of(context).pop();
        },
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          _buildLogoutButton(context),
          _buildNotificationButton(context),
          _buildDarkModeToggle()
        ],
      )),
    );
  }

  _buildDarkModeToggle() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "Enable dark mode",
            style: TextStyle(fontSize: 16),
          ),
          CupertinoSwitch(
            activeColor: Theme.of(context).buttonColor,
            value: viewModel.switchValue,
            onChanged: (isDarkMode) {
              if (isDarkMode) {
                themeChanger.setDarkMode(context);
              } else {
                themeChanger.setLightMode(context);
              }
              viewModel.onSwitchChange(isDarkMode);
            },
          ),
        ],
      ),
    );
  }

  _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: SizedBox(
        height: 40.0,
        width: MediaQuery.of(context).size.width / 2,
        child: RaisedButton(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Theme.of(context).buttonColor,
          child: Text(
            'Log out'.toUpperCase(),
            style:
                TextStyle(color: Theme.of(context).accentColor, fontSize: 15),
          ),
          onPressed: () {
            viewModel.logout(context);
          },
        ),
      ),
    );
  }

  _buildNotificationButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: SizedBox(
        height: 40.0,
        width: MediaQuery.of(context).size.width / 2,
        child: RaisedButton(
          elevation: 5.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Theme.of(context).buttonColor,
          child: Text(
            'Enable notification'.toUpperCase(),
            style:
                TextStyle(color: Theme.of(context).accentColor, fontSize: 15),
          ),
          onPressed: () {
            viewModel.enableNotification();
          },
        ),
      ),
    );
  }
}
