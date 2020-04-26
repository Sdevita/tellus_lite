import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:telluslite/common/base_viewmodel.dart';
import 'package:telluslite/common/widgets/Dialogs.dart';
import 'package:telluslite/network/model/response/feature.dart';
import 'package:telluslite/network/model/response/ingv_response.dart';
import 'package:telluslite/network/repositories/earthquake_repository.dart';

class HomeViewModel extends BaseViewModel {
  List<Feature> _earthquakeList;
  GoogleMapController _mapController;
  Geolocator _geolocator;
  Position _currentPosition;
  Set<Marker> _markers;
  bool showMapLoader = true;

  init(BuildContext context) async {
    _geolocator = Geolocator();
    onGetMyLocation();
    _getEarthquakes(context);
  }

  onGetMyLocation() async {
    _currentPosition = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    if (_currentPosition != null) {
      var camera = CameraPosition(
          target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          zoom: 7);
      _mapController.moveCamera(CameraUpdate.newCameraPosition(camera));
    }
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
    String mapPath = 'assets/map_style/grey_map.json';
    String style = await rootBundle.loadString(mapPath);
    _mapController.setMapStyle(style);
  }

  setMapStyle(String stylePath) async {
    _showMapLoader(true);
    String style = await rootBundle.loadString(stylePath);
    _showMapLoader(false);
    _mapController.setMapStyle(style);
  }

  _getEarthquakes(BuildContext context) async {
    EarthquakeRepository repository = EarthquakeRepository();
    IngvResponse response = await repository.getEarthQuakes();
    _showMapLoader(false);
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

  GoogleMapController get mapController => _mapController;

  LatLng get initialPosition {
    if (_currentPosition == null) {
      return LatLng(41.89193, 12.51133);
    }

    return LatLng(_currentPosition.latitude, _currentPosition.longitude);
  }

  Set<Marker> get markers => _markers;
}
