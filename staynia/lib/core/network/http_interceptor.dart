import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/constants/error_response.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/core/log.dart';
import 'package:staynia/providers/manager/user/user_bloc.dart';
import 'package:staynia/providers/manager/user/user_event.dart';
import 'package:staynia/router/application_router.dart';

class HttpInterceptor extends Interceptor {
  void _showToast(String message) {}

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.message == null) {
      showAlertDialog(
        context: navigatorKey.currentContext!,
        title: Constants.appName,
        message:
            'Unable to connect to the system. Please contact ${Constants.hotLine}',
        actions: [AlertDialogAction(key: null, label: "Confirm")],
      );
    }
    Log.d(err.response);
    if (err.response != null) {
      final statusCode = err.response?.statusCode;
      final data = err.response?.data;
      if (data['code'] == ErrorResponse.unauthenticatedCode ||
          data['code'] == ErrorResponse.unauthenticatedCode1) {
        sl<UserBloc>().add(UnauthenticatedEvent());
        return;
      }
      if (statusCode == 401) {
        if (data?['message'] != null) {
          sl<UserBloc>().add(UnauthenticatedEvent());
        }
      } else if (statusCode == 400) {
        _showToast('${data?['message'] ?? ErrorResponse.defaultMessage}');
      } else {
        _showToast('${ErrorResponse.defaultMessage}: $statusCode');
      }
    } else {
      _showToast('${ErrorResponse.defaultMessage}!');
    }
    handler.next(err);
  }
}
