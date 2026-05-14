import 'package:staynia/core/base/bloc/base_cubit_state.dart';
import 'package:staynia/data/entity/model/booking.dart';

class BookingState extends BaseCubitState<List<Booking>> {
  BookingState({super.loading, super.error, super.data});
  @override
  BookingState copyWith({bool? loading, String? error, List<Booking>? data}) {
    return BookingState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
