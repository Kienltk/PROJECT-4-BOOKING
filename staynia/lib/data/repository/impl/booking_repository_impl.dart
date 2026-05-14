import 'package:staynia/core/constants/api_url.dart';
import 'package:staynia/core/error_message.dart';
import 'package:staynia/core/network/http_app.dart';
import 'package:staynia/data/entity/model/api_result.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/entity/model/booking.dart';
import 'package:staynia/data/repository/booking_repository.dart';

class BookingRepositoryImpl extends HttpApp implements BookingRepository {
  @override
  Future<ApiResult<Booking>> create(BaseRequestDTO dto) async {
    try {
      var response = await httpApp.post(
        ApiUrl.createBooking,
        data: dto.toJson(),
      );
      if (response.data["message"] == ApiResponse.success) {
        return ApiResult.success(
          Booking.fromJson(response.data["payload"]),
          last: response.data["last"],
        );
      }
      return ApiResult.failure(error: ErrorMessage.fromJson(response.data));
    } catch (e) {
      debug(e);
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<bool>> delete(BaseRequestDTO dto) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<List<Booking>>> getBookings(BaseRequestDTO dto) async {
    try {
      final res = await httpApp.get(ApiUrl.getBookings, data: dto.toJson());
      final List<dynamic> data = res.data['content'];
      final bookins = data
          .map((e) => Booking.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(bookins, last: res.data['last']);
    } catch (e) {
      debug(e);
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<Booking>> getDetail(BaseRequestDTO dto) async {
    try {
      var response = await httpApp.get(
        ApiUrl.getBookingDetail,
        data: dto.toJson(),
      );
      if (response.data["message"] == ApiResponse.success) {
        Booking data = Booking.fromJson(response.data["payload"]);
        return ApiResult.success(data);
      }
      return ApiResult.failure(error: ErrorMessage.fromJson(response.data));
    } catch (_) {
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<Booking>> update(BaseRequestDTO dto) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<List<Booking>>> getByRenter(BaseRequestDTO dto) async {
    try {
      final res = await httpApp.get(ApiUrl.getByRenter, data: dto.toJson());
      final List<dynamic> data = res.data['content'];
      final bookins = data
          .map((e) => Booking.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(bookins, last: res.data['last']);
    } catch (e) {
      debug(e);
      return ApiResult.failure();
    }
  }
}
