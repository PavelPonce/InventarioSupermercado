import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shop_app/utilities/api_endpoints.dart';

class SalesByCategoryPieChart extends StatelessWidget {

  Future<List<Map<String, dynamic>>> fetchPieChartData() async {
    final url = Uri.parse(
      ApiEndPoint.baseUrl + ApiEndPoint.graficoEndPoints.grafico2
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json is Map<String, dynamic> && json.containsKey('data')) {
        return List<Map<String, dynamic>>.from(json['data']); // Ensure correct data structure
      } else {
        throw Exception("Unexpected response structure");
      }
    } else {
      throw Exception("HTTP error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchPieChartData(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No data available"));
        } else {
          final data = snapshot.data!;

          // Calculate total sales to derive percentages
          double total = 0;
          data.forEach((item) {
            final totalString = item['total']?.toString();
            if (totalString != null && totalString.isNotEmpty) {
              total += double.parse(totalString);
            }
          });

          final List<PieChartSectionData> sections = data.map((item) {
            final category = item['categoria'] ?? 'Unknown';
            final totalString = item['total']?.toString();

            double totalValue = 0;
            if (totalString != null && totalString.isNotEmpty) {
              totalValue = double.parse(totalString); // Safe conversion
            }

            final percentage = total > 0 ? (totalValue / total * 100).toStringAsFixed(1) : '0';
            final color = (category == 'Lacteos') ?  Colors.blue : (category == 'Plasticos') ?  Colors.pink : 
                          (category == 'Carnes') ?  Colors.greenAccent : (category == 'Granos') ?  Colors.green : Colors.red;
            
            return PieChartSectionData(
              color: color, // Random color from primary colors
              value: totalValue,
              title: '$percentage%', // Display percentage as the title
              radius: 50,
            );
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 300, // Ensure sufficient space for the pie chart
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 40,
                    sectionsSpace: 2,
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
              SizedBox(height: 20), // Space between pie chart and legend
              // Custom legend showing the color and category
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: sections.map((section) {
                  final text = (section.title == "Unknown") ? "Unknown" : section.title; // Use title as label

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color: section.color, 
                          child: Text(
                            section.value.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            ),// Corresponding color
                        ),
                        SizedBox(height: 5),
                        Text((section.color == Colors.pink) ? "Plasticos" : (section.color == Colors.blue) ? "Lacteos" 
                        : (section.color == Colors.green) ? "Granos" : (section.color == Colors.greenAccent) ? "Carnes"
                        :"Snacks"), // Corresponding title/label
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        }
      },
    );
  }
}
