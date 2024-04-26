// gender_statistics_card.dart
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/screens/dashboard/components/clientRegistersByGender.dart';
import 'package:shop_app/screens/dashboard/components/salesByCategoryPieChart.dart';
import 'package:shop_app/screens/dashboard/components/salesByGenerPieChart.dart';
import 'package:shop_app/screens/dashboard/components/salesByMonth.dart';
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
            Text(
              "Cantidad de Ventas por Genero",
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SalesByGenderPieChart(),
            ),
            SizedBox(height: 5),
            Divider(
              color: Colors.grey.shade600,
              indent:
                  32, // Inicio del divisor con espacio desde el borde izquierdo
              endIndent:
                  32, // Final del divisor con espacio desde el borde derecho
            ),
            Text(
              "Total de Ventas por Categoria",
              textAlign: TextAlign.center,
            ), // Línea divisoria entre cards
            Container(
              height: 400,
              child: SalesByCategoryPieChart(),
            ),

            SizedBox(height: 5),

            Divider(color: Colors.grey.shade600, indent: 32, endIndent: 32),
            Text(
              "Cantidad de Registros por Genero",
              textAlign: TextAlign.center,
            ), 
            Container(
              height: 400,
              child: ClienteRegistroPorGeneroPieChart(),
            ),
            Divider(color: Colors.grey.shade600, indent: 32, endIndent: 32),
            // Línea divisoria entre cards
            Text(
              "Total de Ventas por Mes",
              textAlign: TextAlign.center,
            ), 
            AspectRatio(
              aspectRatio:
                  1, // Este es un ejemplo, ajusta la relación según necesites
              child:GananciaPorMesBarChart(),
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
    return const Placeholder(); 
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
    return const Placeholder();
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
