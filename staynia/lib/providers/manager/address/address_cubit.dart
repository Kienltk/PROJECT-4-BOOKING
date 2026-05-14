import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/dialog/app_dialog.dart';
import 'package:staynia/data/entity/model/address/district.dart';
import 'package:staynia/data/entity/model/address/province.dart';
import 'package:staynia/data/entity/model/address/ward.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/repository/address_repository.dart';
import 'package:staynia/providers/manager/address/address_state.dart';

class AddressCubit extends BaseCubit<AddressState, AddressRepository> {
  AddressCubit(AddressRepository r) : super(AddressState(), r) {
    pageController = PageController();
    get();
  }
  late PageController pageController;

  @override
  Future<void> onInit({dynamic arg}) async {
    emit(state.copyWith(provinceLoading: true));
    try {
      var res = await repository.getProvinces(BaseRequestDTO());
      if (res.success) {
        emit(state.copyWith(provinces: res.data));
      }
    } catch (_) {
      emit(state.copyWith(provinceLoading: false));
    }
  }

  Future<void> getDistricts(int? provinceId) async {
    if (provinceId == null) return;
    emit(state.copyWith(districtLoading: true));
    try {
      var res = await repository.getDistricts(
        BaseRequestDTO(payload: {'id': provinceId}),
      );
      if (res.success) {
        emit(state.copyWith(districts: res.data));
      }
    } catch (_) {
      emit(state.copyWith(districtLoading: false));
    }
  }

  Future<void> getWards(int? districtId) async {
    if (districtId == null) return;
    emit(state.copyWith(wardLoading: true));
    try {
      var res = await repository.getWards(
        BaseRequestDTO(payload: {'id': districtId}),
      );
      if (res.success) {
        emit(state.copyWith(wards: res.data));
      }
    } catch (_) {
      emit(state.copyWith(wardLoading: false));
    }
  }

  void showProvinces({required void Function(Province? data) callBack}) {
    AppDialog.showAppActionSheet(
      context: context,
      cancelLabel: 'Close',
      title: 'Provinces',
      onPopInvokedWithResult: (_, result) {
        getDistricts(result?.id);
        emit(
          state.copyWith(
            selectedProvince: result,
            selectedDistrict: null,
            selectedWard: null,
          ),
        );
        callBack(result);
      },
      actions: [
        ...(state.provinces ?? []).map((item) {
          return SheetAction<Province>(
            label: '${item.name}',
            key: item,
            isDefaultAction: item.code == state.selectedProvince?.code,
          );
        }),
      ],
    );
  }

  void showDistricts({required void Function(District? data) callBack}) {
    AppDialog.showAppActionSheet(
      context: context,
      cancelLabel: 'Close',
      title: 'Districts',
      onPopInvokedWithResult: (_, result) {
        getWards(result?.id);
        emit(state.copyWith(selectedDistrict: result, selectedWard: null));
        callBack(result);
      },
      actions: [
        ...(state.districts ?? []).map((item) {
          return SheetAction<District>(
            label: '${item.name}',
            key: item,
            isDefaultAction: item.code == state.selectedDistrict?.code,
          );
        }),
      ],
    );
  }

  void showWards({required void Function(Ward? data) callBack}) {
    AppDialog.showAppActionSheet(
      context: context,
      cancelLabel: 'Close',
      title: 'Wards',
      onPopInvokedWithResult: (_, result) {
        emit(state.copyWith(selectedWard: result));
        callBack(result);
      },
      actions: [
        ...(state.wards ?? []).map((item) {
          return SheetAction<Ward>(
            label: '${item.name}',
            key: item,
            isDefaultAction: item.code == state.selectedWard?.code,
          );
        }),
      ],
    );
  }
}
