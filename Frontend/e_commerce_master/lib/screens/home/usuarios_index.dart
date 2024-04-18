import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsuariosViewModel {
  int usuarId;
  String usuarUsuario;
  String? empleado;
  String? rolesDescripcion;
  String? nombreCompleto;


  UsuariosViewModel({
    required this.usuarId,
    required this.usuarUsuario,
    this.empleado,
    this.rolesDescripcion,
    this.nombreCompleto,
  });

  factory UsuariosViewModel.fromJson(Map<String, dynamic> json) {
    return UsuariosViewModel(
      usuarId: json['usuar_Id'],
      usuarUsuario: json['usuar_Usuario'],
      empleado: json['empleado'],
      rolesDescripcion: json['roles_Descripcion'],
      nombreCompleto: json['perso_NombreCompleto'],

    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key});

  static String routeName = "/home";
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String url = "https://localhost:44307/api/Usuario/List/Usuarios";

  Future<List<UsuariosViewModel>> _getListado() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<UsuariosViewModel> usuarios = responseData.map((user) {
        return UsuariosViewModel.fromJson(user);
      }).toList();
      return usuarios;
    } else {
      throw Exception("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listado de Usuarios"),
         backgroundColor: Color.fromARGB(255, 34, 29, 8),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<UsuariosViewModel>>(
        future: _getListado(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Usuario')),
                  DataColumn(label: Text('Descripción de Roles')),
                  DataColumn(label: Text('Nombre Completo')),
                ],
                rows: snapshot.data!.map((user) {
                  return DataRow(cells: [
                    DataCell(Text(user.usuarId.toString())),
                    DataCell(Text(user.usuarUsuario)),
                    DataCell(Text(user.rolesDescripcion ?? "")),
                    DataCell(Text(user.nombreCompleto ?? "")),
                  ]);
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
