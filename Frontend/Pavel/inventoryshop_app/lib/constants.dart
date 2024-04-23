import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color.fromRGBO(255, 165, 62, 1), Color.fromRGBO(255, 118, 67, 1)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Colors.black;

const kAnimationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Porfavor Ingresa tu usuario";
const String kInvalidEmailError = "Porfavor Ingresa un correo válido";
const String kPassNullError = "Porfavor Ingresa tu contraseña";
const String kShortPassError = "La Contraseña es muy corta";
const String kMatchPassError = "Las Contraseñas no son iguales";
const String kNamelNullError = "Porfavor Ingresa tu Nombre";
const String kPhoneNumberNullError = "Porfavor Ingresa tu número de teléfono";
const String kAddressNullError = "Porfavor Ingresa tu dirección";

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 16),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: kTextColor),
  );
}
