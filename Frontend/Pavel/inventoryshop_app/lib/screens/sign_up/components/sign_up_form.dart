import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/UsuariosViewModel.dart';
import 'package:shop_app/utilities/api_endpoints.dart'; 

import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../complete_profile/complete_profile_screen.dart';
import 'package:http/http.dart' as http;

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  UsuariosViewModel _usuarioViewModel = UsuariosViewModel(); 
  String? user;
  String? email;
  String? password;
  String? conform_password;
  bool remember = false;
  final List<String?> errors = [];


  Future<void> _crearUsuario() async {
    String urlCrearUsuario = "http://paapi.somee.com/api/Usuario/Insert/Usuarios";
    var url = Uri.parse(
      ApiEndPoint.baseUrl + 'Numeration',
    );

    if (_formKey.currentState!.validate()) {
      try {
        var respo = await http.get(url);
        var json = jsonDecode(respo.body);
        var clienteid = json['data']['Clien_Id'] + 1;

      await http.post(
        Uri.parse(urlCrearUsuario),
        body: jsonEncode({
          "Usuar_Usuario": _usuarioViewModel.usuarUsuario,
          "Usuar_Contrasena": _usuarioViewModel.usuarContrasena,
          "Perso_Id": clienteid,
          "Roles_Id": 1,
          "Usuar_Admin": 0,
          "Usuar_Tipo": 0,
        }),

        headers: {
          "Content-Type": "application/json",
        },
      );
    }catch (e) {
      print("Error: $e");
    }
  }
  }



  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => _usuarioViewModel.usuarUsuario = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              } else if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kEmailNullError);
                return "";
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Usuario",
              hintText: "Ingresa tu usuario",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),         
          const SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => _usuarioViewModel.usuarContrasena = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
              password = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if (value.length < 8) {
                addError(error: kShortPassError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Contraseña",
              hintText: "Ingresa tu Contraseña",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            onSaved: (newValue) => conform_password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } else if (value.isNotEmpty && _usuarioViewModel.usuarContrasena == conform_password) {
                removeError(error: kMatchPassError);
              }
              conform_password = value;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              } else if ((password != value)) {
                addError(error: kMatchPassError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Confirma tu Contraseña",
              hintText: "Re-ingresa tu Contraseña",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          FormError(errors: errors),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                _crearUsuario();
                // if all are valid then go to success screen
                Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              }
            },
            child: const Text("Continuar"),
          ),
        ],
      ),
    );
  }
}
