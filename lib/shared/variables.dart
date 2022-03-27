import 'package:intl/intl.dart';

const double fontSizeBig = 24;
const double fontSizeMedium = 21;
const double fontSizeSmall = 18;
const double fontSizeExtraSmall = 14;
const String bleName = "EIBLUE";
const String serviceUUID = "4D7D1101-EE27-40B2-836C-17505C1044D7";
const String rxPredUUID = "4D7D1106-EE27-40B2-836C-17505C1044D7";
const String rxBatUUID = "4D7D1107-EE27-40B2-836C-17505C1044D7";
const String txUUID = "4D7D1108-EE27-40B2-836C-17505C1044D7";

int todaySinceEpoch() {
  var now = DateTime.now();
  var startOfDay = DateTime(now.year, now.month, now.day);
  return startOfDay.microsecondsSinceEpoch;
}

int yesterdaySinceEpoch() {
  var now = DateTime.now();
  var startOfDay = DateTime(now.year, now.month, now.day - 1);
  return startOfDay.microsecondsSinceEpoch;
}

int getttl() {
  var now = DateTime.now();
  var startOfDay = DateTime(now.year, now.month, now.day + 7);
  return startOfDay.microsecondsSinceEpoch;
}

String dayOfToday() {
  return DateFormat.E().format(DateTime.now());
}

String dayOfYesterday() {
  var now = DateTime.now();
  return DateFormat.E().format(DateTime(now.year, now.month, now.day - 1));
}

String formatShortDate(int microsecondsSinceEpoch) {
  var now = DateTime.fromMicrosecondsSinceEpoch(microsecondsSinceEpoch);
  return DateFormat.Md().add_jm().format(now);
}
