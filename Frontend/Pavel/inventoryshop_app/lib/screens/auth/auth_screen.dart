import 'dart:async';

import 'package:cache_manager/core/cache_manager_utils.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth/components/loading_screen.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

class AuthScreen extends StatefulWidget {
  static String routeName = '/auth';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Future initiateCache() async{
    CacheManagerUtils.conditionalCache(
      key: 'loggedIn', 
      valueType: ValueType.BoolValue,
      actionIfNull: (){
        CacheManagerUtils.conditionalCache(
          key: 'splashed', 
          valueType: ValueType.BoolValue, 
          actionIfNull: (){
            Navigator.of(context).pushNamed(SplashScreen.routeName);
          }, 
          actionIfNotNull: (){
            Navigator.of(context).pushNamed(SignInScreen.routeName);
          }
        );
      }, 
      actionIfNotNull: (){
        Navigator.of(context).pushNamed(InitScreen.routeName);
      }, 
    );
  }

  @override
  void initState(){
    Timer(const Duration(seconds:3),initiateCache);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingScreen();
  }
}