import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/utilities/api_endpoints.dart';

class ClienteRegistroPorGeneroPieChart extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchPieChartData() async {
    final url = Uri.parse(
      ApiEndPoint.baseUrl + ApiEndPoint.graficoEndPoints.grafico3
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
          return Center(child: Text("No hay datos disponibles"));
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

          // Crea una leyenda para mostrar los géneros y colores
          final List<Widget> legendItems = sections.map((section) {
            final color = section.color;

            // Encuentra el género correspondiente
            final genero = (color == Colors.pink) ? 'Femenino' : 
                          (color == Colors.blue) ? 'Masculino' : 
                          'Desconocido'; // Determina el nombre basado en el color

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    color: color, // Color correspondiente
                  ),
                  SizedBox(height: 5),
                  Text(genero), // Género en la leyenda
                ],
              ),
            );
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 300, // Asegúrate de espacio suficiente para el gráfico
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 40, // Ajustable
                    sectionsSpace: 2, // Ajustable
                    borderData: FlBorderData(show: false), // Sin borde
                  ),
                ),
              ),
              SizedBox(height: 20), // Espacio entre el gráfico y la leyenda
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: legendItems, // Muestra la leyenda con géneros
              ),
            ],
          );
        }
      },
    );
  }
}
