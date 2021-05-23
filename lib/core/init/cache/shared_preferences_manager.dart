import 'package:medication_app_v0/core/constants/enums/shared_preferences_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._init();

  SharedPreferences _preferences;
  static SharedPreferencesManager get instance => _instance;

  SharedPreferencesManager._init() {
    SharedPreferences.getInstance().then((value) => _preferences = value);
  }

  static Future preferencesInit() async {
    if (instance._preferences == null) {
      instance._preferences = await SharedPreferences.getInstance();
    }
  }

  Future<void> clearAll() async {
    await _preferences.clear();
  }

  Future<void> setStringValue(SharedPreferencesKey key, String value) async {
    await _preferences.setString(key.toString(), value);
  }

  Future<void> setBoolValue(SharedPreferencesKey key, bool value) async {
    await _preferences.setBool(key.toString(), value);
  }

  String getStringValue(SharedPreferencesKey key) =>
      _preferences.getString(key.toString()) ?? '';

  bool getBoolValue(SharedPreferencesKey key) =>
      _preferences.getBool(key.toString()) ?? false;

  Future<bool> deletePreferencesKey(SharedPreferencesKey key) async {
    return await _preferences.remove(key.toString());
  }

  Future<void> setListValue(
      SharedPreferencesKey key, List<String> value) async {
    await _preferences.setStringList(key.toString(), value);
  }

  Future<List<String>> getStringListValue(SharedPreferencesKey key) async =>
      await _preferences.getStringList(key.toString()) ?? [];
}
