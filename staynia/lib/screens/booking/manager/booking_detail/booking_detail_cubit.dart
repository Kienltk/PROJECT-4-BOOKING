import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/utils/app_bottom_sheet/app_bottom_sheet.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/repository/booking_repository.dart';
import 'package:staynia/screens/booking/manager/booking_detail/booking_detail_state.dart';
import 'package:staynia/screens/detail_room/widgets/detail_categories_widget.dart';

class BookingDetailCubit
    extends BaseCubit<BookingDetailState, BookingRepository> {
  BookingDetailCubit(BookingRepository repository)
    : super(BookingDetailState(), repository);
  @override
  Future<void> onInit({arg}) async {
    emit(state.copyWith(loading: true));
    try {
      var res = await repository.getDetail(
        BaseRequestDTO(payload: {"bookingId": arg}),
      );
      debug(res);
      if (res.success) {
        emit(state.copyWith(data: res.data));
      } else {
        showAlert(message: res.error?.message, code: res.error?.code);
      }
    } catch (_) {
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> showCategory() async {
    AppBottomSheet.showAppBottomSheet(
      context: context,
      child: DetailCategoriesWidget(
        categories: state.data?.roomDTO?.commons ?? [],
      ),
    );
  }
}
