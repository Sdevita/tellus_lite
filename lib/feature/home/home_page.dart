import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/theme/theme_changer.dart';

import 'home_viewmodel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel;
  ThemeChanger themeChanger;
  double bottomPadding;
  Alignment bottomAlignment;
  Alignment topAlignment;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init(context, themeChanger.isDarkModeTheme);
    });
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<HomeViewModel>(context);
    themeChanger = Provider.of(context);

    double mqPTop = MediaQuery.of(context).padding.top;
    bottomPadding = MediaQuery.of(context).padding.bottom;
    bottomAlignment = Alignment(0.0, 1 - (bottomPadding + 40) / 1000);
    topAlignment = Alignment(0.0, -(1 - ((mqPTop + 60) / 1000)));

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildMap(context),
          _buildContainer(context),
          _buildBottomMenu(),
          _buildHeader(context),
        ],
      ),
    );
  }

  _buildHeader(BuildContext context) {
    return Align(
      alignment: topAlignment,
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Theme.of(context).backgroundColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  viewModel.goToSettings(context);
                },
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Visibility(
                visible: viewModel.showMapLoader,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildMap(BuildContext context) {
    return GoogleMap(
      padding: EdgeInsets.only(
          bottom: (MediaQuery.of(context).size.height * 0.11) -
              MediaQuery.of(context).padding.bottom),
      initialCameraPosition:
          CameraPosition(target: viewModel.initialPosition, zoom: 7),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      markers: viewModel.markers,
      onMapCreated: (GoogleMapController controller) {
        viewModel.onMapCreated(controller);
      },
    );
  }

  _buildContainer(BuildContext context) {
    return Align(
      alignment: bottomAlignment,
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: MediaQuery.of(context).size.height * 0.08,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.width * 0.3),
            color: Theme.of(context).backgroundColor),
      ),
    );
  }

  _buildBottomMenu() {
    return Align(
      alignment: bottomAlignment,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                child: Icon(
                  Icons.map,
                  color: Theme.of(context).primaryColor,
                  size: 35,
                ),
                onPressed: () {
                  viewModel.onGetMyLocation();
                },
                shape: CircleBorder(),
              ),
              MaterialButton(
                child: Icon(
                  Icons.multiline_chart,
                  color: Theme.of(context).primaryColor,
                  size: 35,
                ),
                onPressed: () {
                  themeChanger.setDarkMode(context);
                  viewModel.setMapStyle("assets/map_style/blue_dark_map.json");
                },
                shape: CircleBorder(),
              ),
              MaterialButton(
                child: Icon(
                  Icons.message,
                  color: Theme.of(context).primaryColor,
                  size: 35,
                ),
                onPressed: () {
                  themeChanger.setLightMode(context);
                  viewModel.setMapStyle("assets/map_style/x_spot_style.json");
                },
                shape: CircleBorder(),
              ),
            ]),
      ),
    );
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
