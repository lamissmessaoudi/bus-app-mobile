import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softun_bus_mobile/models/token_model.dart';

class SharedPreferenceService extends GetxService {
  Future<SharedPreferenceService> init() async {
    _sharedPreference = SharedPreferences.getInstance();
    return this;
  }

  late Future<SharedPreferences> _sharedPreference;

  getString(String key) {
    return _sharedPreference.then((prefs) {
      return prefs.getString(key);
    });
  }

  setString(String key, String value) {
    return _sharedPreference.then((prefs) {
      return prefs.setString(key, value);
    });
  }

  getBool(String key) {
    return _sharedPreference.then((prefs) {
      return prefs.getBool(key);
    });
  }

  setBool(String key, bool value) {
    return _sharedPreference.then((prefs) {
      return prefs.setBool(key, value);
    });
  }

  getInt(String key) {
    return _sharedPreference.then((prefs) {
      return prefs.getInt(key) ?? null;
    });
  }

  setInt(String key, int value) {
    return _sharedPreference.then((prefs) {
      return prefs.setInt(key, value);
    });
  }

  remove(String key) {
    return _sharedPreference.then((prefs) {
      return prefs.remove(key);
    });
  }

  clearAll() {
    return _sharedPreference.then((prefs) {
      return prefs.clear();
    });
  }
}
