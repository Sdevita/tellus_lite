import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/base_widget.dart';
import 'package:telluslite/common/widgets/appbar/app_navigation_bar.dart';
import 'package:telluslite/common/widgets/slider/tellus_slider.dart';
import 'package:telluslite/feature/map_filters/filters_viewmodel.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  FiltersViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of(context);
    return BaseWidget(
      appBar: AppNavigationBar(
        leftWidget: Text(
          "Cancel",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        onLeftWidgetTapped: () {
          viewModel.onCancelTapped(context);
        },
        centerWidget: Text(
          "Filters",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        rightWidget: Text(
          "apply",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onRightWidgetTapped: () {
          viewModel.onCancelTapped(context);
        },
      ),
      body: Center(
        child: TellusSlider(
          onChanged: (value) {},
        ),
      ),
    );
  }
}
