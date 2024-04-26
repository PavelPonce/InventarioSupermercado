import 'package:flutter/material.dart';
import 'package:shop_app/screens/forgot_password/components/reestablecer_form.dart';

class ReestablecerScreen extends StatelessWidget {
  const ReestablecerScreen({super.key});

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
                  "Su codigo fue correcto",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Poravor Ingrese su nueva contraseña",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                ReestablecerForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}