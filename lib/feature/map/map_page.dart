import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:telluslite/common/theme/theme_changer.dart';
import 'package:telluslite/common/widgets/map/card/earthquake_list_card.dart';

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
  MediaQueryData mq;
  double detailBoxHeight;
  double headerWidth;

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
    mq = MediaQuery.of(context);
    double mqPTop = MediaQuery.of(context).padding.top;
    bottomPadding = MediaQuery.of(context).padding.bottom;
    bottomAlignment = Alignment(0.0, 1 - (bottomPadding + 40) / 1000);
    topAlignment = Alignment(0.0, -(1 - ((mqPTop + 60) / 1000)));
    detailBoxHeight = viewModel.detailsCardHeight ?? 0;
    headerWidth = viewModel.headerWidth ?? mq.size.width / 2;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildMap(context),
          _buildHeader(context),
          _buildBottomWidget(context),
          _buildDetails(context),
        ],
      ),
    );
  }

  _buildHeader(BuildContext context) {
    return Align(
      alignment: topAlignment,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInCirc,
        width: headerWidth,
        onEnd: () {
          //viewModel.changeHeaderTitle();
        },
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            color: Theme.of(context).backgroundColor),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              !viewModel.showMapLoader
                  ? Flexible(
                      child: Text(
                        viewModel.headerTitle,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 20, color: theme.primaryColor),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        backgroundColor: theme.primaryColor,
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
      child: Container(
        height: mq.size.height / 5.5,
        child: PageView.builder(
          itemCount: viewModel.earthquakeList.length,
          // store this controller in a State to save the carousel scroll position
          controller: viewModel.pageController,
          itemBuilder: (BuildContext context, int itemIndex) {
            var event = viewModel.earthquakeList[itemIndex];
            return EarthQuakeListCard(
              title: event.properties.place,
              magnitude: event.properties.mag,
              onTopTapped: () {
                viewModel.onTopTapped(itemIndex);
              },
            );
          },
        ),
      ),
    );
  }

  _buildDetails(BuildContext context) {
    var event = viewModel?.selectedEvent;
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInCirc,
        height: detailBoxHeight,
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 16,
              top: 16,
              child: Container(
                constraints: BoxConstraints(maxWidth: mq.size.width * 0.8),
                child: Text(
                  event?.properties?.place ?? "",
                  style: TextStyle(fontSize: 18, color: theme.primaryColor),
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: IconButton(
                onPressed: () {
                  viewModel.onCloseDetail();
                },
                icon: Icon(
                  Icons.clear,
                  color: theme.primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
