import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1st/adminPage/charts/pie_status.dart';

List<PieChartSectionData> getStatus(List<Data> dataList) => dataList
    .asMap()
    .map<int, PieChartSectionData>((index, data) {
      final value = PieChartSectionData(
        color: data.color,
        value: data.percent,
        title: '${data.percent}%',
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFFffffff),
        ),
      );
      return MapEntry(index, value);
    })
    .values
    .toList();
