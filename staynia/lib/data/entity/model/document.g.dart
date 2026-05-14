// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
  id: (json['id'] as num).toInt(),
  imageUrl: json['imageUrl'] as String?,
  type: json['type'] as String?,
  info: json['info'] as String?,
  isPrimary: json['isPrimary'] as bool?,
);

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
  'id': instance.id,
  'imageUrl': instance.imageUrl,
  'type': instance.type,
  'info': instance.info,
  'isPrimary': instance.isPrimary,
};
