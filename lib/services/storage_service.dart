import 'package:shared_preferences/shared_preferences.dart';

import '../models/settings.dart';

class StorageService {
  static Future<Map<String, String>> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    return {'token': token};
  }

  static Future<void> storeStoredToken({required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<void> clearStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', '');
  }

  static Future<Settings> getStoredSettings() async {
    final prefs = await SharedPreferences.getInstance();
    bool darkMode = prefs.getBool('darkmode') ?? false;
    bool expertMode = prefs.getBool('expertmode') ?? false;

    Settings settings = Settings(darkMode: darkMode, expertMode: expertMode);
    return settings;
  }

  static Future<void> storeSettings(Settings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkmode', settings.darkMode);
    await prefs.setBool('expertmode', settings.expertMode);
  }
}