import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const InputText({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200))
        ),
        child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none
        ),
      ),
    );
  }
}