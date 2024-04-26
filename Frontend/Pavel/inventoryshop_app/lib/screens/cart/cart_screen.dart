import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../details/details_screen.dart';

class Product {
  final int id;
  final String descripcion;
  final int existencia;
  final double precioCompra;
  final double precioVenta;
  final int unidadId;
  final int impuestoId;
  final int categoryId;
  final int proveedorId;
  final bool estado;
  final String url;
  final String unidadDescripcion;
  final String proveedorMarca;
  final double impuesto;
  final int ventaDetalle;
  final int ventaEncabezado;


  Product({
    required this.id,
    required this.descripcion,
    required this.existencia,
    required this.precioCompra,
    required this.precioVenta,
    required this.unidadId,
    required this.impuestoId,
    required this.categoryId,
    required this.proveedorId,
    required this.estado,
    this.url = 'https://i.stack.imgur.com/DPGsM.png',
    required this.unidadDescripcion,
    required this.proveedorMarca,
    required this.impuesto,
    required this.ventaDetalle,
    required this.ventaEncabezado,

  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['produ_Id'] ?? 0,
      descripcion: json['produ_Descripcion'] ?? '',
      existencia: json['produ_Existencia'] ?? 0,
      precioCompra: (json['produ_PrecioCompra'] as num?)?.toDouble() ?? 0.0,
      precioVenta: (json['produ_PrecioVenta'] as num?)?.toDouble() ?? 0.0,
      unidadId: json['unida_Id'] ?? 0,
      impuestoId: json['impue_Id'] ?? 0,
      categoryId: json['categ_Id'] ?? 0,
      proveedorId: json['prove_Id'] ?? 0,
      estado: json['produ_Estado'] ?? false,
      url: json['produ_ImagenUrl'] ?? 'https://i.stack.imgur.com/DPGsM.png',
      unidadDescripcion: json['unida_Descripcion'] ?? '',
      proveedorMarca: json['prove_Marca'] ?? '',
      impuesto: (json['impue_Descripcion'] as num?)?.toDouble() ?? 0.0,
      ventaDetalle: json['vende_Id'] ?? 0,
      ventaEncabezado: json['venen_Id'] ?? 0,

    );
  }
}


// Widget build(BuildContext context) {
//     return FutureBuilder<dynamic>(
//       future: ReadCache.getJson(key: 'user'), // Dynamic return type
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator(); // Loading state
//         } else if (snapshot.hasError) {
//           return Text("Error: ${snapshot.error}"); // Error handling
//         } else if (snapshot.data == null) {
//           return Text("No data found for the key 'user'"); // Handling null values
//         } else {
//           try {
//             final userData = snapshot.data as Map<String, dynamic>; // Explicit cast
//             return Text("User ID: ${userData['usuar_Id']}"); // Access specific fields
//           } catch (e) {
//             return Text("Error casting data: ${e.toString()}"); // Handle casting errors
//           }
//         }
//       },
//     );}



String globalVentaEncabezado = '';


class CartScreen extends StatefulWidget {
  static const String routeName = "/cart";
  final int clientId;

  const CartScreen({Key? key, required this.clientId}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<Product>> _futureProducts;
  double _total = 0.0;
  String? _selectedMethod;
  TextEditingController _cardNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureProducts = loadCartProducts(widget.clientId);
  }

  Future<List<Product>> loadCartProducts(int clientId) async {
    double total = 0.0; 
    print('Loading products for client $clientId');
    try {
      final response = await http.get(
        Uri.parse('https://localhost:44307/Cargar/ListadoCarritoPrincipal?Clien_Id=$clientId'),
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
 total = responseData.fold(0, (prev, product) => prev + (product['produ_PrecioVenta'] as num).toDouble());

      setState(() {
        _total = total;
      });
              globalVentaEncabezado = responseData.first['venen_Id'].toString();

      print('Valor de globalVentaEncabezado: $globalVentaEncabezado');

        List<Product> products =
            responseData.map((data) => Product.fromJson(data)).toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      throw Exception('Failed to load products: $error');
    }
  }


  void _emitirVenta() async {
    if (_selectedMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Seleccione un método de pago')),
      );
      return;
    }
    if (_selectedMethod != 'Efectivo' && _cardNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ingrese el número de tarjeta')),
      );
      return;
    }

    try {
      final response = await http.post(
  Uri.parse('https://localhost:44307/EmisionFactura?mtPag_Id=$_selectedMethod&venen_Id=$globalVentaEncabezado&venen_NroTarjeta=${_cardNumberController.text}'),
);


      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Factura emitida con éxito')),
        );
      } else {
        throw Exception('Failed to emit invoice');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

   void _eliminarProducto(int vendeId) async {
  try {
    final response = await http.delete(
      Uri.parse('https://localhost:44307/Delete/Detalle/$vendeId'),
    );
    if (response.statusCode == 200) {
      print('Detalle eliminado exitosamente');
      setState(() {
        _futureProducts = loadCartProducts(widget.clientId);
      });
    } else {
      throw Exception('Error al eliminar el detalle');
    }
  } catch (error) {
    print('Error al eliminar el detalle: $error');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final products = snapshot.data!;
            return Column(
              children: [
                Text(
                  'Total Products: ${products.length}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CartCard(product: products[index], onDelete: _eliminarProducto),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _emitirVenta,
                  child: Text('Emitir Venta'),
                ),
                Text(
                  'Total: \$$_total',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return _buildMethodSelectionModal();
            },
          );
        },
        child: Icon(Icons.payment),
      ),
    );
  }

  Widget _buildMethodSelectionModal() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selecciona un método de pago',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          FutureBuilder<List>(
            future: _fetchPaymentMethods(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final methods = snapshot.data!;
                return Column(
                  children: methods.map<Widget>((method) {
                    return RadioListTile<String>(
                      title: Text(method['mtPag_Descripcion']),
                      value: method['mtPag_Id'].toString(),
                      groupValue: _selectedMethod,
                      onChanged: (value) {
                        setState(() {
                          _selectedMethod = value;
                        });
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                );
              }
            },
          ),
          SizedBox(height: 16),
          if (_selectedMethod != 'Efectivo')
            TextFormField(
              controller: _cardNumberController,
              decoration: InputDecoration(
                labelText: 'Número de Tarjeta',
                border: OutlineInputBorder(),
              ),
            ),
        ],
      ),
    );
  }

  Future<List> _fetchPaymentMethods() async {
    final response = await http.get(Uri.parse('https://localhost:44307/MetodoPago/DDL'));
    if (response.statusCode == 200) {
      return json.decode(response.body) as List;
    } else {
      throw Exception('Failed to load payment methods');
    }
  }
}

class CartCard extends StatelessWidget {
  final Product product;
  final Function(int) onDelete;

  const CartCard({Key? key, required this.product, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(productId: product.id),
            
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(product.url),
          ),
          title: Text(product.descripcion),
          subtitle: Text('Precio: \$${product.precioVenta}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete(product.ventaDetalle);
            },
          ),
        ),
      ),
    );
  }
}

