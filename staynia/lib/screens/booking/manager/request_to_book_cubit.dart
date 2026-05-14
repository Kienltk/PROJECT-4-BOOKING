import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/dialog/app_dialog.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/entity/model/payment_method.dart';
import 'package:staynia/data/entity/model/room.dart';
import 'package:staynia/data/repository/booking_repository.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/screens/booking/manager/request_to_book_state.dart';

class RequestToBookCubit
    extends BaseCubit<RequestToBookState, BookingRepository> {
  RequestToBookCubit(BookingRepository repository)
    : super(RequestToBookState(), repository);
  Room? room;

  @override
  Future<void> onInit({arg}) async {
    room = arg;

    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));

    emit(
      state.copyWith(
        checkInDate: state.checkInDate ?? now,
        checkOutDate: state.checkOutDate ?? tomorrow,
        totalNight: 1,
      ),
    );
    calTotalPrice();
  }

  Future<void> submit() async {
    BaseRequestDTO dto = BaseRequestDTO(
      payload: {
        "roomId": room?.id,
        "checkInDate": state.checkInDate?.toDateDataRequest,
        "checkOutDate": state.checkOutDate?.toDateDataRequest,
        "guests": state.guest,
        "paymentMethod": state.paymentMethod?.id,
      },
    );
    await showLoading();
    try {
      var res = await repository.create(dto);
      if (res.success) {
        context.goBack();
        showAlert(message: "Booking success");
      } else {
        showAlert(message: res.error?.message, code: res.error?.code);
      }
    } catch (_) {
    } finally {
      hideLoading();
    }
    debug(dto);
  }

  Future<void> setGuest(int type) async {
    int guest = state.guest;
    if (type == 0) {
      guest += 1;
    } else {
      guest -= 1;
    }
    if (guest < 1) guest = 1;
    if (guest > room!.maxGuests!) return;
    emit(state.copyWith(guest: guest));
    calTotalPrice();
  }

  void calTotalPrice() {
    if (room == null) return;

    final double basePrice = room!.pricePerNight ?? 0;
    final double cleaningFee = room!.cleaningFee ?? 0;
    final double serviceFee = room!.serviceFee ?? 0;
    final int totalNight = state.totalNight;
    // Tổng giá = (giá mỗi đêm * số đêm) + phí dọn dẹp + phí dịch vụ
    final double total = (basePrice * totalNight) + cleaningFee + serviceFee;
    emit(state.copyWith(totalPrice: total));
  }

  Future<void> showDatePicker(int type) async {
    AppDialog.showCustomDateTimePicker(
      value: [state.checkInDate, state.checkOutDate],
      context,
      disablePastDate: true,
      onCancel: () {
        AppDialog.closeDialog();
        emit(state.copyWith(checkInDate: null, checkOutDate: null));
        calTotalPrice();
      },
      onSave: () {
        AppDialog.closeDialog();
      },
      onValueChanged: (dates) {
        final checkIn = dates.isNotEmpty ? dates[0] : null;
        final checkOut = dates.length > 1 ? dates[1] : null;

        int totalNight = 1;
        if (checkIn != null && checkOut != null) {
          totalNight = checkOut.difference(checkIn).inDays;
          if (totalNight < 1) totalNight = 1;
        }

        emit(
          state.copyWith(
            checkInDate: checkIn,
            checkOutDate: checkOut,
            totalNight: totalNight,
          ),
        );

        calTotalPrice();
      },
    );
  }

  List<PaymentMethod> paymentMethod = [
    PaymentMethod(id: 1, name: 'Bank'),
    PaymentMethod(id: 2, name: 'Money'),
  ];

  void showPaymentMethod() {
    AppDialog.showAppActionSheet(
      context: context,
      cancelLabel: 'Cancel',
      title: 'Payment Method',
      onPopInvokedWithResult: (_, result) {
        emit(state.copyWith(paymentMethod: result));
      },
      actions: [
        ...paymentMethod.map((item) {
          return SheetAction<PaymentMethod>(
            label: item.name,
            key: item,
            isDefaultAction: item.id == state.paymentMethod?.id,
          );
        }),
      ],
    );
  }
}
