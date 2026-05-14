import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  Future<void> goBack() async => Navigator.pop(this);

  Future<void> goBackUntil(String routePath) async =>
      Navigator.popUntil(this, ModalRoute.withName(routePath));

  Future<void> pushTo<T>(String routePath, {T? arguments}) async =>
      Navigator.pushNamed(this, routePath, arguments: arguments);
  Future<void> pushAndClearStack<T>(String routePath, {T? arguments}) async =>
      Navigator.pushNamedAndRemoveUntil(
        this,
        routePath,
        (Route<dynamic> route) => false,
        arguments: arguments,
      );

  String get currentRouteName => ModalRoute.of(this)?.settings.name ?? '';
}

extension GlobalNavigatorExtension on GlobalKey<NavigatorState> {
  Future<void> goBackUntil(String routePath) async =>
      currentState?.popUntil(ModalRoute.withName(routePath));

  Future<void> pushGlobal(String routePath, {Object? arguments}) async =>
    currentState?.pushNamed(routePath, arguments: arguments);


  Future<void> replaceWith<T>(String routePath, {T? arguments}) async =>
      currentState?.pushReplacementNamed(routePath, arguments: arguments);

  Future<void> replaceAllWith<T>(String routePath, {T? arguments}) async =>
      currentState?.pushNamedAndRemoveUntil(
        routePath,
        (route) => false,
        arguments: arguments,
      );
}
