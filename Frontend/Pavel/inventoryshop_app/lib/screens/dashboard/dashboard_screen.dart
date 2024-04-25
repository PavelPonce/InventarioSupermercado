// gender_statistics_card.dart
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/utilities/api_endpoints.dart';

class DashboardScreen extends StatelessWidget {
  static String routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 16.0, bottom: 16.0), // Ajusta el espacio como necesites
              child: Text(
                'Dashboard',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // Esto centrará el texto
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: GenderStatisticsCard(),
            ),
            SizedBox(height: 5),
            Divider(
              color: Colors.grey.shade600,
              indent:
                  32, // Inicio del divisor con espacio desde el borde izquierdo
              endIndent:
                  32, // Final del divisor con espacio desde el borde derecho
            ), // Línea divisoria entre cards
            Container(
              height: 400,
              child: EmployeeCountBarChart(),
            ),

            SizedBox(height: 5),

            Divider(color: Colors.grey.shade600, indent: 32, endIndent: 32),

            Container(
              height: 400,
              child: TopMealsChart(),
            ),
            Divider(color: Colors.grey.shade600, indent: 32, endIndent: 32),
            // Línea divisoria entre cards
            AspectRatio(
              aspectRatio:
                  1, // Este es un ejemplo, ajusta la relación según necesites
              child: DepartmentClientsChart(),
            ),
          ],
        ),
      ),
    );
  }
}

//------------------------------------------------EXTRA SOBRE LOS DE APISERVICE TOP 5 PLATOS
class PlatoTop {
  final String nombrePlato;
  final int totalVendidos;

  PlatoTop({required this.nombrePlato, required this.totalVendidos});

  factory PlatoTop.fromJson(Map<String, dynamic> json) {
    return PlatoTop(
      nombrePlato: json['nombre_Plato'] as String,
      totalVendidos: json['total_Vendidos'] as int,
    );
  }
}

class ClienteDepartamento {
  final String depaDepartamento;
  final int cantidadClientes;

  ClienteDepartamento({
    required this.depaDepartamento,
    required this.cantidadClientes,
  });

  factory ClienteDepartamento.fromJson(Map<String, dynamic> json) {
    // El nombre del campo en el JSON parece ser 'depa_Departamento', no 'depaDepartamento'
    final depaDepartamento = json['depa_Departamento'] as String?;
    final cantidadClientes = json['cantidadClientes'] as int?;

    if (depaDepartamento == null || cantidadClientes == null) {
      // Imprime el JSON para depuración
      print('JSON recibido: $json');
      throw Exception('Los campos requeridos son nulos');
    }

    return ClienteDepartamento(
      depaDepartamento: depaDepartamento,
      cantidadClientes: cantidadClientes,
    );
  }
}

//-----------------------------------------------------------dashboard de generos por empleado

