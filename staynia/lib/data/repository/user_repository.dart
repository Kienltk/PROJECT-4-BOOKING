import 'package:staynia/data/entity/model/api_result.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/entity/model/user.dart';

abstract class UserRepository {
  Future<ApiResult<Map<String, dynamic>>> login(BaseRequestDTO dto);
  Future<ApiResult<Map<String, dynamic>>> refreshToken(BaseRequestDTO dto);
  Future<ApiResult<bool>> register(BaseRequestDTO dto);
  Future<ApiResult<User>> getUserInfor();
  Future<ApiResult<bool>> logout();
}
