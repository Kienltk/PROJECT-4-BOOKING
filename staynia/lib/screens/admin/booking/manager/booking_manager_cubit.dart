import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/repository/booking_repository.dart';
import 'package:staynia/screens/admin/booking/manager/booking_manager_state.dart';

class BookingManagerCubit
    extends BaseCubit<BookingManagerState, BookingRepository> {
  BookingManagerCubit(BookingRepository repository)
    : super(BookingManagerState(), repository) {
    get();
  }

  @override
  Future<void> onInit({arg}) async {
    emit(state.copyWith(loading: true));
    try {
      await repository
          .getBookings(BaseRequestDTO(payload: {"page": page, "limit": limit}))
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
