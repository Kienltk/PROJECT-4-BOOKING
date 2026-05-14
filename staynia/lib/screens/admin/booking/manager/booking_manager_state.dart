import 'package:staynia/core/base/bloc/base_cubit_state.dart';
import 'package:staynia/data/entity/model/booking.dart';

class BookingManagerState extends BaseCubitState<List<Booking>> {
  BookingManagerState({super.loading, super.error, super.data});
  @override
  BookingManagerState copyWith({bool? loading, String? error, List<Booking>? data}) {
    return BookingManagerState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
