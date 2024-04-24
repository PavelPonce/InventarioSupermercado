import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class Product {
  final int id;
  final String descipcion;
  final int existencia;
  final double precCompra;
  final double precVenta;
  final int unidId;
  final int impueId;
  final int catId;
  final int preveedorId;
  final bool estado;
  final String url; 
  final String unidadDescrip;
  final String proveedorMarca;
  final double impuesto;

  Product({
    required this.id,
    required this.descipcion,
    required this.existencia,
    required this.precCompra,
    required this.precVenta,
    required this.unidId,
    required this.impueId,
    required this.catId,
    required this.preveedorId,
    required this.estado,
    this.url = 'https://i.stack.imgur.com/DPGsM.png', //cambiarrrrrrrrrr
    required this.unidadDescrip,
    required this.proveedorMarca,
    required this.impuesto,
  }) {
    print('trayendo producto:--------------------------------');
    print('id: $id');
    print('descripcion: $descipcion');
    print('existencia: $existencia');
    print('PrecioCompra: $precCompra');
    print('Price Venta: $precVenta');
    print('Unidad ID: $unidId');
    print('Impuesto ID: $impueId');
    print('categoria ID: $catId');
    print('proveedor ID: $preveedorId');
    print('estado: $estado');
    print(' URL: $url');
    print('unidad Description: $unidadDescrip');
    print('proveedor Brand: $proveedorMarca');
    print('impuesto Description: $impuesto');
  }



 
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['produ_Id'] ?? 0,
      descipcion: json['produ_Descripcion'] ?? '',
      existencia: json['produ_Existencia'] ?? 0,
      precCompra: (json['produ_PrecioCompra'] as num?)?.toDouble() ?? 0.0,
      precVenta: (json['produ_PrecioVenta'] as num?)?.toDouble() ?? 0.0,
      unidId: json['unida_Id'] ?? 0,
      impueId: json['impue_Id'] ?? 0,
      catId: json['categ_Id'] ?? 0,
      preveedorId: json['prove_Id'] ?? 0,
      estado: json['produ_Estado'] ?? false,
      url: json['produ_ImagenUrl'] ?? 'https://i.stack.imgur.com/DPGsM.png', // Valor por defecto
      unidadDescrip: json['unida_Descripcion'] ?? '',
      proveedorMarca: json['prove_Marca'] ?? '',
      impuesto: (json['impue_Descripcion'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class CartScreen extends StatefulWidget {
  static const String routeName = "/cart";
  final int clientId;

  const CartScreen({Key? key, required this.clientId}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}


class _CartScreenState extends State<CartScreen> {
  late List<Product> products = [];

  @override
  void initState() {
    super.initState();
    loadCartProducts(widget.clientId);
  }



Future<void> loadCartProducts(int clientId) async {
  print('Cargando productos para el cliente $clientId');
  try {
    final response = await http.get(
      Uri.parse('https://localhost:44307/Cargar/ListadoCarritoPrincipal?Clien_Id=$clientId'),
    );
    print('Respuesta del servidor: ${response.statusCode}');
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      if (responseData.isNotEmpty) {
        setState(() {
          products = responseData.map((json) => Product.fromJson(json)).toList();
          print('siii se cargo correctamente: $products');
        });
      } else {
        print('noo trae nada el servidorrrr');
      }
    } else {
      print('errorrrrrrrrrrrrrrrr al cargar productos: ${response.statusCode}');
      throw Exception('no je cargo');
    }
  } catch (error) {
    print('Errorrrrrr: $error');
  }
}








  @override
  Widget build(BuildContext context) {
    print('mostrar en mii carritoo');
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "Tu carrito",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "${products.length} items",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          // itemCount: products.length,
          children: products.map((product) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CartCard(product: product),
            );
          }).toList(),
        ),
      ),
      bottomNavigationBar: const CheckoutCard(),
    );
  }
}








class CartCard extends StatelessWidget {
  final Product product;

  const CartCard({required this.product});

  @override
  Widget build(BuildContext context) {
   print('############################################');
    print('tarjetaaa para el producto: $product');
     print('tarjetaaa para el producto: $product');
  print('ID: ${product.id}');
  print('descripcion: ${product.descipcion}');
  print('existencia: ${product.existencia}');
  print('Precio compra: ${product.precCompra}');
  print('Precio venta: ${product.precVenta}');
  print('Unidad ID: ${product.unidId}');
  print('Impuesto ID: ${product.impueId}');
  print('categoria ID: ${product.catId}');
  print('proveedor ID: ${product.preveedorId}');
  print('estado: ${product.estado}');
  print(' URL: ${product.url}');
  print('unidad descripcion: ${product.unidadDescrip}');
  print('proveedor Brand: ${product.proveedorMarca}');
  print('impuesto descripcion: ${product.impuesto}');
  print('#############################################');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), 

          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(product.url),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descripcion: ${product.descipcion}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Precio: \$${product.precVenta.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Proveedor: ${product.proveedorMarca}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
            },
          ),
        ],
      ),
    );
  }
}





class CheckoutCard extends StatelessWidget {
  const CheckoutCard();

  @override
  Widget build(BuildContext context) {
    return Container(

// TARJETAAAAAAAA


    );
  }
}

void main() {
  runApp(MaterialApp(
    routes: {
      CartScreen.routeName: (context) => CartScreen(clientId: 5),
    },
  ));
}
