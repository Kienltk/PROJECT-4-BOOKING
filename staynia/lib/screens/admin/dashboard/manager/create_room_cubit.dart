import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/data/repository/room_repository.dart';
import 'package:staynia/screens/admin/room/manager/create_room_state.dart';

class CreateRoomCubit extends BaseCubit<CreateRoomState, RoomRepository> {
  CreateRoomCubit(RoomRepository repository)
    : super(CreateRoomState(), repository) {
    get();
  }

  @override
  Future<void> onInit({dynamic arg}) async {}
}
