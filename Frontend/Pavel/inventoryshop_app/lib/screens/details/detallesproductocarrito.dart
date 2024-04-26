import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Productcarrito {
  final int id;
  final String descripcion;
  final int existencia;
  final double precioCompra;
  final double precioVenta;
  final String unidadDescripcion;
  final String marcaProveedor;
  final String imageUrl;
  final int vendet;
  final int vencant;
  

  Productcarrito({
    required this.id,
    required this.descripcion,
    required this.existencia,
    required this.precioCompra,
    required this.precioVenta,
    required this.unidadDescripcion,
    required this.marcaProveedor,
    required this.imageUrl,
    required this.vendet,
    required this.vencant,

  });

  factory Productcarrito.fromJson(Map<String, dynamic> json) {
    return Productcarrito(
      id: json['produ_Id'],
      descripcion: json['produ_Descripcion'],
      existencia: json['produ_Existencia'],
      precioCompra: json['produ_PrecioCompra'].toDouble(),
      precioVenta: json['produ_PrecioVenta'].toDouble(),
      unidadDescripcion: json['unida_Descripcion'],
      marcaProveedor: json['prove_Marca'],
      imageUrl: 'URL_DE_LA_IMAGEN',
      vendet: json['vende_Id'],
      vencant: json['vende_Cantidad'],

    );
  }
}

class DetallesProductocarrito extends StatefulWidget {
  static String routeName = "/details";

  final int productId;
  final int vendetId;

  const DetallesProductocarrito({
    Key? key,
    required this.productId,
    required this.vendetId,
  }) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetallesProductocarrito> {
  late Future<Map<String, dynamic>> _productDetailsFuture;
  bool isFirstTime = true; 

  @override
  void initState() {
    super.initState();
    _productDetailsFuture = fetchProductDetails();
  }

  Future<Map<String, dynamic>> fetchProductDetails() async {
    final response = await http.get(
      Uri.parse('https://localhost:44307/api/Productos/List/Productocarrito?prodid=${widget.productId}'),
            // Uri.parse('https://localhost:44307/api/Productos/List/Productocarrito?prodid=${widget.productId}vendetId=${widget.vendetId}'),

    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product details');
    }
  }






Future<Map<String, int>> agregarAlCarrito(int productId) async {
  try {
    final response = await http.post(
      Uri.parse('https://localhost:44307/Insert/Encabezado'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'Sucur_Id': '1',
        'Venen_FechaPedido': DateTime.now().toString(),
        'Venen_UsuarioCreacion': '1',
        'Clien_Id': '5',
        'Produ_Id': productId.toString(),
        // 'Vende_Cantidad': cantidad.toString(),
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final vendeId = jsonResponse['vende_Id']; // Obtener el ID de la venta encabezado
      final venenId = jsonResponse['venen_Id']; // Obtener el ID del detalle de venta
      return {'vendeId': vendeId, 'venenId': venenId}; // Devolver los IDs
    } else {
      throw Exception('Error al agregar el producto al carrito');
    }
  } catch (error) {
    print('Error: $error');
    throw Exception('Error al agregar el producto al carrito');
  }
}

void actualizarCantidad(int vendeId, int productId, int cantidad) async {
  try {
    final response = await http.put(
      Uri.parse('https://localhost:44307/Update/Detalle'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Vende_Id': vendeId.toString(),
        'Produ_Id': productId.toString(),
        'Vende_Cantidad': cantidad.toString(),
        'Vende_UsuarioModificacion': '1',
        'Vende_FechaModificacion': DateTime.now().toString(),
      }),
    );

    if (response.statusCode == 200) {
      print('Cantidad actualizada:');
      print(response.body);
    } else {
      throw Exception('Error al actualizar la cantidad');
    }
  } catch (error) {
    print('Error al actualizar la cantidad: $error');
    throw Exception('Error al actualizar la cantidad');
  }
}

void eliminarDetalle(int vendeId) async {
  try {
    final response = await http.delete(
      Uri.parse('https://localhost:44307/Delete/Detalle/$vendeId'),
    );

    if (response.statusCode == 200) {
      print('Detalle eliminado:');
      print(response.body);
    } else {
      throw Exception('Error al eliminar el detalle');
    }
  } catch (error) {
    print('Error al eliminar el detalle: $error');
    throw Exception('Error al eliminar el detalle');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _productDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final productDetails = snapshot.data!;
            final product = Productcarrito.fromJson(productDetails['data'][0]);
final vendeId = productDetails['ventaId'] ?? 0;
int cantidad = product.vencant;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      product.descripcion,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Existencia: ${product.existencia}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Precio de compra: ${product.precioCompra}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Precio de venta: ${product.precioVenta}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Unidad: ${product.unidadDescripcion}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Proveedor/Marca: ${product.marcaProveedor}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.image,
                        size: 100,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    IconButton(
  onPressed: () {
    setState(() {
      cantidad++;
      actualizarCantidad(vendeId, product.id, cantidad);
    });
  },
  icon: Icon(Icons.add),
),

                        Text(
                          '$cantidad',
                          style: TextStyle(fontSize: 20),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              cantidad++;
                              if (isFirstTime) {
                                agregarAlCarrito(product.id);
                                isFirstTime = false;
                              } else {
                                actualizarCantidad(vendeId, product.id, cantidad);
                              }
                            });
                          },
                          icon: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
