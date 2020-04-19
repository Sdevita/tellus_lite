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
        body: viewModel.earthquakeList.isEmpty
            ? Center(
                child: RaisedButton(
                  elevation: 5,
                  color: Colors.red,
                  child: Text("Get earthquakes"),
                  onPressed: () {
                    viewModel.getEarthquakes(context);
                  },
                ),
              )
            : _buildList(context));
  }

  _buildList(BuildContext context) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('${viewModel.earthquakeList[index].properties.place}'),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: viewModel.earthquakeList.length);
  }
}
