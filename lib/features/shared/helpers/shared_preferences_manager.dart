import 'package:shared_preferences/shared_preferences.dart';
import 'package:trippify/utils/sp_keys.dart';

class SharedPreferencesManager {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String? getUserId() {
    return _preferences?.getString(spUserId);
  }

  static Future<bool> setUserId(String userId) {
    return _preferences?.setString(spUserId, userId) ?? Future.value(false);
  }
}
