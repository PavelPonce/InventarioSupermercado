import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/utilities/api_endpoints.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/form_error.dart';
import '../../../components/no_account_text.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;

class CodeForm extends StatefulWidget {
  const CodeForm({super.key});

  @override
  _CodeFormState createState() => _CodeFormState();
}

class _CodeFormState extends State<CodeForm> {
  Future<void> sendEmail() async{
    var url = Uri.parse(
      ApiEndPoint.baseUrl + 'Email/SendMail',
    );

    await http.post(url,
    body: jsonEncode({
          "EmailToId": email,
          "EmailToName": 'string',
          "EmailSubject": 'string',
          "EmailBody": 'string',
          "VerificationCode": 'string',
        }),
      );
  }


  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  String? email;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                setState(() {
                  errors.remove(kEmailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.remove(kInvalidEmailError);
                });
              }
              return;
            },
            validator: (value) {
              if (value!.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Código de Verificacion",
              hintText: "Ingresa tu Código de Verificacion",
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
