import 'dart:async';

import 'package:cache_manager/core/cache_manager_utils.dart';
import 'package:cache_manager/core/write_cache_service.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth/components/loading_screen.dart';
import 'package:shop_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screens/init_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/sign_up/sign_up_screen.dart';
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
            WriteCache.setBool(key: 'splashed', value: true);
            Navigator.pushNamedAndRemoveUntil(context, SplashScreen.routeName, (route) => route.settings.name != AuthScreen.routeName &&
                                               route.settings.name != InitScreen.routeName);
          }, 
          actionIfNotNull: (){
            Navigator.pushNamedAndRemoveUntil(context, SignInScreen.routeName, (route) => route.settings.name != AuthScreen.routeName &&
                                             route.settings.name != InitScreen.routeName && route.settings.name != SplashScreen.routeName);
          }
        );
      }, 
      actionIfNotNull: (){
        Navigator.pushNamedAndRemoveUntil(context, InitScreen.routeName, (route) => route.settings.name != AuthScreen.routeName && 
                                          route.settings.name != SplashScreen.routeName &&
                                          route.settings.name != SignInScreen.routeName &&
                                          route.settings.name != SignUpScreen.routeName && 
                                          route.settings.name != ForgotPasswordScreen.routeName);
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