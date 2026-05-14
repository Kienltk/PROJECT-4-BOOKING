import 'package:staynia/data/entity/model/address/district.dart';
import 'package:staynia/data/entity/model/address/province.dart';
import 'package:staynia/data/entity/model/address/ward.dart';

class AddressState {
  static const _sentinel = Object();
  final bool provinceLoading;
  final bool wardLoading;
  final bool districtLoading;
  final List<Province>? provinces;
  final List<District>? districts;
  final List<Ward>? wards;
  final Province? selectedProvince;
  final District? selectedDistrict;
  final Ward? selectedWard;

  AddressState({
    this.provinceLoading = true,
    this.wardLoading = true,
    this.districtLoading = true,
    this.provinces = const [],
    this.districts = const [],
    this.wards = const [],
    this.selectedProvince,
    this.selectedDistrict,
    this.selectedWard,
  });

  AddressState copyWith({
    bool? provinceLoading,
    bool? wardLoading,
    bool? districtLoading,
    List<Province>? provinces,
    List<District>? districts,
    List<Ward>? wards,
    Object? selectedProvince = _sentinel,
    Object? selectedDistrict = _sentinel,
    Object? selectedWard = _sentinel,
  }) {
    return AddressState(
      provinceLoading: provinceLoading ?? this.provinceLoading,
      wardLoading: wardLoading ?? this.wardLoading,
      districtLoading: districtLoading ?? this.districtLoading,
      provinces: provinces ?? this.provinces,
      wards: wards ?? this.wards,
      districts: districts ?? this.districts,
      selectedProvince: selectedProvince == _sentinel
          ? this.selectedProvince
          : selectedProvince as Province?,
      selectedDistrict: selectedDistrict == _sentinel
          ? this.selectedDistrict
          : selectedDistrict as District?,
      selectedWard: selectedWard == _sentinel
          ? this.selectedWard
          : selectedWard as Ward?,
    );
  }
}
