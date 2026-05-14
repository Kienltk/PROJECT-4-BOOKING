import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/repository/room_repository.dart';
import 'package:staynia/screens/admin/room/manager/list_room/list_room_state.dart';

class ListRoomCubit extends BaseCubit<ListRoomState, RoomRepository> {
  ListRoomCubit(RoomRepository repository) : super(ListRoomState(), repository) {
    get();
  }

  @override
  Future<void> onInit({arg}) async {
    try {
      emit(state.copyWith(loading: true));
      await repository
          .getAll(BaseRequestDTO(payload: {"page": page, "limit": limit}))
          .then((res) {
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
