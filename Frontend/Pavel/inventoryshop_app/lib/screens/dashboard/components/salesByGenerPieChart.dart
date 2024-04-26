import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/utilities/api_endpoints.dart'; // Adjust the import path

class SalesByGenderPieChart extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchPieChartData() async {
    final url = Uri.parse(ApiEndPoint.baseUrl + ApiEndPoint.graficoEndPoints.grafico1);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json is Map<String, dynamic> && json.containsKey('data')) {
        final data = json['data'];
        if (data is List && data.isNotEmpty) {
          return List<Map<String, dynamic>>.from(data); // Ensure correct type
        }
      }
      throw Exception("No valid data in the response");
    } else {
      throw Exception("HTTP error: ${response.statusCode}");
    }
  }

  @override
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

          // Calculate total quantity to derive percentages
          double total = 0;
          data.forEach((item) {
            final cantidadString = item['cantidad']?.toString();
            if (cantidadString != null && cantidadString.isNotEmpty) {
              total += double.parse(cantidadString);
            }
          });

          // Create PieChartSectionData with percentages
          final List<PieChartSectionData> sections = data.map((item) {
            final gender = item['genero'] ?? 'Unknown';
            final cantidadString = item['cantidad']?.toString();

            double cantidad = 0;
            if (cantidadString != null && cantidadString.isNotEmpty) {
              cantidad = double.parse(cantidadString);
            }

            // Calculate the percentage
            final percentage = total > 0 ? (cantidad / total * 100).toStringAsFixed(1) : '0';

            final color = (gender == 'F') ? Colors.pink : (gender == 'M') ? Colors.blue : Colors.grey;

            return PieChartSectionData(
              color: color,
              value: cantidad,
              title: '$percentage%', // Display percentage as the title
              radius: 50, // Adjust for visual appearance
            );
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 300, // Ensure sufficient height
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 40, // Customizable
                    sectionsSpace: 2, // Customizable
                    borderData: FlBorderData(show: false),
                    // Add other configurations as needed
                  ),
                ),
              ),
              // Create a custom legend below the pie chart
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: sections.map((section) {
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
                            ), // Corresponding color
                        ),
                        SizedBox(height: 5),
                        Text((section.color == Colors.pink) ? "Femenino" : "Masculino"), // Corresponding title/label
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