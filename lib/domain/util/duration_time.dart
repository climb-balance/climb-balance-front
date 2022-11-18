import 'dart:core';

String twoDigits(int n) => n.toString().padLeft(2, "0");

String formatDuration(Duration duration) {
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

String formatDatetimeToHHMMSS(DateTime datetime) {
  String twoDigitMinutes = twoDigits(datetime.minute.remainder(60));
  String twoDigitSeconds = twoDigits(datetime.minute.remainder(60));
  return "${twoDigits(datetime.hour)}:$twoDigitMinutes:$twoDigitSeconds";
}

String formatDatetimeToYYMMDD(DateTime datetime) {
  String twoDigitDay = twoDigits(datetime.day);
  String twoDigitMonth = twoDigits(datetime.month);
  return "${datetime.year} $twoDigitMonth $twoDigitDay";
}

String formatDatetimeToAll(DateTime datetime) {
  String twoDigitDay = twoDigits(datetime.day);
  String twoDigitMonth = twoDigits(datetime.month);
  String twoDigitMinutes = twoDigits(datetime.minute.remainder(60));
  return "${datetime.year}.$twoDigitMonth.$twoDigitDay ${twoDigits(datetime.hour)}:$twoDigitMinutes";
}

int formatTimeTextToSecond(String timeText) {
  List<String> tmp = timeText.split(':');
  if (tmp.length != 2) return 0;

  try {
    int mm = int.parse(tmp[0]);
    int ss = int.parse(tmp[1]);
    if (ss > 59) throw Error;
    return mm * 60 + ss;
  } catch (_) {
    return 0;
  }
}

String formatTimestampToMMSS(int timestamp) {
  Duration duration = Duration(milliseconds: timestamp);
  String twoDigitMinute = twoDigits(duration.inMinutes);
  String twoDigitSecond = twoDigits(duration.inSeconds % 60);
  return "$twoDigitMinute:$twoDigitSecond";
}

String formatTimestampToPassedString(int timestamp) {
  Duration timeDiffer =
      DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(timestamp));

  if (timeDiffer.inDays > 0) {
    return '${timeDiffer.inDays}일전';
  }
  if (timeDiffer.inHours > 0) {
    return '${timeDiffer.inHours}시간전';
  }
  if (timeDiffer.inMinutes > 0) {
    return '${timeDiffer.inMinutes}분전';
  }
  return '${timeDiffer.inSeconds}초전';
}
