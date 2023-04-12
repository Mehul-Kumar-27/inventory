// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';
import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:inventory/models/medicine.dart';

class MedicineDetail extends StatefulWidget {
  Medicine medicine;
  String username;
  MedicineDetail({
    Key? key,
    required this.medicine,
    required this.username,
  }) : super(key: key);

  @override
  State<MedicineDetail> createState() => _MedicineDetailState();
}

class _MedicineDetailState extends State<MedicineDetail> {
  late Map<String, int> quantityMap;
  @override
  void initState() {
    quantityMap =
        Map<String, dynamic>.from(jsonDecode(widget.medicine.medicineQuantity))
            .cast<String, int>();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // SizedBox(
          //   height: 60,
          //   width: double.infinity,
          //   child: MyChart(data: quantityMap),
          // ),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Print")),
        ],
      ),
    );
  }
}


class MyChart extends StatelessWidget {
  final Map<String, int> data;

  MyChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<MapEntry<String, int>, DateTime>> seriesList = [
      charts.Series<MapEntry<String, int>, DateTime>(
        id: 'Data',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (entry, _) => DateTime.parse(entry.key),
        measureFn: (entry, _) => entry.value,
        data: data.entries.toList(),
      ),
    ];

    return charts.TimeSeriesChart(
      seriesList,
      animate: true,
      domainAxis: charts.DateTimeAxisSpec(
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          day: charts.TimeFormatterSpec(
            format: 'dd',
            transitionFormat: 'MM/dd/yyyy',
          ),
        ),
        tickProviderSpec: charts.DayTickProviderSpec(increments: [1]),
      ),
    );
  }
}