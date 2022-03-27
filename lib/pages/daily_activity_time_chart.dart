import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:pet_activity_tracker/pages/daily_activity_time_series.dart';

class DailyActivityTimeSeriesChart extends StatelessWidget {
  final List<ActivityTimeSeries> data;

  const DailyActivityTimeSeriesChart({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ActivityTimeSeries, int>> series = [
      charts.Series(
        id: "developers",
        data: data,
        domainFn: (ActivityTimeSeries series, _) => series.seq,
        measureFn: (ActivityTimeSeries series, _) => int.parse(series.type),
        colorFn: (ActivityTimeSeries series, _) {
          if (series.type == "1") {
            return charts.ColorUtil.fromDartColor(Colors.grey);
          } else if (series.type == "2") {
            return charts.ColorUtil.fromDartColor(Colors.blueAccent);
          } else if (series.type == "3") {
            return charts.ColorUtil.fromDartColor(Colors.green);
          } else {
            return charts.ColorUtil.fromDartColor(Colors.amber);
          }
        },
        radiusPxFn: (ActivityTimeSeries series, _) => series.radius,
      )
    ];

    return Container(
      height: 300,
      padding: const EdgeInsets.all(1.0),
      child: Card(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    "TODAY'S TIME SERIES",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  child: charts.ScatterPlotChart(
                    series,
                    animate: true,
                    primaryMeasureAxis: const charts.NumericAxisSpec(
                      showAxisLine: false,
                      renderSpec: charts.NoneRenderSpec(),
                    ),
                    domainAxis: const charts.NumericAxisSpec(
                      showAxisLine: false,
                      renderSpec: charts.NoneRenderSpec(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
