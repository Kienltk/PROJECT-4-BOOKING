import 'package:json_annotation/json_annotation.dart';
import 'package:staynia/data/entity/model/document.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int? createdBy;
  final int? lastUpdatedBy;
  final String? createdDate;
  final String? updatedDate;
  final String? lastUpdatedDate;
  final int? id;
  final String? username;
  final String? fullName;
  final String? email;
  final String? password;
  final dynamic type;
  final String? phone;
  final Document? document;
  final String? address;
  final int? status;

  const User({
    this.createdBy,
    this.lastUpdatedBy,
    this.createdDate,
    this.updatedDate,
    this.lastUpdatedDate,
    this.id,
    this.username,
    this.fullName,
    this.email,
    this.address,
    this.password,
    this.type,
    this.phone,
    this.document,
    this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    int? createdBy,
    int? lastUpdatedBy,
    String? createdDate,
    String? updatedDate,
    String? lastUpdatedDate,
    int? id,
    String? username,
    String? fullName,
    String? email,
    String? password,
    dynamic type,
    String? phone,
    Document? document,
    String? address,
    int? status,
  }) {
    return User(
      createdBy: createdBy ?? this.createdBy,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      lastUpdatedDate: lastUpdatedDate ?? this.lastUpdatedDate,
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      type: type ?? this.type,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      document: document ?? this.document,
      status: status ?? this.status,
    );
  }
}
