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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init(context);
      print(themeChanger.isDarkModeTheme);
    });
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<HomeViewModel>(context);
    themeChanger = Provider.of(context);
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
      alignment:
          Alignment(0.0, -((MediaQuery.of(context).padding.top / 100) + 0.45)),
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
                onPressed: () {},
                splashColor: Colors.transparent,
                icon: Icon(Icons.menu, color: Theme.of(context).accentColor,),
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
          bottom: (MediaQuery.of(context).size.height * 0.17) -
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
      alignment: Alignment(0.0, 1.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.17,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0)),
            color: Theme.of(context).backgroundColor),
      ),
    );
  }

  _buildBottomMenu() {
    return Align(
      alignment: Alignment(0.0, 0.84),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                child: Icon(
                  Icons.map,
                  color: Theme.of(context).accentColor,
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
                  color: Theme.of(context).accentColor,
                  size: 35,
                ),
                onPressed: (){
                  themeChanger.setDarkMode(context);
                  viewModel.setMapStyle("assets/map_style/blue_dark_map.json");
                },
                shape: CircleBorder(),
              ),
              MaterialButton(
                child: Icon(
                  Icons.message,
                  color: Theme.of(context).accentColor,
                  size: 35,
                ),
                onPressed: () {
                  themeChanger.setLightMode(context);
                  viewModel.setMapStyle("assets/map_style/grey_map.json");
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
