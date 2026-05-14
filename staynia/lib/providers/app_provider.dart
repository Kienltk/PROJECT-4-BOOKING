import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/core/log.dart';
import 'package:staynia/providers/manager/auth/auth_cubit.dart';
import 'package:staynia/providers/manager/locale/locale_cubit.dart';
import 'package:staynia/providers/manager/user/refresh_token/refresh_token_cubit.dart';
import 'package:staynia/providers/manager/user/user_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    Log.d('${bloc.runtimeType} $change', inspect: false);
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    Log.d('${bloc.runtimeType} EVENT $event', inspect: false);
    super.onEvent(bloc, event);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    Log.d('${bloc.runtimeType} CLOSE', inspect: false);
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Log.d('${bloc.runtimeType} ERROR :$error', inspect: false);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    Log.d('${bloc.runtimeType} CREATE', inspect: false);
    super.onCreate(bloc);
  }
}

List<BlocProvider> appBlocProviders() {
  return [
    BlocProvider<LocaleCubit>(create: (_) => sl<LocaleCubit>()),
    BlocProvider<AuthCubit>(create: (_) => sl<AuthCubit>()),
    BlocProvider<UserBloc>(create: (_) => sl<UserBloc>()),
    BlocProvider<RefreshTokenCubit>(create: (_) => sl<RefreshTokenCubit>()),
  ];
}
