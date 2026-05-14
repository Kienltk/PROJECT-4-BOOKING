import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:staynia/core/log.dart';
import 'package:staynia/core/network/http_config.dart';
import 'package:staynia/router/application_router.dart';

class HttpApp {
  late Dio httpApp;
  late BuildContext context;
  HttpApp() {
    httpApp = HttpConfig.instance.dio;
    context = navigatorKey.currentContext!;
  }
  void debug(e) => Log.d(e, name: runtimeType.toString());
}
