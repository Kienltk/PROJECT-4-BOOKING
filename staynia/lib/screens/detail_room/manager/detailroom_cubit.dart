import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/utils/app_bottom_sheet/app_bottom_sheet.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/repository/room_repository.dart';
import 'package:staynia/screens/detail_room/manager/detailroom_state.dart';
import 'package:staynia/screens/detail_room/widgets/detail_categories_widget.dart';

class DetailRoomCubit extends BaseCubit<DetailroomState, RoomRepository> {
  DetailRoomCubit(RoomRepository repository)
    : super(DetailroomState(), repository);

  @override
  Future<void> onInit({arg}) async {
    emit(state.copyWith(loading: true));
    try {
      await repository.getDetail(BaseRequestDTO(payload: {"id": arg})).then((
        res,
      ) {
        if (res.success) {
          emit(state.copyWith(data: res.data));
        } else {
          showAlert(message: res.error?.message, code: res.error?.code);
        }
      });
    } catch (_) {
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> showCategory() async {
    AppBottomSheet.showAppBottomSheet(
      context: context,
      child: DetailCategoriesWidget(categories: state.data?.commons ?? []),
    );
  }
}
