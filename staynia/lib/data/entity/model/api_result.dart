import 'package:staynia/core/error_message.dart';

class ApiResult<T> {
  ApiResult({
    required this.success,
    this.statusCode,
    this.error,
    this.paramMessage,
    this.data,
    this.last,
  });

  final bool success;
  final dynamic last;
  final int? statusCode;
  final ErrorMessage? error;
  final List<String>? paramMessage;
  final T? data;

  factory ApiResult.success(T data, {int? statusCode, dynamic last}) {
    return ApiResult<T>(data: data, success: true, last: last ?? false);
  }

  factory ApiResult.failure({
    int? statusCode,
    ErrorMessage? error,
    List<String>? paramMessage,
  }) {
    return ApiResult<T>(
      statusCode: statusCode ?? 400,
      paramMessage: paramMessage,
      error: error,
      success: false,
      last: false,
    );
  }
}

class ApiResponse {
  static const String success = 'SUCCESS';
  static const String error = 'ERROR';
}
