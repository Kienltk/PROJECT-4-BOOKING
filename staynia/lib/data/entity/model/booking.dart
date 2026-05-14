import 'package:json_annotation/json_annotation.dart';
import 'package:staynia/data/entity/model/room.dart';
import 'package:staynia/data/entity/model/user.dart';

part 'booking.g.dart';

@JsonSerializable(includeIfNull: false)
class Booking {
  final int? id;
  final int? renterId;
  final int? propertyId;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final double? pricePerNight;
  final String? additionalFees;
  final String? transCode;
  final double? totalPrice;
  final int? guests;
  final int? status;
  final int? bookingStatus;
  final Room? roomDTO;
  final User? renterDTO;

  Booking({
    this.id,
    this.renterId,
    this.propertyId,
    this.status,
    this.transCode,
    this.checkInDate,
    this.checkOutDate,
    this.bookingStatus,
    this.pricePerNight,
    this.additionalFees,
    this.totalPrice,
    this.guests,
    this.renterDTO,
    this.roomDTO,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
