import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:medication_app_v0/core/base/viewmodel/base_viewmodel.dart';
import 'package:medication_app_v0/core/components/models/others/user_data_model.dart';
import 'package:medication_app_v0/core/constants/enums/shared_preferences_enum.dart';
import 'package:medication_app_v0/core/constants/navigation/navigation_constants.dart';
import 'package:medication_app_v0/core/init/cache/shared_preferences_manager.dart';
import 'package:medication_app_v0/core/init/locale_keys.g.dart';
import 'package:medication_app_v0/core/init/services/auth_manager.dart';
import 'package:medication_app_v0/core/init/services/google_sign_helper.dart';
import 'package:medication_app_v0/views/Inventory/model/inventory_model.dart';
import 'package:medication_app_v0/views/home/Calendar/model/reminder.dart';
import 'package:medication_app_v0/core/extention/string_extention.dart';

import 'package:mobx/mobx.dart';
import 'package:table_calendar/table_calendar.dart';
part 'home_viewmodel.g.dart';

class HomeViewmodel = _HomeViewmodelBase with _$HomeViewmodel;

abstract class _HomeViewmodelBase with Store, BaseViewModel {
  @observable
  bool isLoading = false;
  @observable
  Map<DateTime, List<ReminderModel>> events;
  @observable
  List<ReminderModel> selectedEvents;
  CalendarController calendarController;
  final SharedPreferencesManager _sharedPreferencesManager =
      SharedPreferencesManager.instance;
  //scan QR barcode
  String _scanBarcode = 'Unknown';

  void setContext(BuildContext context) => this.context = context;
  void init() async {
    changeLoading();
    denemeGet();
    final _selectedDay =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    //_sharedPreferencesManager
    //    .setListValue(SharedPreferencesKey.REMINDERMODELS, []);
    events = await getEvents();

    selectedEvents = events[_selectedDay] ?? [];
    calendarController = CalendarController();
    //checking loading indicator
    print("-----------------------------wait");
    await waitIt();
    print("-------------------------done");
    changeLoading();
  }

  Future<void> waitIt() async {
    await Future.delayed(Duration(seconds: 1));
  }

  void dispose() {
    calendarController.dispose();
  }

  @action
  void onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    selectedEvents = events.cast<ReminderModel>();
  }

  @action
  void onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    calendarController.setSelectedDay(first);
    selectedEvents = events[first] ?? [];
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void onCalendarCreated(DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  //scan barcode (qr and normal type barcode is readable.)
  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", LocaleKeys.home_CANCEL.locale, true, ScanMode.QR);
      print("barcode=$barcodeScanRes");
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    //if (!mounted) return; mountedi anlamadım!!!
    _scanBarcode = barcodeScanRes;
  }

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  void logoutIconButtonOnPress() async {
    await GoogleSignHelper.instance.signOut();
    navigation.navigateToPageClear(path: NavigationConstants.SPLASH_VIEW);
  }

  void navigateCovidTurkey() {
    navigation.navigateToPage(path: NavigationConstants.COVID_TURKEY_VIEW);
  }

  void navigateInventory() {
    navigation.navigateToPage(path: NavigationConstants.INVENTORY_VIEW);
  }

  void navigateAddMedication() {
    navigation.navigateToPage(path: NavigationConstants.ADD_MEDICATION);
  }

  Future<void> denemeGet() async {
    UserDataModel udm = await AuthManager.instance.getUserData();
    print(udm.toString());
  }

  Future<List<ReminderModel>> getModelListFromSharedPref() async {
    List<String> jsons = await _sharedPreferencesManager
        .getStringListValue(SharedPreferencesKey.REMINDERMODELS);
    List<ReminderModel> results = [];
    jsons.forEach((value) => results.add(ReminderModel.fromJson(value)));
    return results;
  }

  Future<Map<DateTime, List<ReminderModel>>> getEvents() async {
    List<ReminderModel> reminderModels = await getModelListFromSharedPref();
    var eventMap = new Map<DateTime, List<ReminderModel>>();
    reminderModels.forEach((value) {
      DateTime theDay =
          DateTime(value.time.year, value.time.month, value.time.day);
      if (eventMap.containsKey(theDay)) {
        eventMap[theDay].add(value);
      } else {
        eventMap[theDay] = [value];
      }
    });
    return eventMap;
  }
}

