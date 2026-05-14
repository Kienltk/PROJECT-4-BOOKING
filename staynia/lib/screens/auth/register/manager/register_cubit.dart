import 'package:flutter/cupertino.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/data/entity/model/address/district.dart';
import 'package:staynia/data/entity/model/address/province.dart';
import 'package:staynia/data/entity/model/address/ward.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/entity/model/user.dart';
import 'package:staynia/data/repository/user_repository.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/screens/auth/register/manager/register_state.dart';

class RegisterCubit extends BaseCubit<RegisterState, UserRepository> {
  RegisterCubit(UserRepository repository) : super(RegisterState(), repository);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  String? usernameError;
  String? passwordError;
  Province? province;
  District? district;
  Ward? ward;
  final control = ScrollController();

  User data = User();

  Future<void> register() async {
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
    if (province == null || district == null || ward == null) {
      showAlert(message: "Vui lòng chọn đầy đủ dữ liệu.");
      return;
    }
    BaseRequestDTO dto = BaseRequestDTO(
      payload: {
        "username": username,
        "password": password,
        "confirmPassword": confirmPassController.text,
        "addressDetail": password,
        "provinceId": province?.id,
        "districtId": district?.id,
        "wardId": ward?.id,
        "fullName": fullNameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
      },
    );
    try {
      emit(state.copyWith(loading: true));
      await repository.register(dto).then((res) async {
        if (res.success) {
          context.goBack();
        } else {
          showAlert(message: res.error?.message, code: res.error?.code);
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
}
