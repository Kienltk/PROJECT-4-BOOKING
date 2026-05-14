import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/repository/booking_repository.dart';
import 'package:staynia/screens/bookings/manager/booking_state.dart';

class BookingCubit extends BaseCubit<BookingState, BookingRepository> {
  BookingCubit(BookingRepository repository)
    : super(BookingState(), repository) {
    get();
  }

  @override
  Future<void> onInit({arg}) async {
    emit(state.copyWith(loading: true));
    try {
      await repository.getByRenter(BaseRequestDTO(payload: {})).then((
        res,
      ) {
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
