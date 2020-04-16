import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/base_widget.dart';

import 'home_viewmodel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<HomeViewModel>(context);
    return BaseWidget(
      loader: viewModel.loader,
      body: GestureDetector(
        child: Text("YEAH"),
        onTap: () { viewModel.getEarthquakes();},
      ),
    );
  }
}
