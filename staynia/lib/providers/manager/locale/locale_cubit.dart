import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/secure_storage.dart';
import 'package:staynia/service/loading_service.dart';

class LocaleCubit extends Cubit<String> {
  LocaleCubit() : super(Constants.localeVN) {
    getLocale();
  }
  Future<void> getLocale() async {
    final value = await SecureStorage.get(Constants.locale);
    switch (value) {
      case Constants.localeVN:
        emit(Constants.localeVN);
        break;
      case Constants.localeEN:
        emit(Constants.localeEN);
        break;
      default:
        emit(Constants.localeVN);
    }
  }

  Future<void> setLocale(String code) async {
    try {
      LoadingService.show();
      await SecureStorage.save(Constants.locale, code);
      emit(code);
    } catch (_) {
    } finally {
      LoadingService.hide();
    }
  }
}
