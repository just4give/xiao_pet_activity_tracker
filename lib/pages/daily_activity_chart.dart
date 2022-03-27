import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pet_activity_tracker/pages/daily_activity_series.dart';

class DailyActivityChart extends StatelessWidget {
  final List<ActivitySeries> data;

  const DailyActivityChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<ActivitySeries, String>> series = [
      charts.Series(
          id: "developers",
          data: data,
          domainFn: (ActivitySeries series, _) => series.type,
          measureFn: (ActivitySeries series, _) => series.count,
          colorFn: (ActivitySeries series, _) => series.barColor)
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
                    "TODAY'S ACTIVITY",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  child: charts.PieChart<String>(
                    series,
                    animate: true,
                    behaviors: [
                      charts.DatumLegend(
                        // Positions for "start" and "end" will be left and right respectively
                        // for widgets with a build context that has directionality ltr.
                        // For rtl, "start" and "end" will be right and left respectively.
                        // Since this example has directionality of ltr, the legend is
                        // positioned on the right side of the chart.
                        position: charts.BehaviorPosition.end,
                        // By default, if the position of the chart is on the left or right of
                        // the chart, [horizontalFirst] is set to false. This means that the
                        // legend entries will grow as new rows first instead of a new column.
                        horizontalFirst: false,
                        // This defines the padding around each legend entry.
                        cellPadding:
                            const EdgeInsets.only(right: 4.0, bottom: 4.0),
                        // Set [showMeasures] to true to display measures in series legend.
                        showMeasures: true,
                        // Configure the measure value to be shown by default in the legend.
                        legendDefaultMeasure:
                            charts.LegendDefaultMeasure.firstValue,
                        // Optionally provide a measure formatter to format the measure value.
                        // If none is specified the value is formatted as a decimal.
                        measureFormatter: (value) {
                          if (value == null) {
                            return "-";
                          } else {
                            final int hour = value ~/ 60;
                            final num minutes = value % 60;
                            return '${hour}h${minutes}m';
                          }
                        },
                      ),
                    ],
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
