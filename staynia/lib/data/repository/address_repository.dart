import 'package:staynia/data/entity/model/address/district.dart';
import 'package:staynia/data/entity/model/address/province.dart';
import 'package:staynia/data/entity/model/address/ward.dart';
import 'package:staynia/data/entity/model/api_result.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';

abstract class AddressRepository {
  Future<ApiResult<List<Province>>> getProvinces(BaseRequestDTO dto);
  Future<ApiResult<List<District>>> getDistricts(BaseRequestDTO dto);
  Future<ApiResult<List<Ward>>> getWards(BaseRequestDTO dto);
}
