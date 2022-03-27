import 'package:charts_flutter/flutter.dart' as charts;

class ActivitySeries {
  String type;
  int count;
  final charts.Color barColor;

  ActivitySeries(
      {required this.type, required this.count, required this.barColor});
}
