import 'package:staynia/data/entity/model/api_result.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/entity/model/room.dart';

abstract class RoomRepository {
  Future<ApiResult<List<Room>>> getAll(BaseRequestDTO dto);
  Future<ApiResult<Room>> getDetail(BaseRequestDTO dto);
  Future<ApiResult<Room>> create(BaseRequestDTO dto);
  Future<ApiResult<Room>> update(BaseRequestDTO dto);
  Future<ApiResult<bool>> delete(BaseRequestDTO dto);
}
