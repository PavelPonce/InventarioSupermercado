import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';

class LoadingScreen extends StatelessWidget {
  static String routeName = "/loading";

  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: kMyPrimaryGradientColor,
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(kPrimaryLightColor),
          ),
          SizedBox(height: 16),
          Text(
            'Cargando...',
            style: TextStyle(
              color: kPrimaryLightColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}