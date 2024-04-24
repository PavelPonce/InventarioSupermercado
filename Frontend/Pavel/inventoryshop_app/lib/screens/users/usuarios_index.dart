import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/users/usuarios_create.dart'; 
import 'package:shop_app/screens/users/usuarios_edit.dart'; 

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

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key});

  static String routeName = "/home";
  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String url = "http://paapi.somee.com/api/Usuario/List/Usuarios";
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
  final deleteUrl = "http://paapi.somee.com/api/Usuario/Delete/Usuarios?Usuar_Id=$userId";
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

      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: kMyPrimaryGradientColor,
        ),
        child:
         Stack(
          children: [
          Column(
            children: [
               SvgPicture.asset('../../../assets/svg/logo.svg',width: 50.0,height: 50.0,),
            const SizedBox(height: 10,),
            SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.bold,
              ),
              dataRowColor: MaterialStateColor.resolveWith(
                (states) => const Color.fromARGB(255, 255, 255, 255),
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
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
            padding: EdgeInsets.all(8),
            child: FloatingActionButton(
              backgroundColor: kPrimaryLightColor.withOpacity(0.6),
              focusColor: kPrimaryLightColor.withOpacity(0.6),
              child: Icon(
                Icons.add,
                color: kPrimaryLightColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CrearUsuarioView()), 
                );
              },            
            ), 
          ),
          )
         
          ],
        ),
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