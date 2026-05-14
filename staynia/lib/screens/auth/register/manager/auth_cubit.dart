import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/secure_storage.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/entity/model/user.dart';
import 'package:staynia/data/repository/user_repository.dart';
import 'package:staynia/providers/manager/auth/auth_state.dart';
import 'package:staynia/providers/manager/user/user_bloc.dart';
import 'package:staynia/providers/manager/user/user_event.dart';

class AuthCubit extends BaseCubit<AuthState, UserRepository> {
  AuthCubit(UserRepository repository) : super(AuthState(), repository);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? usernameError;
  String? passwordError;
  User data = User();

  Future<void> login() async {
    final usernameError = _validateUsername(usernameController.text);
    final passwordError = _validatePassword(passwordController.text);
    emit(
      state.copyWith(
        usernameError: usernameError,
        passwordError: passwordError,
        autovalidateMode: AutovalidateMode.disabled,
      ),
    );
    if (usernameError != null || passwordError != null) return;
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    BaseRequestDTO dto = BaseRequestDTO(
      payload: {"username": username, "password": password},
    );
    try {
      emit(state.copyWith(loading: true));
      await repository.login(dto).then((res) async {
        if (res.success) {
          usernameController.clear();
          passwordController.clear();
          UserBloc userBloc = context.read<UserBloc>();
          SecureStorage.save(Constants.username, username);
          SecureStorage.save(Constants.password, password);
          SecureStorage.save(Constants.remember, true);
          userBloc.add(SaveUser(res.data!["user"], token: res.data!["token"]));
        } else {
          showAlert(
            code: res.error!.code,
            message: res.error!.message,
          );
        }
      });
    } catch (_) {
      showAlert();
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  String? _validateUsername(String value) {
    if (value.isEmpty) return 'Please enter username';
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) return 'Please enter password';
    if (value.length < 8) return 'Password must be at least 8 chars';
    return null;
  }

  void validateUsername(String value) {
    emit(
      state.copyWith(
        usernameError: _validateUsername(value),
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  void validatePassword(String value) {
    emit(
      state.copyWith(
        passwordError: _validatePassword(value),
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  Future<User?> loadUserInfor() async {
    try {
      var res = await repository.getUserInfor();
      if (res.success) {
        return res.data!;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
