import 'package:json_annotation/json_annotation.dart';

part 'district.g.dart';

@JsonSerializable()
class District {
  final int? id;
  final String? code;
  final String? name;
  final int? status;
  final int? provinceId;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final DateTime? lastUpdatedDate;

  const District({
    this.id,
    this.code,
    this.name,
    this.status,
    this.provinceId,
    this.createdDate,
    this.updatedDate,
    this.lastUpdatedDate,
  });

  factory District.fromJson(Map<String, dynamic> json) => _$DistrictFromJson(json);
  Map<String, dynamic> toJson() => _$DistrictToJson(this);
}
