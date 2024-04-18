import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;



class MyWidget extends StatefulWidget{
  const MyWidget ({super.key});


  @override
  State<MyWidget> createState()=> _MyWidgetState();
}

//Future
//Final----=cons, != asignar valor en la aplicacion
//Dinamic
class _MyWidgetState extends State<MyWidget> {

String url = "https://api.thecatapi.com/v1/categories";

Future<dynamic> _getListado() async{
final result = await http.get(Uri.parse(url));

if(result.statusCode == 200){
  return jsonDecode(result.body);
}else{
  print("Error en el Endpoint");
}
}
//final respuesta=

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      title: Text("Listado API"),
      ),
      body: FutureBuilder<dynamic>(
       future: _getListado(),
       builder: (context, snapshot){
        if(snapshot.hasData){
          return ListView(
            children: listado(snapshot.data)
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
       },

      ),
    );
  }
}

List<Widget> listado(List<dynamic>? info)
{
  List<Widget> lista = [];
  if(info!=null)
  {
    info.forEach((element) {
      lista.add(Text(element["name"]));
    });
  }
  return lista;
}