import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: kMyPrimaryGradientColor,
        ),
        child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const Text("Profile"),
            const SizedBox(height: 20),
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () => {},
            ),
            // ProfileMenu(
            //   text: "Notifications",
            //   icon: "assets/icons/Bell.svg",
            //   press: () {},
            // ),
            ProfileMenu(
              text: "Ajustes",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Cerrar Sesión",
              icon: "assets/icons/Log out.svg",
              press: () {
                DeleteCache.deleteKey('user');
                DeleteCache.deleteKey('loggedIn',
                  Navigator.of(context).pushNamedAndRemoveUntil(SignInScreen.routeName, (route)=>false));
              },
            ),
          ],
        ),
      ),
      ),  
      );
  }
}
