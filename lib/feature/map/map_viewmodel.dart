import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:telluslite/common/base_viewmodel.dart';
import 'package:telluslite/common/constants/app_constants.dart';
import 'package:telluslite/common/helpers/map_screen_helper.dart';
import 'package:telluslite/common/widgets/Dialogs.dart';
import 'package:telluslite/navigation/Routes.dart';
import 'package:telluslite/network/model/response/feature.dart';
import 'package:telluslite/network/model/response/ingv_response.dart';
import 'package:telluslite/network/repositories/earthquake_repository.dart';
import 'package:telluslite/network/repositories/firestore_repository.dart';
import 'package:telluslite/persistent/models/user_configuration.dart';

enum MapState { Map, Details, Notification }

class MapViewModel extends BaseViewModel {
  List<Feature> _earthquakeList;
  Feature _selectedEvent;
  PageController pageController = PageController(viewportFraction: 0.8);
  GoogleMapController _mapController;
  Geolocator _geolocator;
  bool _isDrawerOpened = false;
  bool _isMapVisible = true;
  Position _currentPosition;
  bool _isDarkMode = false;
  bool _isMarkerTapped = false;
  Set<Marker> _markers;
  bool showMapLoader = true;
  MapState _mapState = MapState.Map;
  Map<String, dynamic> notificationModel;
  MediaQueryData mediaQuery;
  double detailsCardHeight;
  double headerWidth;
  String headerTitle = AppConstants.APP_NAME;
  UserConfiguration _userConfiguration;

  MapViewModel({this.notificationModel});

  init(BuildContext context, bool isDarkMode) async {
    _isDarkMode = isDarkMode;
    mediaQuery = MediaQuery.of(context);
    _geolocator = Geolocator();
    showLoader();
    await _getUserConfiguration();
    await onGetMyLocation();
    await showNotificationDetails();
    await _getEarthquakes(context);
    pageController.addListener(() {
      _onPageScroll();
    });
    hideLoader();
  }

