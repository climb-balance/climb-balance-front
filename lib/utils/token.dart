import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, String>> getStoredToken() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  return {'token': token};
}

Future<void> storeStoredToken({required String token}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

Future<void> clearStoredToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', '');
}
