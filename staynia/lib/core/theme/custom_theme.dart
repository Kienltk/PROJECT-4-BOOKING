import 'package:flutter/material.dart';
import 'package:staynia/extension/app_extension.dart';

//----------------------------- Light Theme -----------------------------
Color backgroundLight = Colors.white;
Color borderColor = const Color.fromARGB(255, 218, 218, 218);
Color defaultShadowColor = const Color.fromARGB(255, 235, 235, 235);
Color backgroundApp = const Color.fromRGBO(47, 123, 253, 1);
Color backgroundGrey = const Color.fromARGB(255, 244, 244, 244);

Color defaultWhiteShadowColor = const Color.fromARGB(255, 235, 235, 235);


const Color primaryColor = Color(0xFF1255FB);
const Color primaryColor50 = Color(0xFFE3ECFE);
const Color primaryColor100 = Color(0xFFBCCDFA);
const Color primaryColor200 = Color(0xFF94ACF7);
const Color primaryColor300 = Color(0xFF6C8BF3);
const Color primaryColor400 = Color(0xFF4B73F0);
const Color primaryColor500 = Color(0xFF1255FB);
const Color primaryColor600 = Color(0xFF104CE0);
const Color primaryColor700 = Color(0xFF0D40BA);
const Color primaryColor800 = Color(0xFF0A3395);
const Color primaryColor900 = Color(0xFF071F5A);

const MaterialColor primaryMaterialColor =
    MaterialColor(0xFF1255FB, <int, Color>{
      50: primaryColor50,
      100: primaryColor100,
      200: primaryColor200,
      300: primaryColor300,
      400: primaryColor400,
      500: primaryColor500,
      600: primaryColor600,
      700: primaryColor700,
      800: primaryColor800,
      900: primaryColor900,
    });



BoxShadow shadowTop({required Color color, Offset? offset}) => BoxShadow(
  color: color,
  spreadRadius: 6,
  blurRadius: 17,
  offset: offset ?? const Offset(1, -7),
);

BoxShadow shadowBottom({required Color color, Offset? offset}) => BoxShadow(
  color: color,
  spreadRadius: 3,
  blurRadius: 8,
  offset: offset ?? const Offset(1, 2),
);

BoxShadow bShadow() => const BoxShadow(
  color: Colors.black12,
  blurRadius: 5,
  spreadRadius: 2,
  offset: Offset(0, 2),
);

BoxShadow shadow() => const BoxShadow(
  color: Colors.black12,
  blurRadius: 5,
  spreadRadius: 2,
  offset: Offset(0, 2),
);

BoxShadow circleShadow({Color color = Colors.black, Offset? offset}) =>
    BoxShadow(
      color: color.withOpacitySafe(0.35),
      offset: offset ?? const Offset(0, 0),
      blurRadius: 6,
      spreadRadius: 1,
    );

BoxShadow whiteCircleShadow() => BoxShadow(
  color: Colors.white.withOpacitySafe(0.35),
  offset: const Offset(0, 0),
  blurRadius: 9,
  spreadRadius: 1,
);
