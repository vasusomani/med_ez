import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../Constants/colors.dart';
import '../../data/models/pain_model.dart';

class ProgressGraph extends StatelessWidget {
  const ProgressGraph({Key? key, this.userData}) : super(key: key);
  final Map<String, dynamic>? userData;

  @override
  Widget build(BuildContext context) {
    List<Pain> painData = (userData?["latest_assessment"]["DayWise"] as List)
        .map((dayWiseItem) => Pain.fromJson(dayWiseItem))
        .toList();

    List<FlSpot> spots = painData.asMap().entries.map((entry) {
      Pain pain = entry.value;
      DateTime date = DateTime.parse(pain.date);
      return FlSpot(
          date.millisecondsSinceEpoch.toDouble(), double.parse(pain.painScale));
    }).toList();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: appBarColor, width: 0.5),
          ),
          width: double.infinity,
          height: 300,
          child: LineChart(
            LineChartData(
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  preventCurveOverShooting: true,
                  isCurved: true,
                  color: appBarColor,
                  belowBarData: BarAreaData(show: false),
                ),
              ],
              minY: 0,
              gridData: const FlGridData(
                show: true,
              ),
              titlesData: FlTitlesData(
                bottomTitles: const AxisTitles(
                  axisNameWidget: Text(
                    "Date",
                    style: TextStyle(
                      color: appBarColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                leftTitles: AxisTitles(
                  axisNameWidget: const Text("Pain Scale",
                      style: TextStyle(
                          color: appBarColor, fontWeight: FontWeight.bold)),
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) =>
                        Text(value.toInt().toString()),
                  ),
                ),
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Table(
          border: TableBorder.all(color: appBarColor),
          defaultColumnWidth: const FlexColumnWidth(1.0),
          children: [
            const TableRow(
              children: [
                TableCell(
                  child: Center(
                    child: Text(
                      "Date",
                      style: TextStyle(
                        color: appBarColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                      "Pain Scale",
                      style: TextStyle(
                        color: appBarColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TableCell(
                  child: Center(
                    child: Text(
                      "Comments",
                      style: TextStyle(
                        color: appBarColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            for (var pain in painData)
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        pain.date,
                        style: const TextStyle(color: appBarColor),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        pain.painScale,
                        style: const TextStyle(color: appBarColor),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        pain.comments,
                        style: const TextStyle(color: appBarColor),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
