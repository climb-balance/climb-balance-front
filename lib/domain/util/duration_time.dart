String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

String formatDatetimeToHHMMSS(DateTime datetime) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(datetime.minute.remainder(60));
  String twoDigitSeconds = twoDigits(datetime.minute.remainder(60));
  return "${twoDigits(datetime.hour)}:$twoDigitMinutes:$twoDigitSeconds";
}

String formatDatetimeToYYMMDD(DateTime datetime) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitDay = twoDigits(datetime.day);
  String twoDigitMonth = twoDigits(datetime.month);
  return "${datetime.year} $twoDigitMonth $twoDigitDay";
}

String formatDatetimeToAll(DateTime datetime) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitDay = twoDigits(datetime.day);
  String twoDigitMonth = twoDigits(datetime.month);
  String twoDigitMinutes = twoDigits(datetime.minute.remainder(60));
  return "${datetime.year}.$twoDigitMonth.$twoDigitDay ${twoDigits(datetime.hour)}:$twoDigitMinutes";
}
