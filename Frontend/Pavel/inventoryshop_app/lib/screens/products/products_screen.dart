
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../details/details_screen.dart';


class ProductsScreen extends StatefulWidget {
  static String routeName = "/products";

  final int categoryId;

  const ProductsScreen({Key? key, required this.categoryId}) : super(key: key);

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
         Uri.parse('https://paapi.somee.com/api/Productos/List/Productos?categId=${widget.categoryId}'));
      
        // Uri.parse('https://localhost:44307/api/Productos/List/Productos?categId=${widget.categoryId}'));

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
  imageUrl: product['produ_ImagenUrl'] ?? '', // Utilizar la URL de la imagen del producto
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsScreen(productId: product['produ_Id']),
                      ),
                    );
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
  final String imageUrl;
  final VoidCallback onPressed;

  const ProductCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.productId,
    required this.imageUrl,
    required this.onPressed,
  }) : super(key: key);
Widget build(BuildContext context) {
    final int clien_Id = 5; // Definir clien_Id como un valor duro igual a 5

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
                  image: NetworkImage(imageUrl), // Cargar la imagen desde la URL proporcionada
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(productId: productId),
                      ),
                    );
                  },
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
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
                      onPressed: onPressed,
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


Future<void> agregarAlCarrito(BuildContext context, int productId) async {
  try {
    final response = await http.post(
      Uri.parse('https://paapi.somee.com/Insert/Encabezado'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'Sucur_Id': '1',
        'Venen_FechaPedido': DateTime.now().toString(),
        'Venen_UsuarioCreacion': '1',
        'Clien_Id': '5',
        'Produ_Id': productId.toString(),
        'Vende_Cantidad': '1',
      },
    );

    if (response.statusCode == 200) {
      print('Response:');
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto agregado al carrito')),
      );
    } else {
      throw Exception('Error al agregar el producto al carrito');
    }
  } catch (error) {
    print('Error: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al agregar el producto al carrito')),
    );
  }
}