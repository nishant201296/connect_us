import 'package:shared_preferences/shared_preferences.dart';

class DataBaseHandler {
  static SharedPreferences _pref;
  static void init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static setValue(String key, String value) async {
    await _pref.setString(key, value);
  }

  static String getValue(String key) {
    return _pref.getString(key);
  }
}
