import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medication_app_v0/core/constants/app_constants/app_constants.dart';
import 'package:mobx/mobx.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:medication_app_v0/core/init/services/pharmacy_service.dart';
import 'package:medication_app_v0/views/pharmacy/model/pharmacy_model.dart';

part 'pharmacy_viewmodel.g.dart';

class PharmacyViewModel = _PharmacyViewModelBase with _$PharmacyViewModel;

abstract class _PharmacyViewModelBase with Store, BaseViewModel {
  PharmacyService _pharmacyServiceNew;
  GoogleMapController googleMapController;
  @observable
  List<Pharmacy> pharmacies = [];

  Pharmacy closestPharmacy;

  @observable
  bool isLoading = false;

  static final CameraPosition _defaultMapCoordinates =
      CameraPosition(target: AppConstants.TURKEY_CENTER_LAT_LONG, zoom: 7);

  void setContext(BuildContext context) => this.context = context;
  void init() async {
    changeLoading();
    _pharmacyServiceNew = new PharmacyService();
    pharmacies = await getPharmacy();
    await getClosestPharmacy();
    closestPharmacy = theClosestPharmacyModel();
    changeLoading();
  }

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  Future<List<Pharmacy>> getPharmacy() async {
    final Response result =
        await _pharmacyServiceNew.getPharmacyByPlace("karşıyaka", "izmir");
    final List<Pharmacy> pharmacies = [];
    if (result.statusCode == 200) {
      //error check gerekli belki liste boş mu diye bakılabilir.
      final Iterable iterable = result.data['result'];
      iterable.forEach((pharmacy) {
        print(pharmacy);
        pharmacies.add(Pharmacy.fromJson(pharmacy));
      });
    }
    return pharmacies;
  }

  Future<Position> getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    print(position);
    return position;
  }

  @action
  Future<void> getClosestPharmacy() async {
    Position userPosition = await getCurrentLocation();
    for (int i = 0; i < pharmacies.length; i++) {
      double distance = calculateDistance(
          double.parse(pharmacies[i].lat),
          double.parse(pharmacies[i].long),
          userPosition.latitude,
          userPosition.longitude);
      pharmacies[i].distance = distance;
    }
    pharmacies.sort((a, b) => (a.distance - b.distance).toInt());
  }

  double calculateDistance(
      startLatitude, startLongitude, endLatitude, endLongitude) {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  GoogleMap displayPharmacyOnMap() {
    try {
      return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: pharmacyToCameraPosition(closestPharmacy),
        onMapCreated: (map) {
          mapsInit(map);
        },
        markers: _createMarker(),
      );
    } catch (e) {
      return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _defaultMapCoordinates,
        onMapCreated: (map) {
          mapsInit(map);
        },
      );
    }
  }

  void goToPharmacy(Pharmacy p) {
    googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(pharmacyToCameraPosition(p)));
  }

  Pharmacy theClosestPharmacyModel() {
    if (pharmacies.isEmpty) return null;
    Pharmacy closest = pharmacies.first;
    for (Pharmacy pharmacy in pharmacies) {
      if (closest.distance > pharmacy.distance) {
        closest = pharmacy;
      }
    }
    return closest;
  }

  CameraPosition pharmacyToCameraPosition(Pharmacy pharmacy) {
    return CameraPosition(
        target: LatLng(
            double.tryParse(pharmacy.lat), double.tryParse(pharmacy.long)),
        zoom: 19.151926040649414);
  }

  void mapsInit(GoogleMapController controller) {
    this.googleMapController = controller;
  }

  Set<Marker> _createMarker() {
    return pharmacies
        .map((element) => Marker(
            markerId: MarkerId(element.hashCode.toString()),
            position: LatLng(
                double.tryParse(element.lat), double.tryParse(element.long)),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            zIndex: 10,
            infoWindow: InfoWindow(title: element.name)))
        .toSet();
  }
}
