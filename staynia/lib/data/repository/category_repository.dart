import 'package:staynia/data/entity/model/api_result.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/entity/model/category.dart';

abstract class CategoryRepository {
  Future<ApiResult<List<Category>>> getCategories(BaseRequestDTO dto);
  Future<ApiResult<List<Category>>> getByType(BaseRequestDTO dto);
  Future<ApiResult<Category>> create(BaseRequestDTO dto);
  Future<ApiResult<Category>> update(BaseRequestDTO dto);
  Future<ApiResult<bool>> delete(BaseRequestDTO dto);
}
