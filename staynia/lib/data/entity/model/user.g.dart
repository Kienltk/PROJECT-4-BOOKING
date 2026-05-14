// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  createdBy: (json['createdBy'] as num?)?.toInt(),
  lastUpdatedBy: (json['lastUpdatedBy'] as num?)?.toInt(),
  createdDate: json['createdDate'] as String?,
  updatedDate: json['updatedDate'] as String?,
  lastUpdatedDate: json['lastUpdatedDate'] as String?,
  id: (json['id'] as num?)?.toInt(),
  username: json['username'] as String?,
  fullName: json['fullName'] as String?,
  email: json['email'] as String?,
  address: json['address'] as String?,
  password: json['password'] as String?,
  type: json['type'],
  phone: json['phone'] as String?,
  document: json['documents'] as Document?,
  status: (json['status'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'createdBy': instance.createdBy,
  'lastUpdatedBy': instance.lastUpdatedBy,
  'createdDate': instance.createdDate,
  'updatedDate': instance.updatedDate,
  'lastUpdatedDate': instance.lastUpdatedDate,
  'id': instance.id,
  'username': instance.username,
  'fullName': instance.fullName,
  'email': instance.email,
  'password': instance.password,
  'type': instance.type,
  'phone': instance.phone,
  'document': instance.document,
  'address': instance.address,
  'status': instance.status,
};
