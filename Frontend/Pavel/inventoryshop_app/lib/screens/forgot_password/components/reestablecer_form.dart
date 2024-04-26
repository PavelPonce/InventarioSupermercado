import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/utilities/api_endpoints.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../components/no_account_text.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;

class ReestablecerForm extends StatefulWidget {
  const ReestablecerForm({super.key});

  @override
  _ReestablecerFormState createState() => _ReestablecerFormState();
}

class _ReestablecerFormState extends State<ReestablecerForm> {
  Future<void> sendEmail() async{
    try {
      var url = Uri.parse(
      ApiEndPoint.baseUrl + 'Email/SendMail',
    );

    await http.post(url,
    body: jsonEncode({
          "Usuar_Contrasena": password,
        }),
      );
    } catch (Exception) {
      print('');
    }
    
  }


  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? password;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            onSaved: (newValue) => password = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  errors.remove(kPassNullError);
                });
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty && !errors.contains(kPassNullError)) {
                setState(() {
                  errors.add(kPassNullError);
                });
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Contraseña",
              hintText: "Ingresa tu contraseña",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          const SizedBox(height: 8),
          FormError(errors: errors),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Do what you want to do
              }
            },
            child: const Text("Continuar"),
          ),
          const SizedBox(height: 16),
          const NoAccountText(),
        ],
      ),
    );
  }
}
