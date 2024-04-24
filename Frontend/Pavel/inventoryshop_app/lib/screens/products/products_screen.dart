import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';
//import 'package:shop_app/screens/home/components/home_header.dart';
import 'dart:convert';

class ProductsScreen extends StatefulWidget {
  static String routeName = "/products";

  final int categoryId;
  //final String categDescripcion;

  const ProductsScreen({Key? key, required this.categoryId/*, required this.categDescripcion*/}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late Future<List<Map<String, dynamic>>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = fetchProducts();
  }

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final response = await http.get(
        Uri.parse('http://paapi.somee.com/api/Productos/List/Productos?categId=${widget.categoryId}'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final products = snapshot.data!;
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  title: product['produ_Descripcion'] ?? '',
                  subtitle: product['unida_Descripcion'] ?? '',
                  // Puedes agregar más propiedades aquí según sea necesario
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const ProductCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                color: Colors.orange, // Cambiar color de fondo a naranja
                image: DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/150'), // Imagen por defecto desde una URL
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.5), // Cambiar color de la sombra
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.shopping_cart,
                  size: 64,
                  color: Colors.white, // Cambiar color del icono a blanco
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Implementa la acción cuando se presione "Add to Cart"
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add_shopping_cart, color: Colors.orange), // Cambiar icono de "Add to Cart"
                          SizedBox(width: 4),
                          Text(
                            "Add to Cart",
                            style: TextStyle(color: Colors.orange), // Cambiar color del texto a naranja
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Implementa la acción cuando se presione el botón de favoritos en la tarjeta
                      },
                      icon: Icon(Icons.favorite_border),
                      color: Colors.orange, // Cambiar color del icono a naranja
                    ),
                    // Agregar otro IconButton o cualquier otro widget según sea necesario
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
