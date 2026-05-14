import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/app_bar/custom_app_bar.dart';
import 'package:staynia/components/button/app_button.dart';
import 'package:staynia/components/button/on_click_button.dart';
import 'package:staynia/components/container/bottom_container.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/core/base/base_screen.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/data/entity/enum/app_button_type.dart';
import 'package:staynia/data/entity/model/room.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/theme_extension.dart';
import 'package:staynia/screens/booking/manager/request_to_book_cubit.dart';
import 'package:staynia/screens/booking/manager/request_to_book_state.dart';

class RequestBookingScreen extends StatefulWidget {
  final Room room;
  const RequestBookingScreen({super.key, required this.room});

  @override
  State<RequestBookingScreen> createState() => _RequestBookingScreenState();
}

class _RequestBookingScreenState extends BaseScreen<RequestBookingScreen> {
  late final Room room;
  late final RequestToBookCubit cubit;

  @override
  Map<Type, BaseCubit Function()> get cubitFactories => {
    RequestToBookCubit: () => sl<RequestToBookCubit>(),
  };

  @override
  void initState() {
    room = widget.room;
    super.initState();
    cubit = getCubit<RequestToBookCubit>();
    cubit.onInit(arg: room);
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Request to book', divider: true),
      body: BlocBuilder<RequestToBookCubit, RequestToBookState>(
        bloc: cubit,
        builder: (_, state) {
          return ContainerBody(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Box.s20,
                const Text(
                  "Date",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    OnClickButton(
                      onClick: () => cubit.showDatePicker(0),
                      child: _dateBox(
                        "Check - In",
                        state.checkInDate.toDATEONLY,
                      ),
                    ),
                    const SizedBox(width: 12),
                    OnClickButton(
                      onClick: () => cubit.showDatePicker(1),
                      child: _dateBox(
                        "Check - Out",
                        state.checkOutDate.toDATEONLY,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),
                const Text(
                  "Guest",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _circleButton(
                      icon: Icons.remove,
                      onTap: () => cubit.setGuest(1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        state.guest.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    _circleButton(
                      icon: Icons.add,
                      color: context.primaryColor,
                      onTap: () => cubit.setGuest(0),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                const Text(
                  "Pay With",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(defaultBorderRadious),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(defaultPadding),
                        decoration: BoxDecoration(
                          color: context.primaryColor.withOpacitySafe(0.1),
                          borderRadius: BorderRadius.circular(defaultBorderRadious),
                        ),
                        child: Icon(
                          Icons.wallet,
                          color: context.primaryColor,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.paymentMethod!.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          cubit.showPaymentMethod();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 0,
                          ),
                          side: BorderSide(color: Colors.grey.shade400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "select",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                const Text(
                  "Payment Details (VND)",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                _detailRow(
                  "Total : ${state.totalNight} Night",
                  (state.totalNight * room.pricePerNight!).toVND,
                  bold: false,
                ),
                _detailRow("Cleaning Fee", room.cleaningFee.toVND, bold: false),
                _detailRow("Service Fee", room.serviceFee.toVND, bold: false),
                const Divider(height: 30, thickness: 1),
                _detailRow(
                  "Total Payment:",
                  '${state.totalPrice.toVND}VND',
                  bold: true,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomContainer(
        child: AppButton(type: AppButtonType.primary, onClick: cubit.submit),
      ),
    );
  }

  Widget _dateBox(String label, String date) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(defaultBorderRadious),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.cabin, size: 16),
                const SizedBox(width: 5),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              date,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: context.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    Color? color,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color ?? Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color != null ? Colors.white : Colors.black54),
      ),
    );
  }

  Widget _detailRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: bold ? Colors.black : Colors.grey.shade600,
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
