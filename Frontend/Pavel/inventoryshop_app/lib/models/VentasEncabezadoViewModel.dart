import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsScreen extends StatefulWidget {
  static String routeName = "/products";

  final int categoryId;
  final int clientId; 

  const ProductsScreen({Key? key, required this.categoryId, this.clientId = 5}) : super(key: key); // Asignar valor por defecto a clientId

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
        Uri.parse('https://localhost:44307/api/Productos/List/Productos?categId=${widget.categoryId}'));

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
        title: Text('Products'),
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
                  productId: product['produ_Id'],
                  clientId: widget.clientId, // Pasar el clientId al ProductCard
                  onAddToCart: (productId, clientId) { // Definir una función callback para agregar al carrito
                    agregarAlCarrito(context, productId, clientId);
                  },
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
  final int productId;
  final int clientId;
  final void Function(int, int) onAddToCart; // Definir función de callback para agregar al carrito

  const ProductCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.productId,
    required this.clientId,
    required this.onAddToCart, // Agregar la función de callback
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
                color: Colors.orange,
                image: DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/150'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.5),
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
                  color: Colors.white,
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
                        onAddToCart(productId, clientId); // Llamar a la función de callback con los parámetros requeridos
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add_shopping_cart, color: Colors.orange),
                          SizedBox(width: 4),
                          Text(
                            "Agregar al carrito",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border),
                      color: Colors.orange,
                    ),
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

Future<void> agregarAlCarrito(BuildContext context, int productId, int clientId) async {
  try {
    final url = Uri.parse('https://localhost:44307/Insert/Encabezado');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "Sucur_Id": 1,
        "Venen_UsuarioCreacion": 1,
        "Clien_Id": clientId,
        "Produ_Id": productId,
        "Vende_Cantidad": 1,
      }),
    );

    print("Respuesta recibida: ${response.statusCode}");
    print("Cuerpo de la respuesta: ${response.body}");

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Venta creada exitosamente"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al crear la venta"),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    print("Error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error: $e"),
        backgroundColor: Colors.red,
      ),
    );
  }
}
