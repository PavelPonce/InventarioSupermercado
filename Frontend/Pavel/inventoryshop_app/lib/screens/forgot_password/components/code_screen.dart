import 'package:flutter/material.dart';
import 'package:shop_app/screens/forgot_password/components/code_form.dart';

class CodeVerification extends StatelessWidget {
  const CodeVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reestablecer Contraseña"),
      ),
      body: const SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 16),
                Text(
                  "Su codigo de verificacion fue enviado.",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Porfavor ingrese el codigo que fue enviado a su correo electrónico",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                CodeForm(),
              ],
            ),
          ),
        ),
      ),
    );
  
  }
}