import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/app_bar/custom_app_bar.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/components/media/app_cache_image.dart';
import 'package:staynia/components/media/image_gallery_view.dart';
import 'package:staynia/components/section/title_with_action.dart';
import 'package:staynia/components/title_column_content.dart';
import 'package:staynia/components/widgets/custom_render_html.dart';
import 'package:staynia/components/widgets/facility_icon.dart';
import 'package:staynia/core/base/base_screen.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/core/utils/utils.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/context_extension.dart';
import 'package:staynia/extension/theme_extension.dart';
import 'package:staynia/screens/booking/manager/booking_detail/booking_detail_cubit.dart';
import 'package:staynia/screens/booking/manager/booking_detail/booking_detail_state.dart';
import 'package:staynia/service/loading_service.dart';

class BookingDetailScreen extends StatefulWidget {
  const BookingDetailScreen({super.key, required this.bookingId});
  final int bookingId;

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends BaseScreen<BookingDetailScreen> {
  late final BookingDetailCubit cubit;

  @override
  Map<Type, BaseCubit Function()> get cubitFactories => {
    BookingDetailCubit: () => sl<BookingDetailCubit>(),
  };

  @override
  void initState() {
    super.initState();
    cubit = getCubit<BookingDetailCubit>();
    cubit.onInit(arg: widget.bookingId);
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(divider: true, title: "Booking Detail"),
      body: BlocBuilder<BookingDetailCubit, BookingDetailState>(
        bloc: cubit,
        builder: (context, state) {
          if (state.loading) {
            return LoadingService.loading();
          }
          if (state.data != null) {
            final booking = state.data;
            final room = booking!.roomDTO;
            final renter = booking.renterDTO;
            return SingleChildScrollView(
              child: ContainerBody(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Box.s24,
                    TitleColumnContent(
                      title: room!.title ?? 'Unknown Room',
                      text: room.subTitle,
                    ),
                    if (room.documents != null && room.documents!.isNotEmpty)
                      SizedBox(
                        height: context.sizeHeight * 0.3,
                        child: AppCacheImage(
                          images: room.documents,
                          radius: defaultBorderRadious,
                        ),
                      ),
                    Box.s10,
                    ImageGalleryView(
                      topWidget: Text(
                        "Galley",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      documents: room.documents,
                    ),
                    const SizedBox(height: 10),

                    // Booking info
                    _infoRow("Check-in", booking.checkInDate.toDATEONLY),
                    _infoRow("Check-out", booking.checkOutDate.toDATEONLY),
                    _infoRow("Guests", "${booking.guests}"),
                    const Divider(height: 20),
                    _infoRow("Price / Night", booking.pricePerNight.toVND),
                    _infoRow("Cleaning Fee", room.cleaningFee.toVND),
                    _infoRow("Service Fee", room.serviceFee.toVND),
                    const SizedBox(height: 8),
                    _infoRow(
                      "Total Price",
                      '${booking.totalPrice.toVND}VND',
                      style: TextStyle(
                        color: context.primaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _infoRow(
                      "Status",
                      booking.bookingStatus.getBookingStatusName,
                      style: TextStyle(
                        color: Utils.getStatusColor(booking.bookingStatus),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(height: 30),
                    Text(
                      "Renter",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _infoRow("Fullname", renter?.fullName),
                    _infoRow("Phone number", renter?.phone),
                    _infoRow("Email", renter?.email),
                    _infoRow("Address", renter?.address),
                    const Divider(height: 32),
                    Text(
                      "Room Info",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _infoRow("Bathrooms", "${room.bathroomCount}"),
                    _infoRow("Max Guests", "${room.maxGuests}"),
                    const SizedBox(height: 8),
                    TitleWithAction(
                      title: 'Common Facilities ☀️',
                      onClick: cubit.showCategory,
                    ),
                    Box.s6,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...(room.commons?.take(4).toList() ?? []).map((item) {
                          return FacilityIcon(
                            svg: item.icon!,
                            label: item.name!,
                            isAutoSizeText: false,
                            size: 25,
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (room.description != null)
                      CustomRenderHtmlPreview(
                        collapsedHeight: 250,
                        html: room.description ?? '',
                        room: room,
                      ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _infoRow(
    String label,
    String? value, {
    bool bold = false,
    TextStyle? style,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontSize: 13)),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 39),
                child: Text(
                  value ?? '-',
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      style ??
                      TextStyle(
                        fontSize: 15,
                        fontWeight: bold ? FontWeight.bold : FontWeight.w500,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
