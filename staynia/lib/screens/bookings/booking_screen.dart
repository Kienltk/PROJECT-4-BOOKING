import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/button/on_click_button.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/components/container/my_container.dart';
import 'package:staynia/components/title_column_content.dart';
import 'package:staynia/components/widgets/booking_info.dart';
import 'package:staynia/core/base/base_screen.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/base/refresh_indicator_wrapper.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/router/router_path.dart';
import 'package:staynia/screens/bookings/manager/booking_cubit.dart';
import 'package:staynia/screens/bookings/manager/booking_state.dart';
import 'package:staynia/service/loading_service.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends BaseScreen<BookingScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final BookingCubit cubit;

  @override
  Map<Type, BaseCubit Function()> get cubitFactories => {
    BookingCubit: () => sl<BookingCubit>(),
  };

  @override
  void initState() {
    super.initState();
    cubit = getCubit<BookingCubit>();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildScreen(context);
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: ContainerBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Box.s70,
            const TitleColumnContent(title: "Your bookings"),
            Expanded(
              child: RefreshIndicatorWrapper<BookingCubit>(
                controller: cubit,
                child: BlocBuilder<BookingCubit, BookingState>(
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
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
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
            ),
          ],
        ),
      ),
    );
  }
}
