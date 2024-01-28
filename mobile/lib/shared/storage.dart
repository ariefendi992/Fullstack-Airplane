import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Future pref() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();

    return _pref;
  }

  Future setStorage(String key, dynamic value) async {
    final SharedPreferences _pref = await pref();

    if (value is String) {
      return _pref.setString(key, value);
    } else if (value is int) {
      return _pref.setInt(key, value);
    } else if (value is bool) {
      return _pref.setBool(key, value);
    }
  }

  Future<String?> getStringValue(String key) async {
    final SharedPreferences _pref = await pref();

    final String? value = _pref.getString(key);
    return value;
  }

  Future<bool?> getBoolValue(String key) async {
    final SharedPreferences _pref = await pref();

    final bool? value = _pref.getBool(key);
    return value;
  }

  Future<int?> getIntValue(String key) async {
    final SharedPreferences _pref = await pref();

    final int? value = _pref.getInt(key);
    return value;
  }

  void removeStorage(String key) async {
    final SharedPreferences _pref = await pref();

    _pref.remove(key);
  }
}
