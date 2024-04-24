import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/screens/home/usuarios_create.dart'; 
import 'package:shop_app/screens/home/usuarios_edit.dart'; 

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
  List<UsuariosViewModel> _usuarios = [];

  @override
  void initState() {
    super.initState();
    _getListado();
  }

  Future<void> _getListado() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<UsuariosViewModel> usuarios = responseData.map((user) {
        return UsuariosViewModel.fromJson(user);
      }).toList();
      setState(() {
        _usuarios = usuarios;
      });
    } else {
      throw Exception("Error");
    }
  }

 Future<void> _eliminarUsuario(int userId) async {
  final deleteUrl = "https://localhost:44307/api/Usuario/Delete/Usuarios?Usuar_Id=$userId";
  final response = await http.delete(Uri.parse(deleteUrl));

  if (response.statusCode == 200) {
    await _getListado();
  } else {
    throw Exception("Error eliminando usuario");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listado de Usuarios"),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CrearUsuarioView()), 
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CrearUsuarioView()), 
              );
            },
            child: Text('Crear Nuevo Usuario'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
              dataRowColor: MaterialStateColor.resolveWith(
                (states) => const Color.fromARGB(255, 255, 255, 255)!,
              ),
              columns: [
                DataColumn(
                  label: Text('ID'),
                ),
                DataColumn(
                  label: Text('Usuario'),
                ),
                DataColumn(
                  label: Text('Descripción de Roles'),
                ),
                DataColumn(
                  label: Text('Nombre Completo'),
                ),
                DataColumn(
                  label: Text('Acciones'),
                ),
              ],
              rows: _usuarios.map((user) {
                return DataRow(
                  cells: [
                    DataCell(Text(user.usuarId.toString())),
                    DataCell(Text(user.usuarUsuario)),
                    DataCell(Text(user.rolesDescripcion ?? "")),
                    DataCell(Text(user.nombreCompleto ?? "")),
                    DataCell(
                      Row(
                        children: [
         OutlinedButton(
          onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditarUsuarioView(userId: user.usuarId)),
    );
  },
  child: const Text(
    'Editar',
    style: TextStyle(fontSize: 20),
  ),
),


                          SizedBox(width: 10),
                          OutlinedButton(
                            onPressed: () {
                              _confirmarEliminacion(user.usuarId);
                            },
                            child: const Text(
                              'Eliminar',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }



  Future<void> _confirmarEliminacion(int userId) async {
    bool confirmacion = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar eliminación"),
          content: Text("¿Estás seguro de que deseas eliminar este usuario?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("Sí"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("No"),
            ),
          ],
        );
      },
    );

    if (confirmacion == true) {
      await _eliminarUsuario(userId);
    }
  }
}




void main() {
  runApp(MaterialApp(
    home: MyWidget(),
  ));
}
