import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/auth/auth_screen.dart';
import 'package:shop_app/screens/auth/components/loading_screen.dart';
import 'package:shop_app/screens/dashboard/dashboard_screen.dart';
import 'package:shop_app/screens/entry/entry_screen.dart';
import 'package:shop_app/screens/entry_insertion_screen.dart/entry_insertion_screen.dart';
import 'package:shop_app/screens/products/products_screen.dart';

import 'screens/cart/cart_screen.dart';
import 'screens/complete_profile/complete_profile_screen.dart';
import 'screens/details/details_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/users/usuarios_index.dart';
import 'screens/init_screen.dart';
//import 'screens/otp/otp_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/splash/splash_screen.dart';


// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  AuthScreen.routeName:(context) => const AuthScreen(),
  LoadingScreen.routeName:(context) => const LoadingScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  InitScreen.routeName: (context) => const InitScreen(),
  //OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),

  
  ProductsScreen.routeName: (context) {
  final Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  final int? categoryId = arguments?['categoryId'] as int?;
  return ProductsScreen(categoryId: categoryId ?? 0); 
  },
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  CartScreen.routeName: (context) => const CartScreen(),

  DashboardScreen.routeName:(context) => const DashboardScreen(),
  EntryScreen.routeName:(context) => const EntryScreen(),
  EntryInsertionScreen.routeName:(context) => const EntryInsertionScreen(),
  UsersScreen.routeName: (context) => const UsersScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  //ProductsScreen.routeName: (context) => const ProductsScreen(),
};
