import 'package:staynia/core/base/bloc/base_cubit_state.dart';
import 'package:staynia/data/entity/model/payment_method.dart';
import 'package:staynia/data/entity/model/room.dart';

class RequestToBookState extends BaseCubitState<Room> {
  RequestToBookState({
    super.loading,
    super.error,
    super.data,
    this.checkInDate,
    this.checkOutDate,
    this.totalNight = 1,
    this.guest = 1,
    this.totalPrice,
    PaymentMethod? paymentMethod,
  }) : paymentMethod = paymentMethod ?? PaymentMethod(id: 2, name: "Money");

  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int guest;
  final int totalNight;
  final double? totalPrice;
  final PaymentMethod? paymentMethod;

  @override
  RequestToBookState copyWith({
    bool? loading,
    String? error,
    Room? data,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? guest,
    int? totalNight,
    double? totalPrice,
    PaymentMethod? paymentMethod,
  }) {
    return RequestToBookState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      data: data ?? this.data,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      guest: guest ?? this.guest,
      totalNight: totalNight ?? this.totalNight,
      totalPrice: totalPrice ?? this.totalPrice,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}
