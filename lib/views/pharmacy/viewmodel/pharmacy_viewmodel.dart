import 'dart:math' show cos, sqrt, asin;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:medication_app_v0/core/init/services/pharmacy_service.dart';
import 'package:medication_app_v0/views/pharmacy/model/pharmacy_model.dart';

part 'pharmacy_viewmodel.g.dart';

class PharmacyViewModel = _PharmacyViewModelBase with _$PharmacyViewModel;

abstract class _PharmacyViewModelBase with Store, BaseViewModel {
  PharmacyService _pharmacyServiceNew;
  @observable
  List<Pharmacy> pharmacies = [];

  @observable
  bool isLoading = true;

  void setContext(BuildContext context) => this.context = context;
  void init() async {
    _pharmacyServiceNew = new PharmacyService();
    pharmacies = await getPharmacy();
    await getClosestPharmacy();
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
    changeLoading();
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
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
}
