import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pet_activity_tracker/pages/daily_activity_series.dart';
import 'package:pet_activity_tracker/pages/weekly_activity_series.dart';

class WeeklyActivityChart extends StatelessWidget {
  final List<List<WeeklyActivitySeries>> data;

  const WeeklyActivityChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> activities = ["rest", "walk", "run", "stair"];
    List<charts.Series<WeeklyActivitySeries, String>> series = [];
    bool _showLabel = false;

    for (int i = 0; i < activities.length; i++) {
      series.add(charts.Series(
          id: activities[i],
          data: data[i],
          labelAccessorFn: (WeeklyActivitySeries series, _) {
            final int hour = series.count ~/ 60;
            final num minutes = series.count % 60;
            return series.count > 0 && _showLabel == true
                ? '${hour}h ${minutes}m'
                : '';
          },
          domainFn: (WeeklyActivitySeries series, _) => series.day,
          measureFn: (WeeklyActivitySeries series, _) => series.count,
          colorFn: (WeeklyActivitySeries series, _) => series.barColor));
    }

    // List<charts.Series<WeeklyActivitySeries, String>> series = [
    //   charts.Series(
    //       id: "rest",
    //       data: data[0],
    //       labelAccessorFn: (WeeklyActivitySeries series, _) {
    //         final int hour = series.count ~/ 60;
    //         final num minutes = series.count % 60;
    //         return '${hour}h ${minutes}m';
    //       },
    //       domainFn: (WeeklyActivitySeries series, _) => series.day,
    //       measureFn: (WeeklyActivitySeries series, _) => series.count,
    //       colorFn: (WeeklyActivitySeries series, _) => series.barColor),
    //   charts.Series(
    //       id: "walk",
    //       data: data[1],
    //       labelAccessorFn: (WeeklyActivitySeries series, _) => series.day,
    //       domainFn: (WeeklyActivitySeries series, _) => series.day,
    //       measureFn: (WeeklyActivitySeries series, _) => series.count,
    //       colorFn: (WeeklyActivitySeries series, _) => series.barColor),
    //   charts.Series(
    //       id: "run",
    //       data: data[2],
    //       labelAccessorFn: (WeeklyActivitySeries series, _) => series.day,
    //       domainFn: (WeeklyActivitySeries series, _) => series.day,
    //       measureFn: (WeeklyActivitySeries series, _) => series.count,
    //       colorFn: (WeeklyActivitySeries series, _) => series.barColor),
    //   charts.Series(
    //       id: "stair",
    //       data: data[3],
    //       labelAccessorFn: (WeeklyActivitySeries series, _) => series.day,
    //       domainFn: (WeeklyActivitySeries series, _) => series.day,
    //       measureFn: (WeeklyActivitySeries series, _) => series.count,
    //       colorFn: (WeeklyActivitySeries series, _) => series.barColor),

    //   //code for target line
    //   // charts.Series(
    //   //     id: "rest",
    //   //     data: data[0],
    //   //     domainFn: (WeeklyActivitySeries series, _) => series.day,
    //   //     measureFn: (WeeklyActivitySeries series, _) => series.target,
    //   //     colorFn: (WeeklyActivitySeries series, _) => series.barColor)
    //   //   ..setAttribute(charts.rendererIdKey, 'customTargetLine'),
    //   // charts.Series(
    //   //     id: "walk",
    //   //     data: data[1],
    //   //     domainFn: (WeeklyActivitySeries series, _) => series.day,
    //   //     measureFn: (WeeklyActivitySeries series, _) => series.target,
    //   //     colorFn: (WeeklyActivitySeries series, _) => series.barColor)
    //   //   ..setAttribute(charts.rendererIdKey, 'customTargetLine'),
    //   // charts.Series(
    //   //     id: "run",
    //   //     data: data[2],
    //   //     domainFn: (WeeklyActivitySeries series, _) => series.day,
    //   //     measureFn: (WeeklyActivitySeries series, _) => series.target,
    //   //     colorFn: (WeeklyActivitySeries series, _) => series.barColor)
    //   //   ..setAttribute(charts.rendererIdKey, 'customTargetLine'),
    //   // charts.Series(
    //   //     id: "stair",
    //   //     data: data[3],
    //   //     domainFn: (WeeklyActivitySeries series, _) => series.day,
    //   //     measureFn: (WeeklyActivitySeries series, _) => series.target,
    //   //     colorFn: (WeeklyActivitySeries series, _) => series.barColor)
    //   //   ..setAttribute(charts.rendererIdKey, 'customTargetLine'),
    // ];

    return Container(
      height: 300,
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    "THIS WEEK'S ACTIVITY",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    color: Colors.grey,
                    onPressed: () {
                      _showLabel = !_showLabel;
                    },
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  child: charts.BarChart(
                    series,
                    animate: true,
                    barRendererDecorator: charts.BarLabelDecorator<String>(
                        //labelAnchor: charts.BarLabelAnchor.middle,
                        //labelPosition: charts.BarLabelPosition.inside,
                        outsideLabelStyleSpec: charts.TextStyleSpec(
                            color: charts.ColorUtil.fromDartColor(
                                Colors.blueAccent))),
                    primaryMeasureAxis: const charts.NumericAxisSpec(
                        renderSpec: charts.NoneRenderSpec()),
                    domainAxis: charts.OrdinalAxisSpec(
                        renderSpec: charts.SmallTickRendererSpec(

                            // Tick and Label styling here.
                            labelStyle: charts.TextStyleSpec(
                                fontSize: 18, // size in Pts.
                                color: charts.ColorUtil.fromDartColor(
                                    Colors.amber)),

                            // Change the line colors to match text color.
                            lineStyle: charts.LineStyleSpec(
                                color: charts.ColorUtil.fromDartColor(
                                    Colors.amberAccent)))),
                    // customSeriesRenderers: [
                    //   charts.BarTargetLineRendererConfig<String>(
                    //       // ID used to link series to this renderer.
                    //       customRendererId: 'customTargetLine',
                    //       groupingType: charts.BarGroupingType.grouped)
                    // ]
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
