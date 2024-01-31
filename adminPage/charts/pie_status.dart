import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:http/http.dart' as http;

class PieStatus {
  // List to store the dynamic percentage data
  List<Map<String, dynamic>> percentageArray = [];
  int i = 0;

  Future<List<Map<String, dynamic>>> getPercentage() async {
    final ipAddress = await getLocalIPv4Address();
    final String apiUrl = "http://$ipAddress:3000/getItemsCountByStatus";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Decode the JSON response
        final decodedResponse = json.decode(response.body);

        // Access the 'itemCountsByCategory' key and convert its value to a list
        List<dynamic> data = decodedResponse['itemCountsByStatus'];

        // Convert the list of dynamic to List<Map<String, dynamic>>
        percentageArray = List<Map<String, dynamic>>.from(data);
        return percentageArray;
      } else {
        throw Exception(
            'Failed to load reserved items. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Provide more meaningful error handling or logging
      print('Error fetching reserved items: $e');
      throw Exception('Failed to load reserved items');
    }
  }

  // Method to initialize the 'data' list based on the received results
  void initializeData() {
    data.clear();
    double totalSummation = calculateTotalSummation();

    for (var result in percentageArray) {
      String status = result['status'];
      int itemCount = result['itemCount'];
      i++;

      double percentage = (itemCount / totalSummation) * 100;
      // Format the percentage to keep only two digits after the decimal
      String formattedPercentage = percentage.toStringAsFixed(1);

      // Convert the formatted string back to double
      double finalPercentage = double.parse(formattedPercentage);

      data.add(
        Data(
          name: status,
          percent: finalPercentage,
          color: getRandomColor(),
        ),
      );
    }
  }

  double calculateTotalSummation() {
    double totalSummation = 0.0;
    for (var result in percentageArray) {
      int itemCount = result['itemCount'];
      totalSummation += itemCount.toDouble();
    }
    return totalSummation;
  }

  // Placeholder method to generate random color
  Color getRandomColor() {
    if (i == 1) {
      return Color(0xFF88d4ab);
    } else if (i == 2) {
      return Color(0xFF67b99a);
    } else if (i == 3) {
      return Color(0xFF469d89);
    } else if (i == 4) {
      return Color(0xFF248277);
    }

    return Color(0xFF343434);
  }

  // List to store the dynamic percentage data
  static List<Data> data = [];
}

class Data {
  final String name;
  final double percent;
  final Color color;

  Data({required this.name, required this.percent, required this.color});
}
