import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/home/components/popular_product.dart';
//import 'components/categories.dart';
//import 'components/discount_banner.dart';
import 'components/home_header.dart';
//import 'components/popular_product.dart';
import 'components/special_offers.dart';
//import 'usuarios_index.dart';


class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.orange.shade900,
                  Colors.orange.shade800,
                  Colors.orange.shade400
                ]
              )
            ),
            child: const Column(
              children: [
                HomeHeader(),
                //DiscountBanner(),
                //Categories(),
                SizedBox(height: 20),
                SpecialOffers(),
                //SizedBox(height: 20),
                PopularProducts(),
                //SizedBox(height: 20),
                
              ],
            ),
          ), 
        ),
      ),
    );
  }
}
