import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/UsuariosViewModel.dart'; 

class CrearUsuarioView extends StatefulWidget {
  const CrearUsuarioView({Key? key}) : super(key: key);

  @override
  _CrearUsuarioViewState createState() => _CrearUsuarioViewState();
}

class _CrearUsuarioViewState extends State<CrearUsuarioView> {
  final _formKey = GlobalKey<FormState>();
  UsuariosViewModel _usuarioViewModel = UsuariosViewModel(); 
  List<Rol> _roles = [];
  List<Empleado> _empleados = [];
  int? _selectedRoleId;
  int? _selectedEmpleadoId;
  bool _selectedTipoPersona = true;
  bool _isAdmin = false; 
  String urlCrearUsuario = "http://paapi.somee.com/api/Usuario/Insert/Usuarios";
  String urlRoles = "http://paapi.somee.com/api/Usuario/List/Roles";
  String urlEmpleados = "http://paapi.somee.com/api/Usuario/List/Empleados";

  @override
  void initState() {
  super.initState();
  _fetchRoles();
  _fetchEmpleados(); 
}


  Future<void> _fetchRoles() async {
    try {
      final response = await http.get(Uri.parse(urlRoles));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          _roles = responseData.map((role) => Rol.fromJson(role)).toList();
        });
      } else {
        throw Exception("Error al obtener roles");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
Future<void> _fetchEmpleados() async {
  try {
    final response = await http.get(Uri.parse(urlEmpleados));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      print("Respuesta de empleados: $responseData");  
      setState(() {
        _empleados = responseData.map((emp) => Empleado.fromJson(emp)).toList();
      });
    } else {
      throw Exception("Error al obtener empleados");
    }
  } catch (e) {
    print("Error: $e");
  }
}



 Future<void> _crearUsuario() async {
  if (_formKey.currentState!.validate()) {
    try {
      print("Enviando solicitud...");

      final response = await http.post(
        Uri.parse(urlCrearUsuario),
      body: jsonEncode({
  "5": _usuarioViewModel.usuarUsuario,
  "Usuar_Contrasena": _usuarioViewModel.usuarContrasena,
  "Perso_Id": _selectedEmpleadoId,
  "Roles_Id": _selectedRoleId,
  "Usuar_Admin": _isAdmin, 
  "Usuar_Tipo": _selectedTipoPersona,
}),

        headers: {
          "Content-Type": "application/json",
        },
      );

      print("Respuesta recibida: ${response.statusCode}");
      print("Cuerpo de la respuesta: ${response.body}");

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Usuario creado exitosamente"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error al crear usuario"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crear Usuario"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                onChanged: (value) => _usuarioViewModel.usuarUsuario = value,
                decoration: InputDecoration(labelText: 'Usuario'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un usuario';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                onChanged: (value) => _usuarioViewModel.usuarContrasena = value,
                decoration: InputDecoration(labelText: 'Contraseña'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una contraseña';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _selectedEmpleadoId,
                onChanged: (newValue) {
                  setState(() {
                    _selectedEmpleadoId = newValue!;
                  });
                },
                items: _empleados.map((emp) {
                  return DropdownMenuItem<int>(
                    value: emp.id,
                    child: Text(emp.nombreCompleto),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Empleado'),
                validator: (value) {
                  if (value == null || value == -1) {
                    return 'Por favor selecciona un empleado';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _selectedRoleId,
                onChanged: (newValue) {
                  setState(() {
                    _selectedRoleId = newValue!;
                  });
                },
                items: _roles.map((rol) {
                  return DropdownMenuItem<int>(
                    value: rol.id,
                    child: Text(rol.descripcion),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Roles'),
                validator: (value) {
                  if (value == null || value == -1) {
                    return 'Por favor selecciona un rol';
                  }
                  return null;
                },
              ),             
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _isAdmin,
                    onChanged: (value) {
                      setState(() {
                        _isAdmin = value ?? false; 
                      });
                    },
                  ),
                  Text('Administrador'),
                ],
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _crearUsuario,
                  child: Text('Crear Usuario'),
                ),
              ),

             
            ],
            
          ),
        ),
      ),
    );
  }
}




class Rol {
  final int id;
  final String descripcion;

  Rol({
    required this.id,
    required this.descripcion,
  });

  factory Rol.fromJson(Map<String, dynamic> json) {
    return Rol(
      id: json['roles_Id'],
      descripcion: json['roles_Descripcion'],
    );
  }
}

class Empleado {
  final int id;
  final String nombreCompleto;

  Empleado({
    required this.id,
    required this.nombreCompleto,
  });

  factory Empleado.fromJson(Map<String, dynamic> json) {
    return Empleado(
      id: json['emple_Id'], 
      nombreCompleto: json['empleado'], 
    );
  }
}