class GenderStatisticsCard extends StatelessWidget {
  Future<Map<String, dynamic>> grafico1() async {
    var url = Uri.parse(
      ApiEndPoint.baseUrl + ApiEndPoint.graficoEndPoints.grafico1,
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['code'] == 200) {
        return json['data'];
      } else {
        throw Exception('Failed to load gender statistics: ${json['message']}');
      }
    } else {
      throw Exception(
          'Failed to load gender statistics with status code: ${response.statusCode}');
    }
  }

  const GenderStatisticsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: grafico1(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (!snapshot.hasData) {
          return Text("No data available");
        } else {
          final data = snapshot.data!;
          final int maleCount = data['cantidadMasculino'] as int? ??
              0; // Usa las claves correctas del JSON
          final int femaleCount = data['cantidadFemenino'] as int? ?? 0;
          return createGenderStatisticsChart(
              context, maleCount, femaleCount); // Pasando context aquí
        }
      },
    );
  }

  Widget createGenderStatisticsChart(
      BuildContext context, int maleCount, int femaleCount) {
    final total = maleCount + femaleCount;
    final double malePercentage = total > 0 ? (maleCount / total) * 100 : 0;
    final double femalePercentage = total > 0 ? (femaleCount / total) * 100 : 0;

    return Card(
      elevation: 4,
      color: Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                  sections: [
                    PieChartSectionData(
                      color: Colors.blue,
                      value: malePercentage,
                      showTitle: false,
                      //title: 'Masculino ${malePercentage.toStringAsFixed(1)}%',
                      radius: 60,
                      titleStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    PieChartSectionData(
                      color: Colors.pink,
                      value: femalePercentage,
                      showTitle: false,
                      //title: 'Femenino ${femalePercentage.toStringAsFixed(1)}%',
                      radius: 60,
                      titleStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Estadística de Empleados por género',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Femenino: ${femalePercentage.toStringAsFixed(1)}%',
                    style: TextStyle(color: Colors.pink),
                  ),
                  Text(
                    'Masculino: ${malePercentage.toStringAsFixed(1)}%',
                    style: TextStyle(color: Colors.blue),
                  ),
                  SizedBox(height: 18),
                  Container(
                    height: 9,
                    width: double.infinity,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//-------------------------------------------------------------------------------------empleados por restaurante
// Widget para mostrar el gráfico de barras de empleados por restaurante
class EmployeeCountBarChart extends StatelessWidget {
  final String employeeCountUrl =
      'http://www.restaurante.somee.com/Api/Empleado/EmplRestaurante';

  Future<List<Map<String, dynamic>>> fetchEmployeeCountByRestaurant() async {
    final response = await http.get(Uri.parse(employeeCountUrl));
    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      if (decodedResponse['success'] == true) {
        // Si 'data' es una lista de objetos, la convertimos y la retornamos
        if (decodedResponse['data'] is List) {
          return List<Map<String, dynamic>>.from(decodedResponse['data']);
        } else {
          // Si 'data' no es una lista, la envolvemos en una lista
          return [decodedResponse['data']];
        }
      } else {
        throw Exception(
            'Failed to load employee count: ${decodedResponse['message']}');
      }
    } else {
      throw Exception(
          'Failed to load data with status code: ${response.statusCode}');
    }
  }

  EmployeeCountBarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchEmployeeCountByRestaurant(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          // Procesa la lista de mapas para obtener los datos del gráfico
          final List<Map<String, dynamic>> data = snapshot.data!;
          List<BarChartGroupData> barGroups = [];
          int index = 0;

          for (var restaurantData in data) {
            final String name = restaurantData['nombre_Restaurante'];
            final int count = restaurantData['cantidad_Empleados'];
            final Color barColor =
                Colors.primaries[index % Colors.primaries.length];
            barGroups.add(BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  y: count.toDouble(),
                  width: 30,
                  colors: [barColor],
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
              showingTooltipIndicators: [0],
            ));
            index++;
          }
          // Si data está vacía, muestra un mensaje o gráfico vacío
          if (barGroups.isEmpty) {
            return Center(child: Text("No restaurant data available"));
          }
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            color: Color.fromARGB(255, 255, 255, 255),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        'Estadísticas de Empleados por Restaurante',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceBetween,
                        maxY: barGroups
                                .map((bg) => bg.barRods.first.y)
                                .reduce(max) +
                            5,
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: Colors.white,
                            getTooltipItem: (BarChartGroupData group,
                                int groupIndex,
                                BarChartRodData rod,
                                int rodIndex) {
                              return BarTooltipItem(
                                '${rod.y}',
                                TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: SideTitles(showTitles: false),
                          leftTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) => TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                            margin: 10,
                          ),
                        ),
                        gridData: FlGridData(show: true),
                        borderData: FlBorderData(show: true),
                        groupsSpace: 12,
                        barGroups: barGroups,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(child: Text("Awaiting restaurant data..."));
        }
      },
    );
  }
}

//-------------------------------------------------------------DASHBOARD DE TOP 5 COMIDAS
// Widget para el gráfico de barras
class TopMealsChart extends StatelessWidget {
  final String topMealsUrl =
      'http://www.restaurante.somee.com/Api/Plato/PlatosTop';

  Future<List<PlatoTop>> fetchTopMeals() async {
    final response = await http.get(Uri.parse(topMealsUrl), headers: {
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body)['data'] as List;
      return jsonList.map((json) => PlatoTop.fromJson(json)).toList();
    } else {
      throw Exception(
          'Error al cargar los platos más vendidos: ${response.statusCode}');
    }
  }

  TopMealsChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PlatoTop>>(
      future: fetchTopMeals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor), // Cambia el color aquí
              strokeWidth: 5.0, // Cambia el grosor de la línea aquí
              // Si quieres cambiar el tamaño, puedes envolverlo en un SizedBox:
              // child: SizedBox(
              //   width: 50, // Ancho del CircularProgressIndicator
              //   height: 50, // Alto del CircularProgressIndicator
              //   child: CircularProgressIndicator(...),
              // ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final topMeals = snapshot.data!;
          final maxY = topMeals
              .fold(0, (prev, el) => max(prev, el.totalVendidos))
              .toDouble();

          return Card(
            elevation: 3,
            color: const Color.fromARGB(255, 255, 255, 255),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Estadistica Top 5 Comidas Más Vendidas',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: maxY,
                        titlesData: FlTitlesData(
                          bottomTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) => const TextStyle(
                              color: Color.fromARGB(255, 5, 5, 5),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            margin: 20,
                            getTitles: (double value) {
                              return topMeals[value.toInt()].nombrePlato;
                            },
                          ),
                          leftTitles: SideTitles(showTitles: false),
                        ),
                        barGroups: topMeals.asMap().entries.map((entry) {
                          final index = entry.key;
                          final plato = entry.value;
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                y: plato.totalVendidos.toDouble(),
                                colors: [
                                  Color.fromARGB(255, 238, 164, 104),
                                  Color.fromARGB(255, 226, 120, 21)
                                ],
                                borderRadius: BorderRadius.circular(4),
                                width: 40,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Text('No hay datos disponibles');
        }
      },
    );
  }
}

//---------------------------------------------DASBOARD DE CLIENTES POR DEPARTAMENTOS

class DepartmentClientsChart extends StatelessWidget {
  final String clientesPorDepartamentoUrl =
      'http://www.restaurante.somee.com/Api/Cliente/Clien_Departamento';

  Future<List<ClienteDepartamento>> fetchClientesPorDepartamento() async {
    final response = await http.get(
      Uri.parse(clientesPorDepartamentoUrl),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Verificamos que el cuerpo de la respuesta no sea nulo
      if (response.body == "") {
        throw Exception('El cuerpo de la respuesta está vacío');
      }

      final Map<String, dynamic> parsed = json.decode(response.body);

      // Verificamos que el JSON contenga la llave 'data'
      if (!parsed.containsKey('data') || parsed['data'] == null) {
        throw Exception('El JSON no contiene la llave \'data\' o es nula');
      }

      final jsonList = parsed['data'] as List;
      return jsonList
          .map((json) => ClienteDepartamento.fromJson(json))
          .toList();
    } else {
      throw Exception(
          'Error al cargar los clientes por departamento: ${response.statusCode}');
    }
  }

  DepartmentClientsChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ClienteDepartamento>>(
      future: fetchClientesPorDepartamento(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data != null) {
          final data = Map.fromIterable(
            snapshot.data!,
            key: (item) => (item as ClienteDepartamento).depaDepartamento,
            value: (item) => (item as ClienteDepartamento).cantidadClientes,
          );

          List<PieChartSectionData> sections = [];
          int total = data.values.fold(0, (sum, value) => sum + value);
          int index = 0;

          data.forEach((department, count) {
            final color = Colors.primaries[index % Colors.primaries.length];
            sections.add(
              PieChartSectionData(
                color: color,
                value: count.toDouble(),
                title: '$count',
                titleStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff),
                ),
                radius: 120,
              ),
            );
            index++;
          });

          return AspectRatio(
            aspectRatio: 1.0,
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Estadisticas de clientes por Departamento',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),
                    Expanded(
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 0,
                          sections: sections,
                        ),
                      ),
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 8,
                      children: data.keys.map((department) {
                        final color = Colors.primaries[
                            data.keys.toList().indexOf(department) %
                                Colors.primaries.length];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.circle, size: 12, color: color),
                              const SizedBox(width: 8),
                              Text(department),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Text('No hay datos disponibles');
        }
      },
    );
  }
}
