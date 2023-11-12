import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  BarChartWidget(this.data);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'مجموع المبيعات حسب الموظف'),
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(),
      series: <BarSeries<Map<String, dynamic>, String>>[
        BarSeries<Map<String, dynamic>, String>(
          dataSource: data,
          xValueMapper: (datum, _) => datum['username'].toString(),
          yValueMapper: (datum, _) => double.parse(datum['total_sales'].toString()),
          name: 'Total Sales',
        ),
      ],
    );
  }
}