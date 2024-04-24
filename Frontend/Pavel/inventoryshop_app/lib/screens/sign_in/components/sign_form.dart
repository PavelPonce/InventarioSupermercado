import 'dart:convert';

import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/utilities/api_endpoints.dart';
import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../helper/keyboard.dart';
import '../../forgot_password/forgot_password_screen.dart';
import '../../login_success/login_success_screen.dart';
import 'package:http/http.dart' as http;

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  bool? remember = false;
  final List<String?> errors = [];

  

  Future<bool> login(String username, String password) async {
    var urlLogin = Uri.parse(
    ApiEndPoint.baseUrl + ApiEndPoint.usuarioEndPoints.login + username + '/' + password
    );
    http.Response result = await http.get(urlLogin);
    if(result.statusCode == 200){
      final json = jsonDecode(result.body);
      if(json['code'] == 200){
          WriteCache.setJson(key: 'user', value: json['data']);
          WriteCache.setBool(key: 'loggedIn', value: true);
          return true;
      }else{
        return false;
      }
    }else{
      return false;
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
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) => username = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: kEmailNullError);
                } 
                return;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: kEmailNullError);
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
                suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
              ),
            ),
          ),
          //const SizedBox(height: 20),
           Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
            obscureText: true,
            onSaved: (newValue) => password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              } 
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              }

              return null;
            },
            decoration: const InputDecoration(
              labelText: "Contraseña",
              hintText: "Ingresa tu contraseña",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
         
           ),
          // const SizedBox(height: 20),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Olvidé mi contraseña",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async{
              
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                  KeyboardUtil.hideKeyboard(context);

                  // Async login process
                    
                    bool isLoggedIn = await login(username.toString(), password.toString());
                    if (isLoggedIn) {
                      Navigator.pushNamedAndRemoveUntil(context, LoginSuccessScreen.routeName, (route) => false);
                    } else {
                      addError(error: "Usuario o contraseña incorrectos");
                    }
              }
            },
            child: const Text("Continuar"),
          ),
        ],
      ),
    );
  }
}
