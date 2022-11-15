import 'dart:io';

bool isMobile() {
  try {
    if (Platform.isAndroid || Platform.isIOS) {
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}