/*previous Event!
 events = {
      _selectedDay.subtract(Duration(days: 30)): [
        HomeModel("Teraflu",
            _selectedDay.subtract(Duration(days: 30, hours: 4)), 25, true),
        HomeModel("Calpol", _selectedDay.subtract(Duration(days: 30, hours: 1)),
            25, false),
      ],
      _selectedDay.subtract(Duration(days: 27)): [
        HomeModel("Teraflu",
            _selectedDay.subtract(Duration(days: 27, hours: 2)), 35, true),
      ],
      _selectedDay.subtract(Duration(days: 20)): [
        HomeModel("Teraflu",
            _selectedDay.subtract(Duration(days: 20, hours: 3)), 40, false),
        HomeModel("Calpol", _selectedDay.subtract(Duration(days: 20, hours: 2)),
            25, false),
        HomeModel("Jolessa",
            _selectedDay.subtract(Duration(days: 20, hours: 1)), 25, true),
        HomeModel(
            "Paromymcin", _selectedDay.subtract(Duration(days: 20)), 25, true),
      ],
      _selectedDay.subtract(Duration(days: 16)): [
        HomeModel("Calpol", _selectedDay.subtract(Duration(days: 16, hours: 4)),
            25, false),
        HomeModel("Jolessa",
            _selectedDay.subtract(Duration(days: 16, hours: 3)), 25, false),
      ],
      _selectedDay.subtract(Duration(days: 10)): [
        HomeModel("Calpol", _selectedDay.subtract(Duration(days: 10, hours: 2)),
            25, true),
        HomeModel("Jolessa",
            _selectedDay.subtract(Duration(days: 10, hours: 1)), 25, true),
        HomeModel(
            "Paromymcin", _selectedDay.subtract(Duration(days: 10)), 25, true),
      ],
      _selectedDay.subtract(Duration(days: 4)): [
        HomeModel("Teraflu", _selectedDay.subtract(Duration(days: 4, hours: 4)),
            25, true),
        HomeModel("Calpol", _selectedDay.subtract(Duration(days: 4, hours: 3)),
            25, false),
        HomeModel("Jolessa", _selectedDay.subtract(Duration(days: 4, hours: 1)),
            25, true),
      ],
      _selectedDay.subtract(Duration(days: 2)): [
        HomeModel("Jolessa", _selectedDay.subtract(Duration(days: 2, hours: 2)),
            25, false),
        HomeModel("Paromymcin",
            _selectedDay.subtract(Duration(days: 2, hours: 5)), 25, true),
      ],
      _selectedDay: [
        HomeModel(
            "Jolessa", _selectedDay.subtract(Duration(hours: 5)), 25, true),
        HomeModel(
            "Paromymcin", _selectedDay.subtract(Duration(hours: 4)), 25, true),
        HomeModel(
            "Jolessa", _selectedDay.subtract(Duration(hours: 2)), 25, true),
        HomeModel("Paromymcin", _selectedDay, 25, true),
      ],
      _selectedDay.add(Duration(days: 7)): [
        HomeModel(
            "Jolessa", _selectedDay.add(Duration(days: 7, hours: 1)), 25, true),
        HomeModel("Paromymcin", _selectedDay.add(Duration(days: 7, hours: 2)),
            25, true),
        HomeModel(
            "Teraflu", _selectedDay.add(Duration(days: 7, hours: 3)), 25, true),
        HomeModel(
            "Calpol", _selectedDay.add(Duration(days: 7, hours: 4)), 25, false),
        HomeModel(
            "Jolessa", _selectedDay.add(Duration(days: 7, hours: 5)), 25, true),
      ],
    };*/
