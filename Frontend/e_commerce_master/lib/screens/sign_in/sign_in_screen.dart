
import 'package:inventoryshop_app/screens/sign_in/components/input_text.dart';
import 'package:inventoryshop_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';


class LoginScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Future<dynamic> Login() async{

      final String url = "https://localhost:44307/Usuario/Login/" + usernameController.text + "/" + passwordController.text;
      final result = await http.get(Uri.parse(url));

      if(result.statusCode == 200){
        
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (home) => HomeScreen())
          );
      }else{
         Navigator.push(
            context, 
            MaterialPageRoute(builder: (home) => LoginScreen())
          );
      }
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange.shade900,
              Colors.orange.shade800,
              Colors.orange.shade400
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 25,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: FadeInUp(duration: Duration(milliseconds: 1000), child: SvgPicture.asset('../../assets/images/logo.svg',width: 70.0,height: 70.0,)),
                  ),
                  SizedBox(height: 10,),
                  FadeInUp(duration: Duration(milliseconds: 1000), child: Text("Inicio de Sesión", style: TextStyle(color: Colors.white, fontSize: 30),)),
                  SizedBox(height: 10,),
                  FadeInUp(duration: Duration(milliseconds: 1300), child: Text("Bienvenido", style: TextStyle(color: Colors.white, fontSize: 18),)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60,),
                        FadeInUp(duration: Duration(milliseconds: 1400), child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              color: Color.fromRGBO(225, 95, 27, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10)
                            )]
                          ),
                          child: Column(
                            children: <Widget>[
                              InputText(
                                controller: usernameController,
                                hintText: "Usuario",
                                obscureText: false,
                              ),
                              InputText(
                                controller: passwordController,
                                hintText: "Contraseña",
                                obscureText: true,
                              ),
                            ],
                          ),
                        )),
                        SizedBox(height: 40,),
                        FadeInUp(duration: Duration(milliseconds: 1500), child: Text("Olvido su Contraseña?", style: TextStyle(color: Colors.grey),)),
                        SizedBox(height: 40,),
                        FadeInUp(duration: Duration(milliseconds: 1600), child: MaterialButton(
                          onPressed: Login,
                          height: 50,
                          // margin: EdgeInsets.symmetric(horizontal: 50),
                          color: Colors.orange[900],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),

                          ),
                          // decoration: BoxDecoration(
                          // ),
                          child: Center(
                            child: Text("Ingresar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        )),
                      ],
                    ),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
  
}
