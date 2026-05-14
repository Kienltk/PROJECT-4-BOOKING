import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/env.dart';
import 'package:staynia/core/network/http_interceptor.dart';
import 'package:staynia/store/auth_store.dart';

class HttpConfig {
  static final BaseOptions _options = BaseOptions(
    baseUrl: ENV.baseUrl,
    connectTimeout: const Duration(seconds: 40),
    receiveTimeout: const Duration(seconds: 40),
    receiveDataWhenStatusError: true,
    contentType: 'application/json',
    validateStatus: (status) {
      if (status == null) return false;
      return status <= 400;
    },
  );

  static final Dio _dio = Dio(_options);
  HttpConfig._internal() {
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        // responseHeader: true,
        error: true,
        compact: false,
        maxWidth: 1000,
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          final token = await AuthStore.getAuthToken();
          if (token != null) {
            request.headers["Authorization"] = "Bearer ${token.token}";
          }
          request.headers["lang"] = Constants.localeVN;
          handler.next(request);
        },
      ),
    );
    _dio.interceptors.add(HttpInterceptor());
  }

  static final HttpConfig instance = HttpConfig._internal();
  Dio get dio => _dio;
}
