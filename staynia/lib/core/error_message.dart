import 'package:staynia/core/constants/error_response.dart';

class ErrorMessage {
  final String? message;
  final String? code;

  ErrorMessage({this.message, this.code});

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(
      message: (json['message'] as String?) ?? ErrorResponse.defaultMessage,
      code:
          (json['code'] as String?) ?? ErrorResponse.defaultCode,
    );
  }
}
