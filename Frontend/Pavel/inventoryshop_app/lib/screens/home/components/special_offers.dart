import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/constants.dart';

import 'section_title.dart';

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({Key? key}) : super(key: key);

  @override
  _SpecialOffersState createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final response = await http.get(Uri.parse('http://paapi.somee.com/api/Productos/List/Categoriasss'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        categories = data.map((json) => Category.fromJson(json)).toList();
      });
    } else {
      throw Exception('No se pudieron cargar las categorías');
    }
  }

  static const String productsRoute = '/products';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "Categorías",
            press: () {},
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: categories
                .map(
                  (category) => SpecialOfferCard(
                    category: category,
                    press: () {
                      Navigator.pushNamed(
                        context,
                        productsRoute,
                        arguments: {'categoryId': category.categId},
                      );
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.press,
  }) : super(key: key);

  final Category category;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 242,
          height: 100,
          child: Card(
            color: kSecondaryColor,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image from URL
                Image.network(
                  category.cateImagenUrl,
                  fit: BoxFit.cover,
                ),
                // Category name overlay
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Text(
                      category.categDescripcion,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Category {
  final int categId;
  final String categDescripcion;
  final String cateImagenUrl;

  Category({
    required this.categId,
    required this.categDescripcion,
    required this.cateImagenUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categId: json['categ_Id'] ?? 0,
      categDescripcion: json['categ_Descripcion'] ?? '',
      cateImagenUrl: json['cate_ImagenUrl'] ?? '',
    );
  }
}
