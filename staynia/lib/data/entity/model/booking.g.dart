// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
  id: (json['id'] as num?)?.toInt(),
  renterId: (json['renterId'] as num?)?.toInt(),
  propertyId: (json['propertyId'] as num?)?.toInt(),
  status: (json['status'] as num?)?.toInt(),
  transCode: json['transCode'] as String?,
  checkInDate: json['checkInDate'] == null
      ? null
      : DateTime.parse(json['checkInDate'] as String),
  checkOutDate: json['checkOutDate'] == null
      ? null
      : DateTime.parse(json['checkOutDate'] as String),
  bookingStatus: (json['bookingStatus'] as num?)?.toInt(),
  pricePerNight: (json['pricePerNight'] as num?)?.toDouble(),
  additionalFees: json['additionalFees'] as String?,
  totalPrice: (json['totalPrice'] as num?)?.toDouble(),
  guests: (json['guests'] as num?)?.toInt(),
  renterDTO: json['renterDTO'] == null
      ? null
      : User.fromJson(json['renterDTO'] as Map<String, dynamic>),
  roomDTO: json['roomDTO'] == null
      ? null
      : Room.fromJson(json['roomDTO'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
  'id': ?instance.id,
  'renterId': ?instance.renterId,
  'propertyId': ?instance.propertyId,
  'checkInDate': ?instance.checkInDate?.toIso8601String(),
  'checkOutDate': ?instance.checkOutDate?.toIso8601String(),
  'pricePerNight': ?instance.pricePerNight,
  'additionalFees': ?instance.additionalFees,
  'transCode': ?instance.transCode,
  'totalPrice': ?instance.totalPrice,
  'guests': ?instance.guests,
  'status': ?instance.status,
  'bookingStatus': ?instance.bookingStatus,
  'roomDTO': ?instance.roomDTO,
  'renterDTO': ?instance.renterDTO,
};
