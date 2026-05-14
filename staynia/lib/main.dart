import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/application/my_application.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/core/network/network_ob_server.dart';
import 'package:staynia/providers/app_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await setupLocator();
  NetworkObserver.listenNetwork();
  Bloc.observer = AppBlocObserver();
  AdaptiveDialog.instance.updateConfiguration(
    // ignore: deprecated_member_use
    defaultStyle: AdaptiveStyle.cupertino,
  );
  runApp(
    MultiBlocProvider(
      providers: appBlocProviders(),
      child: const MyApplication(),
    ),
  );
}
