import 'package:json_annotation/json_annotation.dart';

part 'document.g.dart';

@JsonSerializable()
class Document {
  final int id;
  final String? imageUrl;
  final String? type;
  final String? info;
  final bool? isPrimary;

  const Document({
    required this.id,
    this.imageUrl,
    this.type,
    this.info,
    this.isPrimary,
  });

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);

  Document copyWith({
    int? id,
    String? imageUrl,
    String? type,
    String? info,
    bool? isPrimary,
  }) {
    return Document(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      info: info ?? this.info,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }
}
