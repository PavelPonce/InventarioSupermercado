import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';
import '../../components/no_account_text.dart';
import 'components/sign_form.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: kMyPrimaryGradientColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           const SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: FadeInUp(duration: const Duration(milliseconds: 1000), child: SvgPicture.asset('../../../assets/svg/logo.svg',width: 70.0,height: 70.0,)),
                  ),
                  const SizedBox(height: 10,),
                  FadeInUp(duration: const Duration(milliseconds: 1000), child: const Text("Inicio de Sesión", style: TextStyle(color: Colors.white, fontSize: 30),)),
                  const SizedBox(height: 10,),
                  FadeInUp(duration: const Duration(milliseconds: 1300), child: const Text("Bienvenido", style: TextStyle(color: Colors.white, fontSize: 18),)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  FadeInUp(duration: const Duration(milliseconds: 1000), child: const Padding(
                    padding: EdgeInsets.all(30),
                    child: SignForm(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(duration: const Duration(milliseconds: 1000), child:const NoAccountText(),),
                  ]
                )
                
              ),
            )
          ],
        ),
      ),
    );
   }
}
