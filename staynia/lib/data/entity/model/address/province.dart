import 'package:json_annotation/json_annotation.dart';

part 'province.g.dart';

@JsonSerializable()
class Province {
  final int? id;
  final String? code;
  final String? name;
  final int? status;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final DateTime? lastUpdatedDate;

  const Province({
    this.id,
    this.code,
    this.name,
    this.status,
    this.createdDate,
    this.updatedDate,
    this.lastUpdatedDate,
  });

  factory Province.fromJson(Map<String, dynamic> json) => _$ProvinceFromJson(json);
  Map<String, dynamic> toJson() => _$ProvinceToJson(this);
}
