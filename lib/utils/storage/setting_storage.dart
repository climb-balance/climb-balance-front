import 'package:shared_preferences/shared_preferences.dart';

import '../../models/settings.dart';

Future<Settings> getStoredSettings() async {
  final prefs = await SharedPreferences.getInstance();
  bool darkMode = prefs.getBool('darkmode') ?? false;
  bool expertMode = prefs.getBool('expertmode') ?? false;

  Settings settings = Settings(darkMode: darkMode, expertMode: expertMode);
  return settings;
}

Future<void> storeSettings(Settings settings) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('darkmode', settings.darkMode);
  await prefs.setBool('expertmode', settings.expertMode);
}
