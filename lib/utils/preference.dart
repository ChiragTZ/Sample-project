import 'dart:convert';

import 'package:iwl/utils/Enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PM {
  static SharedPreferences _preferences = _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static void clearPref() {
    _preferences.clear();
  }

  static write(String key, Object value) async {
    if (value is String) {
      _preferences.setString(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    } else {
      _preferences.setString(key, json.encode(value));
    }
  }

  static Future read(String key, PrefEnum value) async {
    switch (value) {
      case PrefEnum.STRING:
        return _preferences.getString(key);
      case PrefEnum.INT:
        return _preferences.getInt(key) ?? 0;
      case PrefEnum.DOUBLE:
        return _preferences.getDouble(key) ?? 0;
      case PrefEnum.BOOL:
        return _preferences.getBool(key) ?? false;
      case PrefEnum.LIST:
        return (_preferences.getStringList(key) ?? <String>[]);
      case PrefEnum.MODEL:
        return json.decode(_preferences.getString(key)!);
      default:
        break;
    }
  }
}
