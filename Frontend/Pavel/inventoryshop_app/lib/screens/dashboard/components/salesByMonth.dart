import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/utilities/api_endpoints.dart';

class GananciaPorMesBarChart extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchPieChartData() async {
    final url = Uri.parse(
      ApiEndPoint.baseUrl + ApiEndPoint.graficoEndPoints.grafico4
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

  String getMonthName(int month) {
  switch (month) {
    case 1:
      return "Enero";
    case 2:
      return "Febrero";
    case 3:
      return "Marzo";
    case 4:
      return "Abril";
    case 5:
      return "Mayo";
    case 6:
      return "Junio";
    case 7:
      return "Julio";
    case 8:
      return "Agosto";
    case 9:
      return "Septiembre";
    case 10:
      return "Octubre";
    case 11:
      return "Noviembre";
    case 12:
      return "Diciembre";
    default:
      return "Desconocido";
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
          return Center(child: Text("No hay datos disponibles"));
        } else {
          final data = snapshot.data!;

          // Create a list of bar chart groups based on the data
          final List<BarChartGroupData> barGroups = data.map((item) {
            final mes = item['mes'] ?? 0; // Default to 0 if null
            final totalString = item['total']?.toString(); // Handle null safely

            double totalGanancia = totalString != null && totalString.isNotEmpty
              ? double.parse(totalString)
              : 0; // Convert to double with default

            return BarChartGroupData(
              x: int.tryParse(mes.toString()) ?? 0, // Use month number as x-value
              barRods: [
                BarChartRodData(
                  toY: totalGanancia, // Total gain for the bar
                  color: Colors.blue, // Color for the bar
                ),
              ],
            );
          }).toList();

          return Container(
            padding: EdgeInsets.all(8),
            child: SizedBox(
            height: 300, // Ensure sufficient height for the chart
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                barGroups: barGroups,
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        final month = value.toInt();
                        return Text(getMonthName(month)); // Get the month name
                      },
                      reservedSize: 30, // Adjust spacing
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      getTitlesWidget: (value, _) => Text(value.toStringAsFixed(0)), // Y-axis labels
                    ),
                  ),
                ),
                gridData: FlGridData(show: false), // Optional: hide grid lines
                borderData: FlBorderData(show: false), // Optional: hide border
              ),
            ),
          )
          ); 
        }
      },
    );
  }}
