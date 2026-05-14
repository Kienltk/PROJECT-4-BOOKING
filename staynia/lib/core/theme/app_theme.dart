import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staynia/core/theme/app_light_theme.dart';
import 'package:staynia/core/theme/custom_theme.dart';

class AppTheme {
  static light() {
    return ThemeData(
      primarySwatch: primaryMaterialColor,
      primaryColor: primaryColor,
      textTheme: textLightTheme,
      appBarTheme: appBarLightTheme,
      listTileTheme: listTileLightTheme,
      inputDecorationTheme: inputLightTheme,
      colorScheme: schemeLightColor,
      bottomNavigationBarTheme: bottomSheetLight,
      bottomSheetTheme: bottomSheetLighTheme,
      dividerTheme: dividerLight,
      iconTheme: const IconThemeData(color: Colors.black),
      scaffoldBackgroundColor: backgroundLight,
      checkboxTheme: checkboxThemeData.copyWith(
        side: const BorderSide(color: Colors.white38),
      ),
      cupertinoOverrideTheme: const CupertinoThemeData(
        brightness: Brightness.light,
        textTheme: CupertinoTextThemeData(
          navTitleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: CupertinoColors.black,
          ),
          textStyle: TextStyle(fontSize: 14, color: CupertinoColors.black),
          actionSmallTextStyle: TextStyle(fontSize: 14, color: Colors.black),
          actionTextStyle: TextStyle(fontSize: 14, color: Colors.black),
          tabLabelTextStyle: TextStyle(fontSize: 14, color: Colors.black),
          navActionTextStyle: TextStyle(fontSize: 14, color: Colors.black),
          pickerTextStyle: TextStyle(fontSize: 14, color: Colors.black),
          dateTimePickerTextStyle: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }

  static dark() {
    return ThemeData(
      primarySwatch: primaryMaterialColor,
      primaryColor: primaryColor,
      textTheme: textLightTheme,
      appBarTheme: appBarLightTheme,
      listTileTheme: listTileLightTheme,
      inputDecorationTheme: inputLightTheme,
      colorScheme: schemeLightColor,
      bottomNavigationBarTheme: bottomSheetLight,
      bottomSheetTheme: bottomSheetLighTheme,
      dividerTheme: dividerLight,
      iconTheme: const IconThemeData(color: Colors.black),
      scaffoldBackgroundColor: backgroundLight,
      checkboxTheme: checkboxThemeData.copyWith(
        side: const BorderSide(color: Colors.white38),
      ),
      cupertinoOverrideTheme: const CupertinoThemeData(
        brightness: Brightness.dark,
        textTheme: CupertinoTextThemeData(
          navTitleTextStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: CupertinoColors.black,
          ),
          textStyle: TextStyle(fontSize: 14, color: CupertinoColors.black),
          actionSmallTextStyle: TextStyle(fontSize: 14, color: Colors.black),
          actionTextStyle: TextStyle(fontSize: 14, color: Colors.black),
          tabLabelTextStyle: TextStyle(fontSize: 14, color: Colors.black),
          navActionTextStyle: TextStyle(fontSize: 14, color: Colors.black),
          pickerTextStyle: TextStyle(fontSize: 14, color: Colors.black),
          dateTimePickerTextStyle: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }
}
