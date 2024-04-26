import 'package:cache_manager/core/read_cache_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/auth/auth_screen.dart';
import 'package:shop_app/screens/auth/components/loading_screen.dart';
import 'package:shop_app/screens/dashboard/dashboard_screen.dart';
import 'package:shop_app/screens/products/products_screen.dart';

import 'screens/cart/cart_screen.dart';
import 'screens/complete_profile/complete_profile_screen.dart';
import 'screens/details/details_screen.dart';
import 'screens/forgot_password/forgot_password_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/users/usuarios_index.dart';
import 'screens/init_screen.dart';
import 'screens/login_success/login_success_screen.dart';
//import 'screens/otp/otp_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/splash/splash_screen.dart';

Future<int> fetchUserData() async {
  try {
    final data = await ReadCache.getJson(key: 'user'); // Fetch the data asynchronously

    if (data == null) {
      return 0; // Handling null values
    }

    final userData = data as Map<String, dynamic>;
    final id = userData['usuar_Id']; // Explicitly cast to a map
    return id; // Return the desired data
  } catch (e) {
    return 0; // Handle casting or fetching errors
  }
}
    
// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  AuthScreen.routeName:(context) => const AuthScreen(),
  LoadingScreen.routeName:(context) => const LoadingScreen(),
  InitScreen.routeName: (context) => const InitScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => const CompleteProfileScreen(),
  //OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  UsersScreen.routeName: (context) => const UsersScreen(),
  //ProductsScreen.routeName: (context) => const ProductsScreen(),
  
  ProductsScreen.routeName: (context) {
  final Map<String, dynamic>? arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
  final int? categoryId = arguments?['categoryId'] as int?;
  return ProductsScreen(categoryId: categoryId ?? 0); 
 },
  
  DashboardScreen.routeName:(context) => const DashboardScreen(),
  // DetailsScreen.routeName: (context) => const DetailsScreen(),
      // CartScreen.routeName: (context) => CartScreen(clientId: fetchUserData()), 
      // CartScreen.routeName: (context) => CartScreen(clientId: fetchUserData()), 
      CartScreen.routeName: (context) => CartScreen(clientId: 4), 


  ProfileScreen.routeName: (context) => const ProfileScreen(),
};
