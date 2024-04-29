import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';

class ChartE extends StatefulWidget {
  final Map<String, double> data;
  const ChartE({super.key, required this.data});

  @override
  State<ChartE> createState() => _ChartEState();
}

class _ChartEState extends State<ChartE> {
  Map<String, double> dataMap = {};
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  final colorList = [
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.redAccent,
    Colors.orangeAccent,
  ];
  bool dataLoaded = false;

  Future<void> fetchData() async {
    dataMap = widget.data;
    setState(() {
      dataLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (dataLoaded)
          dataMap.isNotEmpty
              ? PieChart(
                  dataMap: dataMap,
                  animationDuration: const Duration(milliseconds: 800),
                  chartLegendSpacing: 32,
                  chartRadius: MediaQuery.of(context).size.width != 0
                      ? MediaQuery.of(context).size.width / 3.2
                      : 0,
                  colorList: colorList,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 32,
                  centerText: "Expense",
                  legendOptions: const LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendShape: BoxShape.circle,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: false,
                    showChartValuesOutside: false,
                    decimalPlaces: 1,
                  ),
                )
              : const Text('No data found'),
      ],
    );
  }
}
