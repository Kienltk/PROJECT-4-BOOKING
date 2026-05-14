import 'package:staynia/core/base/bloc/base_cubit_state.dart';
import 'package:staynia/data/entity/model/booking.dart';

class BookingDetailState extends BaseCubitState<Booking> {
  BookingDetailState({super.loading, super.error, super.data});

  @override
  BookingDetailState copyWith({bool? loading, String? error, Booking? data}) {
    return BookingDetailState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
