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

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  HomeViewModel viewModel;
  ThemeChanger themeChanger;
  double bottomPadding;
  Alignment bottomAlignment;
  Alignment topAlignment;
  int _selectedIndex = 0;

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
          _buildHeader(context),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
          child: BottomNavigationBar(
            elevation: 5,
            backgroundColor: Theme.of(context).backgroundColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                title: Text('Business'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                title: Text('School'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Theme.of(context).primaryColor,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
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
                    backgroundColor: Theme.of(context).primaryColor,
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
                  color: Theme.of(context).primaryColor,
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
