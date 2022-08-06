import 'package:shared_preferences/shared_preferences.dart';

import '../../models/settings.dart';

Future<Settings> getStoredSettings() async {
  final prefs = await SharedPreferences.getInstance();
  bool darkmode = prefs.getBool('darkmode') ?? false;
  Settings settings = Settings(darkMode: darkmode);
  return settings;
}

Future<void> storeSettings(Settings settings) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('darkmode', settings.darkMode);
}
