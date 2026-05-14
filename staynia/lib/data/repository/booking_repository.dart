import 'package:staynia/data/entity/model/api_result.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/entity/model/booking.dart';

abstract class BookingRepository {
  Future<ApiResult<List<Booking>>> getBookings(BaseRequestDTO dto);
  Future<ApiResult<List<Booking>>> getByRenter(BaseRequestDTO dto);
  Future<ApiResult<Booking>> getDetail(BaseRequestDTO dto);
  Future<ApiResult<Booking>> create(BaseRequestDTO dto);
  Future<ApiResult<Booking>> update(BaseRequestDTO dto);
  Future<ApiResult<bool>> delete(BaseRequestDTO dto);
}
