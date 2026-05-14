import 'package:staynia/core/constants/api_url.dart';
import 'package:staynia/core/network/http_app.dart';
import 'package:staynia/data/entity/model/address/district.dart';
import 'package:staynia/data/entity/model/address/province.dart';
import 'package:staynia/data/entity/model/address/ward.dart';
import 'package:staynia/data/entity/model/api_result.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/repository/address_repository.dart';

class AddressRepositoryImpl extends HttpApp implements AddressRepository {
  @override
  Future<ApiResult<List<District>>> getDistricts(BaseRequestDTO dto) async {
    try {
      final res = await httpApp.get(ApiUrl.getDistricts, data: dto.toJson());
      final List<dynamic> data = res.data['payload'];
      final districts = data
          .map((e) => District.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(districts);
    } catch (e) {
      debug(e);
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<List<Province>>> getProvinces(BaseRequestDTO dto) async {
    try {
      final res = await httpApp.get(ApiUrl.getProvinces, data: dto.toJson());
      final List<dynamic> data = res.data['payload'];
      final districts = data
          .map((e) => Province.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(districts);
    } catch (e) {
      debug(e);
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<List<Ward>>> getWards(BaseRequestDTO dto) async {
    try {
      final res = await httpApp.get(ApiUrl.getWards, data: dto.toJson());
      final List<dynamic> data = res.data['payload'];
      final districts = data
          .map((e) => Ward.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(districts);
    } catch (e) {
      debug(e);
      return ApiResult.failure();
    }
  }
}
