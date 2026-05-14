import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/core/base/bloc/base_bloc.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/secure_storage.dart';
import 'package:staynia/data/entity/model/user.dart';
import 'package:staynia/data/repository/user_repository.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/providers/manager/auth/auth_cubit.dart';
import 'package:staynia/providers/manager/user/refresh_token/refresh_token_cubit.dart';
import 'package:staynia/providers/manager/user/user_event.dart';
import 'package:staynia/providers/manager/user/user_state.dart';
import 'package:staynia/router/router_path.dart';
import 'package:staynia/store/auth_store.dart';

class UserBloc extends BaseBloc<UserEvent, UserState, UserRepository> {
  final AuthCubit authCubit;
  UserBloc(this.authCubit, UserRepository repository)
    : super(UserInit(), repository) {
    on<LoadUser>(_loadUser);
    on<SaveUser>(_saveUser);
    on<LogoutSubmit>(_logout);
    on<UnauthenticatedEvent>(_unAuthenticated);
    on<ErrorEvent>(_errorEvent);
    on<SaveUserOnRefresh>(_saveUserOnRefresh);
  }

  User? _user;

  Future<void> _loadUser(LoadUser event, Emitter<UserState> emit) async {
    emit(Unauthenticated());
    User? res = await authCubit.loadUserInfor();
    if (res != null) {
      add(SaveUser(res));
    } else {
      context.pushAndClearStack(RoutePaths.login);
    }
  }

  FutureOr<void> _unAuthenticated(
    UnauthenticatedEvent event,
    Emitter<UserState> emit,
  ) async {
    await SecureStorage.remove(Constants.token);
    await SecureStorage.remove(Constants.remember);
    await SecureStorage.remove(Constants.username);
    await SecureStorage.remove(Constants.password);
    emit(Unauthenticated());
    context.pushAndClearStack(RoutePaths.login);
  }

  FutureOr<void> _logout(LogoutSubmit event, Emitter<UserState> emit) async {
    await repository!.logout();
    if (event.clearUser) {
      AuthStore.clearAccount();
    }
    _user = null;
    emit(LogoutLoading());
    await SecureStorage.remove(Constants.password);
    await SecureStorage.remove(Constants.token);
    await SecureStorage.remove(Constants.remember);
    emit(Unauthenticated());
    if (event.clearUser) {
      // replaceAllWith(RoutePaths.login);
      return;
    }
    context.pushAndClearStack(RoutePaths.login);
  }

  FutureOr<void> _saveUser(SaveUser event, Emitter<UserState> emit) async {
    _user = event.user;
    debug(event);
    if (user.status != 1) {
      showErrorAlert("PRD000", "Vui Lòng liên hệ 0966 593 702");
      return;
    }
    emit(Authenticated(event.user));
    await AuthStore.saveAccount(user: event.user);
    if (event.token != null) {
      await AuthStore.saveAuthToken(event.token!);
    }
    debug(
      '*************** STATUS: ${_user?.status} - ROLE: ${_user?.type} ***************',
    );
    context.read<RefreshTokenCubit>().startAutoRefresh();
    if (_user?.type == 1 || _user?.type == "1") {
      context.pushAndClearStack(RoutePaths.entryPointAdmin);
    } else {
      context.pushAndClearStack(RoutePaths.entryPoint);
    }
  }

  @override
  User get user => _user!;

  FutureOr<void> _errorEvent(ErrorEvent event, Emitter<UserState> emit) async {
    await SecureStorage.remove(Constants.password);
    showErrorAlert("", "");
  }

  FutureOr<void> _saveUserOnRefresh(
    SaveUserOnRefresh event,
    Emitter<UserState> emit,
  ) async {
    await AuthStore.saveAuthToken(event.token);
    await AuthStore.saveAccount(user: event.user);
    _user = event.user;
    debug(
      '======================== REFRESH TOKEN SUCCESS ==========================',
    );
  }
}
