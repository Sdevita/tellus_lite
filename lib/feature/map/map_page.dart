import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/theme/theme_changer.dart';

import 'map_viewmodel.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with WidgetsBindingObserver {
  MapViewModel viewModel;
  ThemeChanger themeChanger;
  ThemeData theme;
  double bottomPadding;
  Alignment bottomAlignment;
  Alignment topAlignment;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init(context, themeChanger.isDarkModeTheme);
    });
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<MapViewModel>(context);
    themeChanger = Provider.of(context);
    theme = Theme.of(context);
    double mqPTop = MediaQuery.of(context).padding.top;
    bottomPadding = MediaQuery.of(context).padding.bottom;
    bottomAlignment = Alignment(0.0, 1 - (bottomPadding + 40) / 1000);
    topAlignment = Alignment(0.0, -(1 - ((mqPTop + 60) / 1000)));

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildMap(context),
          _buildHeader(context),
          _buildBottomWidget(context)
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  viewModel.goToSettings(context);
                },
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.settings,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Visibility(
                visible: !viewModel.showMapLoader,
                child: Text(
                  "Tellus",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Visibility(
                visible: viewModel.showMapLoader,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    backgroundColor: theme.primaryColor,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  viewModel.goToFilters(context);
                },
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.filter_list,
                  color: theme.primaryColor,
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
      /* padding: EdgeInsets.only(
          bottom: (MediaQuery.of(context).size.height * 0.11) -
              MediaQuery.of(context).padding.bottom),*/
      initialCameraPosition:
          CameraPosition(target: viewModel.initialPosition, zoom: 7),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: true,
      markers: viewModel.markers,
      onMapCreated: (GoogleMapController controller) {
        viewModel.onMapCreated(controller);
      },
    );
  }

  _buildBottomWidget(BuildContext context) {
    return Align(
      alignment: Alignment(0.0, 0.9),
      child: FractionallySizedBox(
        heightFactor: 0.2,
        child: PageView.builder(
          itemCount: viewModel.earthquakeList.length,
          // store this controller in a State to save the carousel scroll position
          controller: viewModel.pageController,
          itemBuilder: (BuildContext context, int itemIndex) {
            return _buildCarouselItem(context, 1, itemIndex);
          },
        ),
      ),
    );
  }

  Widget _buildCarouselItem(
      BuildContext context, int carouselIndex, int itemIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Text(viewModel.earthquakeList[itemIndex].properties.place),
      ),
    );
  }
}