  _onPageScroll() {
    if (!_isMarkerTapped) {
      int currentIndex = pageController.page.toInt();
      var latitude = _earthquakeList[currentIndex]?.geometry?.coordinates[1];
      var longitude = _earthquakeList[currentIndex]?.geometry?.coordinates[0];
      _showDetail(latitude, longitude, false);
    }
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

  _getUserConfiguration() async {
    FireStoreRepository fireStoreRepository = FireStoreRepository();
    _userConfiguration = await fireStoreRepository.loadUserConfiguration();
  }

  showNotificationDetails() async {
    if (notificationModel == null) {
      return;
    }

    if (notificationModel.containsKey('data')) {
      _mapState = MapState.Notification;
      var data = notificationModel['data'];
      var lat = double.parse(data['latitude']);
      var lon = double.parse(data['longitude']);
      await _showDetail(lat, lon, true);
    } else {
      // from on message
      _mapState = MapState.Notification;
      var lat = double.parse(notificationModel['latitude']);
      var lon = double.parse(notificationModel['longitude']);
      await _showDetail(lat, lon, true);
    }
  }

  _showDetail(double lat, double lon, bool isFromNotification) async {
    var camera;
    if (_mapState == MapState.Details || _mapState == MapState.Notification) {
      detailsCardHeight = mediaQuery.size.height / 3;
      headerWidth = mediaQuery.size.width - 50;
      camera = CameraPosition(target: LatLng(lat, lon), zoom: 14);
    } else {
      camera = CameraPosition(target: LatLng(lat, lon), zoom: 8);
      detailsCardHeight = 0;
      headerWidth = mediaQuery.size.width / 2;
    }
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

  openDrawer(BuildContext context) {
    onMenuClicked(context);
    _isDrawerOpened = true;
    _isMapVisible = false;
    notifyListeners();
  }

  void onDrawerClosed(bool withNavigation) {
    if (!withNavigation) {
      _isDrawerOpened = false;
      notifyListeners();
    }
  }

  _showMapLoader(bool loader) {
    showMapLoader = loader;
    notifyListeners();
  }

  _setMarkers() async {
    if (_earthquakeList == null) {
      return;
    }
    var icon = await MapScreenHelper.getMarker();
    _markers = Set();
    _earthquakeList
        .forEach((feature) => _markers.add(_createMarker(feature, icon)));
    notifyListeners();
  }

  _createMarker(Feature feature, icon) {
    var latitude = feature?.geometry?.coordinates[1];
    var longitude = feature?.geometry?.coordinates[0];
    return Marker(
        markerId: MarkerId(feature.properties.eventId.toString() ?? 0),
        position: LatLng(latitude, longitude),
        icon: icon,
        onTap: () async {
          _isMarkerTapped = true;
          _selectedEvent = feature;
          if (_mapState == MapState.Details) {
            _showDetail(latitude, longitude, false);
          }
          await pageController.animateToPage(_earthquakeList.indexOf(feature),
              duration: Duration(milliseconds: 500), curve: Curves.decelerate);
          _isMarkerTapped = false;
        });
  }

  _setMapStyle() async {
    String mapPath = _isDarkMode
        ? 'assets/map_style/blue_dark_map.json'
        : 'assets/map_style/x_spot_style.json';
    String style = await rootBundle.loadString(mapPath);
    _mapController.setMapStyle(style);
  }

  setMapStyle(bool isDarkMode) async {
    String stylePath = isDarkMode
        ? 'assets/map_style/blue_dark_map.json'
        : 'assets/map_style/x_spot_style.json';
    _showMapLoader(true);
    String style = await rootBundle.loadString(stylePath);
    _showMapLoader(false);
    _mapController.setMapStyle(style);
  }

  onTopTapped(int index) {
    if (_mapState != MapState.Details) {
      _mapState = MapState.Details;
      _selectedEvent = _earthquakeList[index];
      _updateUI();
    }
  }

  onCloseDetail() {
    _mapState = MapState.Map;
    _updateUI();
  }

  _updateUI() {
    switch (_mapState) {
      case MapState.Map:
        _mapController.animateCamera(CameraUpdate.zoomTo(8));
        detailsCardHeight = 0;
        headerWidth = mediaQuery.size.width / 2;
        break;
      case MapState.Details:
        var latitude = _selectedEvent?.geometry?.coordinates[1];
        var longitude = _selectedEvent?.geometry?.coordinates[0];
        _showDetail(latitude, longitude, false);
        break;
      case MapState.Notification:
        var latitude = _selectedEvent?.geometry?.coordinates[1];
        var longitude = _selectedEvent?.geometry?.coordinates[0];
        _showDetail(latitude, longitude, false);
        break;
    }
    notifyListeners();
  }

  _getEarthquakes(BuildContext context) async {
    if (_userConfiguration != null) {
      EarthquakeRepository repository = EarthquakeRepository();
      IngvResponse response = await repository.getEarthQuakes(
          _currentPosition.longitude, _currentPosition.latitude,
          minDepth: _userConfiguration?.minDepth?.toDouble(),
          minMag: _userConfiguration?.minMagnitude?.toDouble(),
          numberOfDay: _userConfiguration?.maxEta,
          maxRadiusKm: _userConfiguration?.maxRadiusKm);

      if (response != null) {
        _handleResponse(response, context);
      }
    }
  }

  _handleResponse(IngvResponse response, BuildContext context) {
    if (response.hasError && response.error.isNotEmpty) {
      Routes.sailor.navigate(Routes.noDataAlert);
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

  goToFilters(BuildContext context) async {
    bool update = await Routes.sailor.navigate(Routes.mapFilters);
    if (update) {
      await _reloadMap(context);
    }
  }

  _reloadMap(BuildContext context) async {
    showLoader();
    await _getUserConfiguration();
    await _getEarthquakes(context);
    hideLoader();
    notifyListeners();
    _resetZoom();
  }

  _resetZoom() {
    if (_currentPosition != null && _mapController != null) {
      var camera = CameraPosition(
          target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          zoom: 7);
      _mapController.animateCamera(CameraUpdate.newCameraPosition(camera));
    }
  }

  showMap() {
    _isMapVisible = true;
    notifyListeners();
  }

  Set<Marker> get markers => _markers;

  Position get currentPosition => _currentPosition;

  GoogleMapController get mapController => _mapController;

  MapState get state => _mapState;

  Feature get selectedEvent => _selectedEvent;

  bool get isDrawerOpened => _isDrawerOpened;

  bool get isMapVisible => _isMapVisible;
}
