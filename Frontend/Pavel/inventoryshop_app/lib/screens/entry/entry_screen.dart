import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/constants.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: kMyPrimaryGradientColor,
        ),
        child: Stack(
          children: [
            const Column(
              children: [],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FloatingActionButton(
                  backgroundColor: kPrimaryLightColor.withOpacity(0.6),
                  focusColor: kPrimaryLightColor.withOpacity(0.6),
                  child: const Icon(
                    Icons.add,
                    color: kPrimaryLightColor,
                  ),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
