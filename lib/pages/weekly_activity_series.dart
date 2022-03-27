import 'package:charts_flutter/flutter.dart' as charts;

class WeeklyActivitySeries {
  String type;
  String day;
  int count;
  int target;
  final charts.Color barColor;

  WeeklyActivitySeries(
      {required this.day,
      required this.type,
      required this.count,
      required this.target,
      required this.barColor});
}
