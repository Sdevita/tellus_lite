import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/base_widget.dart';
import 'package:telluslite/common/widgets/app_bar.dart';
import 'package:telluslite/feature/settings_page/settings_viewmodel.dart';
import 'package:telluslite/navigation/Routes.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SettingsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of(context);
    return BaseWidget(
      loader: viewModel.loader,
      appBar: TellusAppBar(
        leftIcon: Icons.arrow_back_ios,
        onLeftButtonTapped: () {
          Navigator.of(context).pop();
        },
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          width: MediaQuery.of(context).size.width / 2,
          child: RaisedButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Theme.of(context).buttonColor,
            child: Text(
              'Log out'.toUpperCase(),
              style:
                  TextStyle(color: Theme.of(context).accentColor, fontSize: 15),
            ),
            onPressed: () { viewModel.logout(context);},
          ),
        ),
      )),
    );
  }
}
