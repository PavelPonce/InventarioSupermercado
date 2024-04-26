import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator( 
              valueColor: AlwaysStoppedAnimation<Color>(kPrimaryLightColor),
            ),
          const SizedBox(height: 10,),
          SvgPicture.asset('assets/icons/logo.svg',width: 50.0,height: 50.0,),   
        ],
      ),
    );
  }
}