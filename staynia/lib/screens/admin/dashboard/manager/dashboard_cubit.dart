import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/data/repository/room_repository.dart';
import 'package:staynia/screens/admin/dashboard/manager/dashboard_state.dart';

class DashboardCubit extends BaseCubit<DashboardState, RoomRepository> {
  DashboardCubit(RoomRepository repository)
    : super(DashboardState(), repository) {
    get();
  }

  @override
  Future<void> onInit({dynamic arg}) async {}
}
