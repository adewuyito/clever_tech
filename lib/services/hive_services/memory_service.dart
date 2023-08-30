import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';

class SharedPreferenceModel {
  static final Future<SharedPreferences> _preferences = getInstance();
  static const String _keyBool = 'switch_state';

  static Future<SharedPreferences> getInstance() async {
    final pref = await SharedPreferences.getInstance();
    return pref;
  }

  static Future setBoolValue(List<bool> value) async {
    final pref = await _preferences;
    final stateStrings = value.map((e) => e.toString()).toList();
    pref.setStringList('_keyBool', stateStrings);
  }

  static Future<List<bool>?> getBoolValue() async {
    final pref = await _preferences;
    final switchStates = pref.getStringList(_keyBool);
    final values = switchStates?.map((state) => state == 'true').toList();
    if (values == null) {
      return [false, false, false, false, false, false, false, false];
    } else {
      return values;
    }
  }
}

class HiveModel {

}
