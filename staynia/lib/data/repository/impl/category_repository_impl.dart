import 'package:staynia/core/constants/api_url.dart';
import 'package:staynia/core/error_message.dart';
import 'package:staynia/core/network/http_app.dart';
import 'package:staynia/data/entity/model/api_result.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/entity/model/category.dart';
import 'package:staynia/data/repository/category_repository.dart';

class CategoryRepositoryImpl extends HttpApp implements CategoryRepository {
  @override
  Future<ApiResult<List<Category>>> getCategories(BaseRequestDTO dto) async {
    try {
      final res = await httpApp.get(ApiUrl.getCategories, data: dto.toJson());
      final List<dynamic> data = res.data['payload'];
      final districts = data
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(districts);
    } catch (e) {
      debug(e);
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<Category>> create(BaseRequestDTO dto) async {
    try {
      var response = await httpApp.post(
        ApiUrl.createCategory,
        data: dto.toJson(),
      );
      if (response.data["message"] == ApiResponse.success) {
        return ApiResult.success(Category.fromJson(response.data["payload"]));
      }
      return ApiResult.failure(
        error: ErrorMessage.fromJson(response.data),
      );
    } catch (_) {
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<bool>> delete(BaseRequestDTO dto) async {
    try {
      var response = await httpApp.delete(
        ApiUrl.deleteCategory,
        data: dto.toJson(),
      );
      if (response.data["message"] == ApiResponse.success) {
        return ApiResult.success(true);
      }
      return ApiResult.failure(
        error: ErrorMessage.fromJson(response.data),
      );
    } catch (_) {
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<Category>> update(BaseRequestDTO dto) async {
    try {
      var response = await httpApp.put(
        ApiUrl.updateCategory,
        data: dto.toJson(),
      );
      if (response.data["message"] == ApiResponse.success) {
        return ApiResult.success(Category.fromJson(response.data["payload"]));
      }
      return ApiResult.failure(
        error: ErrorMessage.fromJson(response.data),
      );
    } catch (_) {
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<List<Category>>> getByType(BaseRequestDTO dto) async {
    try {
      final res = await httpApp.get(ApiUrl.getCategoryByType, data: dto.toJson());
      final List<dynamic> data = res.data['payload'];
      final districts = data
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(districts);
    } catch (e) {
      debug(e);
      return ApiResult.failure();
    }
  }
}
