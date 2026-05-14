import 'package:flutter/material.dart';
import 'package:staynia/core/theme/custom_theme.dart';

BottomNavigationBarThemeData bottomSheetLight =
    const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.white,
      selectedLabelStyle: TextStyle(
        // fontFamily: AppFont.SFProTextSemibold,
        fontWeight: FontWeight.bold,
        fontSize: 11,
      ),
      unselectedLabelStyle: TextStyle(
        // fontFamily: AppFont.SFProTextSemibold,
        fontWeight: FontWeight.bold,
        fontSize: 11,
      ),
    );

DividerThemeData dividerLight = const DividerThemeData(
  color: Color.fromARGB(255, 233, 233, 233),
  indent: 0,
  space: 1,
  thickness: 1,
  endIndent: 0,
);

ColorScheme schemeLightColor = ColorScheme.fromSeed(
  seedColor: Colors.transparent,
  primary: primaryColor500,
  surfaceTint: Colors.white,
  secondary: primaryColor200,
);

BottomSheetThemeData bottomSheetLighTheme = const BottomSheetThemeData(
  dragHandleSize: Size(40, 2.3),
  backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
  ),
  clipBehavior: Clip.antiAlias,
  
  
);

const TextTheme textLightTheme = TextTheme(
  bodyLarge: TextStyle(
    color: Colors.black,
    // fontFamily: AppFont.SFProTextSemibold,
    fontWeight: FontWeight.bold,
  ),
  bodyMedium: TextStyle(
    color: Colors.black,
    // fontFamily: AppFont.SFProTextSemibold,
  ),
  displayLarge: TextStyle(
    color: Colors.black,
    // fontFamily: AppFont.SFProTextSemibold,
  ),
  displayMedium: TextStyle(
    color: Colors.black,
    // fontFamily: AppFont.SFProTextSemibold,
  ),
  headlineLarge: TextStyle(),
  headlineMedium: TextStyle(),
  headlineSmall: TextStyle(
    // fontFamily: AppFont.SFProTextSemibold,
    fontWeight: FontWeight.bold,
  ),
);

const ListTileThemeData listTileLightTheme = ListTileThemeData(
  titleTextStyle: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    // fontFamily: AppFont.SFProTextSemibold,
    color: Colors.black,
  ),
  subtitleTextStyle: TextStyle(
    fontSize: 12,
    // fontFamily: AppFont.SFProTextRegular,
    color: Colors.black,
  ),
  contentPadding: EdgeInsets.zero,
);

const AppBarTheme appBarLightTheme = AppBarTheme(
  backgroundColor: Colors.transparent,
  elevation: 0,
  centerTitle: true,
  surfaceTintColor: Colors.transparent,
  shadowColor: Colors.transparent,
  iconTheme: IconThemeData(color: Colors.white, size: 23),
  titleTextStyle: TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    // fontFamily: AppFont.SFProTextSemibold,
    fontSize: 16.2,
    letterSpacing: 0.2,
  ),
);

const InputDecorationTheme inputLightTheme = InputDecorationTheme(
  fillColor: Colors.transparent,
  filled: true,
  hintStyle: TextStyle(
    color: Colors.grey,
    fontSize: 12,
    // fontFamily: AppFont.SFProTextSemibold,
  ),
  contentPadding: EdgeInsets.all(10),
  border: outlineInputBorder,
  enabledBorder: outlineInputBorder,
  focusedBorder: focusedOutlineInputBorder,
  errorBorder: errorOutlineInputBorder,
);

const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide(color: Colors.grey, width: 1),
);

const OutlineInputBorder focusedOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide(color: primaryColor, width: 1.5),
);

const OutlineInputBorder errorOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12)),
  borderSide: BorderSide(color: Colors.red, width: 1.5),
);

CheckboxThemeData checkboxThemeData = CheckboxThemeData(
  checkColor: WidgetStateProperty.all(Colors.black),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
  side: const BorderSide(color: Colors.white38),
);
