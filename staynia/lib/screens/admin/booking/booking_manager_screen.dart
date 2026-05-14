import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/app_bar/custom_app_bar.dart';
import 'package:staynia/components/button/on_click_button.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/components/container/my_container.dart';
import 'package:staynia/components/widgets/booking_info.dart';
import 'package:staynia/core/base/base_screen.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/router/router_path.dart';
import 'package:staynia/screens/admin/booking/manager/booking_manager_cubit.dart';
import 'package:staynia/screens/admin/booking/manager/booking_manager_state.dart';
import 'package:staynia/service/loading_service.dart';

class BookingManagerScreen extends StatefulWidget {
  const BookingManagerScreen({super.key});

  @override
  State<BookingManagerScreen> createState() => _BookingManagerScreenState();
}

class _BookingManagerScreenState extends BaseScreen<BookingManagerScreen> {
  late final BookingManagerCubit cubit;

  @override
  Map<Type, BaseCubit Function()> get cubitFactories => {
    BookingManagerCubit: () => sl<BookingManagerCubit>(),
  };

  @override
  void initState() {
    super.initState();
    cubit = getCubit<BookingManagerCubit>();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Booking Manager"),
      body: ContainerBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<BookingManagerCubit, BookingManagerState>(
                bloc: cubit,
                builder: (_, state) {
                  if (state.loading) {
                    return LoadingService.loading();
                  }
                  final bookings = state.data ?? [];
                  if (bookings.isEmpty) {
                    return const Center(
                      child: Text(
                        'You have no bookings yet.',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking = bookings[index];
                      return MyContainer(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: OnClickButton(
                          onClick: () {
                            context.pushTo(
                              RoutePaths.bookingDetail,
                              arguments: booking.id,
                            );
                          },
                          child: BookingInfo(booking: booking),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
