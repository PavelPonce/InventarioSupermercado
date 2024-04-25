import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product {
  final int id;
  final String description;
  final int existence;
  final double pricePurchase;
  final double priceSale;
  final int unitId;
  final int taxId;
  final int categoryId;
  final int providerId;
  final bool state;
  final String imageUrl;
  final String unitDescription;
  final String providerBrand;
  final double taxDescription;

  Product({
    required this.id,
    required this.description,
    required this.existence,
    required this.pricePurchase,
    required this.priceSale,
    required this.unitId,
    required this.taxId,
    required this.categoryId,
    required this.providerId,
    required this.state,
    required this.imageUrl,
    required this.unitDescription,
    required this.providerBrand,
    required this.taxDescription,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['produ_Id'],
      description: json['produ_Descripcion'],
      existence: json['produ_Existencia'],
      pricePurchase: json['produ_PrecioCompra'].toDouble(),
      priceSale: json['produ_PrecioVenta'].toDouble(),
      unitId: json['unida_Id'],
      taxId: json['impue_Id'],
      categoryId: json['categ_Id'],
      providerId: json['prove_Id'],
      state: json['produ_Estado'],
      imageUrl: json['produ_ImagenUrl'] ?? '',
      unitDescription: json['unida_Descripcion'] ?? '',
      providerBrand: json['prove_Marca'] ?? '',
      taxDescription: json['impue_Descripcion'].toDouble(),
    );
  }
}

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> products = [];

  Future<void> getProducts() async {
    final int clientId = 5; 
    final response = await http.get(
      Uri.parse('https://localhost:44307/Cargar/ListadoCarritoPrincipal?Clien_Id=$clientId'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        try {
          //mapeoooooooo
          products = responseData
              .map((json) => Product.fromJson(json))
              .toList();
        } catch (error) {
          print('Error al mapear los datos: $error');
        }
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              "Your Cart",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "${products.length} items",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CartCard(product: products[index]),
          ),
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
    return Container(
      // Implementa la UI para mostrar los detalles del producto en el carrito
    );
  }
}

class CheckoutCard extends StatelessWidget {
  const CheckoutCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      // Implementa la UI para mostrar la tarjeta de pago
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CartScreen(),
  ));
}
