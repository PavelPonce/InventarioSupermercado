import 'package:flutter/material.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
    this.imagePath, 
  }) : super(key: key);

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset(
        imagePath ?? 'assets/images/bannerPrueba.jpg', 
        height: 110,
        width: double.infinity,
        fit: BoxFit.cover, 
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: DiscountBanner(imagePath: 'assets/images/bannerPrueba.jpg'), 
    ),
  ));
}
