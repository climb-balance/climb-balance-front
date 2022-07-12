import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, String>> getStoredToken() async {
  final prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? '';
  String type = prefs.getString('socialType') ?? '';
  return {'token': token, 'type': type};
}

Future<void> storeStoredToken(
    {required String token, required String type}) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
  await prefs.setString('socialType', type);
}

Future<void> clearStoredToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', '');
  await prefs.setString('socialType', '');
}
