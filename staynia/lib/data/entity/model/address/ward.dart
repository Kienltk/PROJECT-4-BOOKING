import 'package:json_annotation/json_annotation.dart';

part 'ward.g.dart';

@JsonSerializable()
class Ward {
  final int? id;
  final String? code;
  final String? name;
  final int? status;
  final int? districtId;
  final DateTime? createdDate;
  final DateTime? updatedDate;
  final DateTime? lastUpdatedDate;

  const Ward({
    this.id,
    this.code,
    this.name,
    this.status,
    this.districtId,
    this.createdDate,
    this.updatedDate,
    this.lastUpdatedDate,
  });

  factory Ward.fromJson(Map<String, dynamic> json) => _$WardFromJson(json);
  Map<String, dynamic> toJson() => _$WardToJson(this);
}
