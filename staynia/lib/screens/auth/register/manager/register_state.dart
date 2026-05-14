import 'package:flutter/widgets.dart';
import 'package:staynia/core/base/bloc/base_cubit_state.dart';
import 'package:staynia/data/entity/model/user.dart';

class RegisterState extends BaseCubitState<User> {
  final String? usernameError;
  final String? passwordError;
  final AutovalidateMode autovalidateMode;

  RegisterState({
    super.loading,
    super.error,
    super.data,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.passwordError,
    this.usernameError,
  });

  @override
  RegisterState copyWith({
    bool? loading,
    String? error,
    User? data,
    String? usernameError,
    String? passwordError,
    AutovalidateMode? autovalidateMode,
  }) {
    return RegisterState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      data: data ?? this.data,
      usernameError: usernameError,
      passwordError: passwordError,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
    );
  }
}
