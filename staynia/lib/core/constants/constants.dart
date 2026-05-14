import 'package:flutter/material.dart';

class Constants {
  static String hotLine = '0966 593 702';
  static String email = 'ngominhquang724@gmail.com';
  static String appName = 'StayNia';
  static String remember = 'remember';
  static String username = 'username';
  static String password = 'password';
  static String token = 'TOKEN*';
  static String user = 'USER*';
  static String locale = "locale";
  static const localeVN = "vi";
  static const localeEN = "en";
}

const double defaultPadding = 8.0;
const double defaultBorderRadious = 18.0;
const Duration defaultDuration = Duration(milliseconds: 300);

class Box {
  static const SizedBox s2 = SizedBox(height: 2, width: 2);
  static const SizedBox s4 = SizedBox(height: 4, width: 4);
  static const SizedBox s6 = SizedBox(height: 6, width: 6);
  static const SizedBox s8 = SizedBox(height: 8, width: 8);
  static const SizedBox s10 = SizedBox(height: 10, width: 10);
  static const SizedBox s12 = SizedBox(height: 12, width: 12);
  static const SizedBox s14 = SizedBox(height: 14, width: 14);
  static const SizedBox s16 = SizedBox(height: 16, width: 16);
  static const SizedBox s20 = SizedBox(height: 20, width: 20);
  static const SizedBox s24 = SizedBox(height: 24, width: 24);
  static const SizedBox s28 = SizedBox(height: 28, width: 28);
  static const SizedBox s32 = SizedBox(height: 32, width: 32);
  static const SizedBox s36 = SizedBox(height: 36, width: 36);
  static const SizedBox s40 = SizedBox(height: 40, width: 40);
  static const SizedBox s43 = SizedBox(height: 43, width: 43);
  static const SizedBox s46 = SizedBox(height: 46, width: 46);
  static const SizedBox s50 = SizedBox(height: 50, width: 50);
  static const SizedBox s60 = SizedBox(height: 60, width: 60);
  static const SizedBox s70 = SizedBox(height: 70, width: 70);
  static const SizedBox s80 = SizedBox(height: 80, width: 80);
  static const SizedBox s90 = SizedBox(height: 90, width: 90);
  static const SizedBox s100 = SizedBox(height: 100, width: 100);

  static SizedBox size(double size) {
    return SizedBox(height: size, width: size);
  }

  static SizedBox width(double size) {
    return SizedBox(width: size);
  }

  static SizedBox height(double size) {
    return SizedBox(height: size);
  }
}
