import 'package:staynia/core/constants/api_url.dart';
import 'package:staynia/core/error_message.dart';
import 'package:staynia/core/network/http_app.dart';
import 'package:staynia/data/entity/model/api_result.dart';
import 'package:staynia/data/entity/model/auth_token.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/entity/model/user.dart';
import 'package:staynia/data/repository/user_repository.dart';

class UserRepositoryImpl extends HttpApp implements UserRepository {
  @override
  Future<ApiResult<Map<String, dynamic>>> login(BaseRequestDTO dto) async {
    try {
      final res = await httpApp.post(ApiUrl.login, data: dto.toJson());

      if (res.data["message"] == ApiResponse.success) {
        User user = User.fromJson(res.data["payload"]["user"]);
        AuthToken token = AuthToken.fromJson(res.data["payload"]);
        return ApiResult.success({"user": user, "token": token});
      }
      return ApiResult.failure(error: ErrorMessage.fromJson(res.data));
    } catch (e) {
      debug(e);
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<bool>> register(BaseRequestDTO dto) async {
    try {
      final res = await httpApp.post(ApiUrl.register, data: dto.toJson());
      if (res.data["message"] == ApiResponse.success) {
        return ApiResult.success(true);
      }
      return ApiResult.failure(error: ErrorMessage.fromJson(res.data));
    } catch (_) {
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<User>> getUserInfor() async {
    try {
      final res = await httpApp.get(ApiUrl.userInfor);
      User user = User.fromJson(res.data["payload"]);
      return ApiResult.success(user);
    } catch (_) {
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<bool>> logout() async {
    try {
      await httpApp.post(ApiUrl.logout);
      return ApiResult.success(true);
    } catch (_) {
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> refreshToken(
    BaseRequestDTO dto,
  ) async {
    try {
      final res = await httpApp.post(ApiUrl.refreshToken, data: dto.toJson());
      if (res.data["message"] == ApiResponse.success) {
        User user = User.fromJson(res.data["payload"]["user"]);
        AuthToken token = AuthToken.fromJson(res.data["payload"]);
        return ApiResult.success({"user": user, "token": token});
      }
      return ApiResult.failure(error: ErrorMessage.fromJson(res.data));
    } catch (_) {
      return ApiResult.failure();
    }
  }
}
