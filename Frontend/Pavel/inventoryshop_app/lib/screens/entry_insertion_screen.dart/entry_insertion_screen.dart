import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

class EntryInsertionScreen extends StatelessWidget {
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
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
