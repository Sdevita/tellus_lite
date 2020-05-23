import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:telluslite/common/base_viewmodel.dart';
import 'package:telluslite/common/widgets/Dialogs.dart';
import 'package:telluslite/navigation/Routes.dart';
import 'package:telluslite/network/model/response/feature.dart';
import 'package:telluslite/network/model/response/ingv_response.dart';
import 'package:telluslite/network/repositories/earthquake_repository.dart';

enum MapState { Map, Details, Notification }

class MapViewModel extends BaseViewModel {
  List<Feature> _earthquakeList;
  PageController pageController = PageController(viewportFraction: 0.8);
  GoogleMapController _mapController;
  Geolocator _geolocator;
  Position _currentPosition;
  bool _isDarkMode = false;
  Set<Marker> _markers;
  bool showMapLoader = true;
  MapState _homeState = MapState.Map;
  Map<String, dynamic> notificationModel;

  MapViewModel({this.notificationModel});

  init(BuildContext context, bool isDarkMode) async {
    _showMapLoader(true);
    _geolocator = Geolocator();
    _isDarkMode = isDarkMode;
    await onGetMyLocation();
    await showNotificationDetails();
    await _getEarthquakes(context);
    pageController.addListener(() {
      int currentIndex = pageController.page.toInt();
      var latitude = _earthquakeList[currentIndex]?.geometry?.coordinates[1];
      var longitude = _earthquakeList[currentIndex]?.geometry?.coordinates[0];
      _showDetail(latitude, longitude, false);
    });
    _showMapLoader(false);
  }

  onGetMyLocation() async {
    _currentPosition = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    if (_currentPosition != null &&
        _mapController != null &&
        notificationModel == null) {
      var camera = CameraPosition(
          target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          zoom: 7);
      _mapController?.moveCamera(CameraUpdate.newCameraPosition(camera));
    }
  }

  showNotificationDetails() async {
    if (notificationModel == null) {
      return;
    }

    if (notificationModel.containsKey('data')) {
      _homeState = MapState.Notification;
      var data = notificationModel['data'];
      var lat = double.parse(data['latitude']);
      var lon = double.parse(data['longitude']);
      await _showDetail(lat, lon, true);
    } else {
      // from on message
      var lat = double.parse(notificationModel['latitude']);
      var lon = double.parse(notificationModel['longitude']);
      await _showDetail(lat, lon, true);
    }
  }

  _showDetail(double lat, double lon, bool isFromNotification) async {
    var camera = CameraPosition(target: LatLng(lat, lon), zoom: 8);
    await _mapController.animateCamera(CameraUpdate.newCameraPosition(camera));
    if (isFromNotification) {
      notificationModel = null;
    }
    notifyListeners();
  }

  onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _setMapStyle();
    _setMarkers();
  }

  _showMapLoader(bool loader) {
    showMapLoader = loader;
    notifyListeners();
  }

  _setMarkers() {
    if (_earthquakeList == null) {
      return;
    }
    _markers = Set();
    _earthquakeList.forEach((feature) => _markers.add(_createMarker(feature)));
    notifyListeners();
  }

  _createMarker(Feature feature) {
    var latitude = feature?.geometry?.coordinates[1];
    var longitude = feature?.geometry?.coordinates[0];
    return Marker(
      markerId: MarkerId(feature.properties.eventId.toString() ?? 0),
      position: LatLng(latitude, longitude),
    );
  }

  _setMapStyle() async {
    String mapPath = _isDarkMode
        ? 'assets/map_style/blue_dark_map.json'
        : 'assets/map_style/x_spot_style.json';
    String style = await rootBundle.loadString(mapPath);
    _mapController.setMapStyle(style);
  }

  setMapStyle(bool isDarkMode) async {
    String stylePath = _isDarkMode
        ? 'assets/map_style/blue_dark_map.json'
        : 'assets/map_style/x_spot_style.json';
    _showMapLoader(true);
    String style = await rootBundle.loadString(stylePath);
    _showMapLoader(false);
    _mapController.setMapStyle(style);
  }

  _getEarthquakes(BuildContext context) async {
    EarthquakeRepository repository = EarthquakeRepository();
    IngvResponse response = await repository.getEarthQuakes(
      _currentPosition.longitude,
      _currentPosition.latitude,
    );

    if (response != null) {
      _handleResponse(response, context);
    }
  }

  _handleResponse(IngvResponse response, BuildContext context) {
    if (response.error != null && response.error.isNotEmpty) {
      Dialogs.showDefaultAlert(context);
    } else {
      _earthquakeList = response.features;
      _setMarkers();
    }
  }

  List<Feature> get earthquakeList {
    if (_earthquakeList != null) {
      return _earthquakeList;
    } else {
      return List();
    }
  }

  LatLng get initialPosition {
    if (_currentPosition == null) {
      return LatLng(41.89193, 12.51133);
    }

    return LatLng(_currentPosition.latitude, _currentPosition.longitude);
  }

  goToSettings(BuildContext context) async {
    var isDarkMode =
        await Navigator.of(context).pushNamed(Routes.settingsRoute);
    setMapStyle(isDarkMode);
  }

  goToFilters(BuildContext context) async {
    Navigator.of(context).pushNamed(
      Routes.mapFilters,
    );
  }

  Set<Marker> get markers => _markers;

  Position get currentPosition => _currentPosition;

  GoogleMapController get mapController => _mapController;
}
