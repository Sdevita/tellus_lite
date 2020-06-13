import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/base_widget.dart';
import 'package:telluslite/common/widgets/Ec_text.dart';
import 'package:telluslite/common/widgets/appbar/app_navigation_bar.dart';
import 'package:telluslite/common/widgets/slider/tellus_slider.dart';
import 'package:telluslite/feature/map_filters/filters_viewmodel.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  FiltersViewModel viewModel;
  ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    viewModel = Provider.of(context);

    return BaseWidget(
        body: _buildBody(context));
  }

  _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildAppBar(context),
            Row(
              children: <Widget>[
                ECText(
                  "Applied filters".toUpperCase(),
                  fontSize: 14,
                  align: TextAlign.start,
                  fontWeight: FontWeight.w200,
                  color: theme.primaryColor,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  ECText(
                    "Distance".toUpperCase(),
                    fontSize: 14,
                    align: TextAlign.start,
                    fontWeight: FontWeight.w200,
                    color: theme.primaryColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: TellusSlider(
                backgroundColor: theme.buttonColor.withOpacity(.5),
                min: 50,
                max: 1000,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context){
    return AppNavigationBar(
      leftWidget: ECText("Cancel",
          color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
      onLeftWidgetTapped: () {
        viewModel.onCancelTapped(context);
      },
      centerWidget: ECText(
        "Filters",
        align: TextAlign.center,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      rightWidget: ECText(
        "apply",
        color: theme.primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      onRightWidgetTapped: () {
        viewModel.onCancelTapped(context);
      },
    );
  }
}
