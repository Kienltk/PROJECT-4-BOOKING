import 'package:flutter/material.dart';
import 'package:staynia/components/media/app_cache_image.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/data/entity/model/booking.dart';
import 'package:staynia/data/entity/model/room.dart';
import 'package:staynia/extension/app_extension.dart';

class BookingInfo extends StatelessWidget {
  const BookingInfo({super.key, required this.booking});
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    Room room = booking.roomDTO!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 130,
          height: 130,
          child: AppCacheImage(
            images: room.documents,
            radius: defaultBorderRadious,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4).copyWith(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  room.title ?? '-',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _infoChip(
                      label: 'Guests',
                      value: '${booking.guests ?? 0}',
                      color: Colors.blue[50]!,
                      textColor: Colors.blue[700]!,
                    ),
                    Box.s10,
                    _infoChip(
                      value: booking.bookingStatus.getBookingStatusName,
                      color: booking.bookingStatus == 1
                          ? Colors.green[50]!
                          : Colors.orange[50]!,
                      textColor: booking.bookingStatus == 1
                          ? Colors.green[700]!
                          : Colors.orange[700]!,
                    ),
                  ],
                ),

                const SizedBox(height: 6),
                Text(
                  'Check-in: ${booking.checkInDate.toDATEONLY}',
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
                Text(
                  'Check-out: ${booking.checkOutDate.toDATEONLY}',
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Text(
                  '₫ ${booking.pricePerNight.toVND}/Night',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                Text(
                  'Total: ${booking.totalPrice.toVND}VND',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoChip({
    String? label,
    required String value,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: label != null
          ? Text(
              '$label: $value',
              style: TextStyle(
                fontSize: 12,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            )
          : Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }
}
