import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  // Basic Colors
  Color get primaryColor => theme.primaryColor;
  Color get primaryColorLight => theme.primaryColorLight;
  Color get primaryColorDark => theme.primaryColorDark;
  Color get canvasColor => theme.canvasColor;
  Color get scaffoldBackgroundColor => theme.scaffoldBackgroundColor;
  Color get cardColor => theme.cardColor;
  Color get dividerColor => theme.dividerColor;
  Color get focusColor => theme.focusColor;
  Color get hoverColor => theme.hoverColor;
  Color get highlightColor => theme.highlightColor;
  Color get splashColor => theme.splashColor;
  Color get shadowColor => theme.shadowColor;
  Color get unselectedWidgetColor => theme.unselectedWidgetColor;
  Color get disabledColor => theme.disabledColor;
  Color get secondaryHeaderColor => theme.secondaryHeaderColor;
  Color get hintColor => theme.hintColor;

  //  ColorScheme
  ColorScheme get colorScheme => theme.colorScheme;

  // Text Styles
  TextTheme get textTheme => theme.textTheme;
  TextStyle? get displayLarge => theme.textTheme.displayLarge;
  TextStyle? get displayMedium => theme.textTheme.displayMedium;
  TextStyle? get displaySmall => theme.textTheme.displaySmall;
  TextStyle? get headlineLarge => theme.textTheme.headlineLarge;
  TextStyle? get headlineMedium => theme.textTheme.headlineMedium;
  TextStyle? get headlineSmall => theme.textTheme.headlineSmall;
  TextStyle? get titleLarge => theme.textTheme.titleLarge;
  TextStyle? get titleMedium => theme.textTheme.titleMedium;
  TextStyle? get titleSmall => theme.textTheme.titleSmall;
  TextStyle? get bodyLarge => theme.textTheme.bodyLarge;
  TextStyle? get bodyMedium => theme.textTheme.bodyMedium;
  TextStyle? get bodySmall => theme.textTheme.bodySmall;
  TextStyle? get labelLarge => theme.textTheme.labelLarge;
  TextStyle? get labelMedium => theme.textTheme.labelMedium;
  TextStyle? get labelSmall => theme.textTheme.labelSmall;

  //  AppBar
  AppBarThemeData get appBarTheme => theme.appBarTheme;
  IconThemeData? get appBarIconTheme => theme.appBarTheme.iconTheme;
  TextStyle? get appBarTitleTextStyle => theme.appBarTheme.titleTextStyle;

  //  Icons
  IconThemeData get iconTheme => theme.iconTheme;
  IconThemeData get primaryIconTheme => theme.primaryIconTheme;

  //  Buttons
  ButtonThemeData get buttonTheme => theme.buttonTheme;
  TextButtonThemeData get textButtonTheme => theme.textButtonTheme;
  ElevatedButtonThemeData get elevatedButtonTheme => theme.elevatedButtonTheme;
  OutlinedButtonThemeData get outlinedButtonTheme => theme.outlinedButtonTheme;
  FloatingActionButtonThemeData get floatingActionButtonTheme =>
      theme.floatingActionButtonTheme;

  //  Others (Inputs, Tabs, etc.)
  InputDecorationThemeData get inputDecorationTheme => theme.inputDecorationTheme;
  BottomNavigationBarThemeData get bottomNavigationBarTheme =>
      theme.bottomNavigationBarTheme;
  BottomAppBarThemeData get bottomAppBarTheme => theme.bottomAppBarTheme;
  DrawerThemeData get drawerTheme => theme.drawerTheme;
  ListTileThemeData get listTileTheme => theme.listTileTheme;
  SnackBarThemeData get snackBarTheme => theme.snackBarTheme;
  TooltipThemeData get tooltipTheme => theme.tooltipTheme;
  DividerThemeData get dividerTheme => theme.dividerTheme;
  CheckboxThemeData get checkboxTheme => theme.checkboxTheme;
  RadioThemeData get radioTheme => theme.radioTheme;
  SwitchThemeData get switchTheme => theme.switchTheme;
  SliderThemeData get sliderTheme => theme.sliderTheme;
  ProgressIndicatorThemeData get progressIndicatorTheme =>
      theme.progressIndicatorTheme;
  PopupMenuThemeData get popupMenuTheme => theme.popupMenuTheme;
  NavigationRailThemeData get navigationRailTheme => theme.navigationRailTheme;
  TimePickerThemeData get timePickerTheme => theme.timePickerTheme;
  Typography get typography => theme.typography;
}
