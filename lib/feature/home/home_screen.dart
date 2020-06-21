import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/widgets/button/tl_button.dart';
import 'package:telluslite/feature/drawer_menu/drawer_widget.dart';
import 'package:telluslite/feature/home/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: DrawerMenu(child: _buildBody(context)),
    );
  }

  _buildBody(BuildContext context) {
    return Container(
      child: Center(
        child: TLButton(
          text: "menu",
          onTap: () {
            viewModel.onMenuClicked(context);
          },
        ),
      ),
    );
  }
}
