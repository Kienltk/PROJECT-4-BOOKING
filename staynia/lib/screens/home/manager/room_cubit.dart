import 'package:flutter/widgets.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/data/entity/enum/screen_type.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/repository/room_repository.dart';
import 'package:staynia/screens/home/manager/room_state.dart';

class RoomCubit extends BaseCubit<RoomState, RoomRepository> {
  RoomCubit(RoomRepository repository) : super(RoomState(), repository);
  final TextEditingController searchController = TextEditingController();
  @override
  Future<void> onInit({arg}) async {
    dynamic id = arg['categoryId'];
    emit(state.copyWith(loading: true));
    try {
      switch (arg['ScreenType'] as ScreenType) {
        case ScreenType.homeScreen:
          await repository
              .getAll(
                BaseRequestDTO(
                  payload: {"page": page, "limit": limit, "categoryId": id},
                ),
              )
              .then((res) {
                debug(res);
                if (res.success) {
                  emit(state.copyWith(data: res.data));
                }
              });
        case ScreenType.searchScreen:
          if (id == null) return;
          await repository
              .getAll(
                BaseRequestDTO(
                  payload: {"page": page, "limit": limit, "categoryId": id},
                ),
              )
              .then((res) {
                debug(res);
                if (res.success) {
                  emit(state.copyWith(data: res.data));
                }
              });
        case ScreenType.searchScreen2:
          if (id == null) return;
          await repository
              .getAll(
                BaseRequestDTO(
                  payload: {
                    "page": page,
                    "limit": limit,
                    "keyword": searchController.text,
                  },
                ),
              )
              .then((res) {
                debug(res);
                if (res.success) {
                  emit(state.copyWith(data: res.data));
                }
              });
      }
    } catch (_) {
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> search() async {
    page = 0;
    limit = 25;
    emit(state.copyWith(data: [], loading: true));
    try {
      await repository
          .getAll(
            BaseRequestDTO(
              payload: {
                "page": page,
                "limit": limit,
                "keyword": searchController.text,
              },
            ),
          )
          .then((res) {
            debug(res);
            if (res.success) {
              emit(state.copyWith(data: res.data));
            }
          });
    } catch (_) {
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
}
