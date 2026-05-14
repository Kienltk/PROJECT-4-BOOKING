import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/l10n/generated/app_localizations.dart';
import 'package:staynia/core/theme/app_theme.dart';
import 'package:staynia/providers/manager/locale/locale_cubit.dart';
import 'package:staynia/router/application_router.dart';
import 'package:staynia/router/router_path.dart';

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<LocaleCubit, String>(
        builder: (_, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: (context, child) => ResponsiveBreakpoints.builder(
              child: BotToastInit()(context, child),
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],
            ),
            localizationsDelegates: const [
              ...GlobalMaterialLocalizations.delegates,
              FlutterQuillLocalizations.delegate,
            ],
            locale: Locale(locale),
            title: Constants.appName,
            supportedLocales: AppLocalizations.supportedLocales,
            navigatorObservers: [BotToastNavigatorObserver()],
            theme: AppTheme.light(),
            darkTheme: AppTheme.light(),
            navigatorKey: navigatorKey,
            initialRoute: RoutePaths.splash,
            onGenerateRoute: ApplicationRouter.generate,
          );
        },
      ),
    );
  }
}
