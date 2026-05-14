import 'package:staynia/core/constants/api_url.dart';
import 'package:staynia/core/error_message.dart';
import 'package:staynia/core/network/http_app.dart';
import 'package:staynia/data/entity/model/api_result.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/entity/model/room.dart';
import 'package:staynia/data/repository/room_repository.dart';

class RoomRepositoryImpl extends HttpApp implements RoomRepository {
  @override
  Future<ApiResult<List<Room>>> getAll(BaseRequestDTO dto) async {
    try {
      final res = await httpApp.get(ApiUrl.getAllRoom, data: dto.toJson());
      final List<dynamic> data = res.data['content'];
      final rooms = data
          .map((e) => Room.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(rooms, last: res.data['last']);
    } catch (e) {
      debug(e);
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<Room>> getDetail(BaseRequestDTO dto) async {
    try {
      var response = await httpApp.get(
        ApiUrl.getDetailRoom,
        data: dto.toJson(),
      );
      if (response.data["message"] == ApiResponse.success) {
        Room data = Room.fromJson(response.data["payload"]);
        return ApiResult.success(data);
      }
      return ApiResult.failure(error: ErrorMessage.fromJson(response.data));
    } catch (_) {
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<Room>> create(BaseRequestDTO dto) async {
    try {
      var response = await httpApp.post(ApiUrl.createRoom, data: dto.toJson());
      if (response.data["message"] == ApiResponse.success) {
        return ApiResult.success(Room.fromJson(response.data["payload"]));
      }
      return ApiResult.failure(error: ErrorMessage.fromJson(response.data));
    } catch (_) {
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<bool>> delete(BaseRequestDTO dto) async {
    try {
      var response = await httpApp.delete(
        ApiUrl.deleteRoom,
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
  Future<ApiResult<Room>> update(BaseRequestDTO dto) async {
    try {
      var response = await httpApp.post(ApiUrl.updateRoom, data: dto.toJson());
      if (response.data["message"] == ApiResponse.success) {
        return ApiResult.success(Room.fromJson(response.data["payload"]));
      }
      return ApiResult.failure(
        error: ErrorMessage.fromJson(response.data),
      );
    } catch (_) {
      return ApiResult.failure();
    }
  }
}
