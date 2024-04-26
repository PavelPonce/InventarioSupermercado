import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/entry_insertion_screen.dart/components/entry_form.dart';

class EntryInsertionScreen extends StatelessWidget {
  static String routeName = '/entry_insertion';


  const EntryInsertionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nuevo Ingreso"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: kMyPrimaryGradientColor,
        ),
        child: const Stack(
          children: [
            Column(
              children: [
                EntryForm(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
