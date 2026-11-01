// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'space_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpaceItemDto _$SpaceItemDtoFromJson(Map<String, dynamic> json) =>
    _SpaceItemDto(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      category: json['category'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      color: json['color'] as String?,
      description: json['description'] as String? ?? '',
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$SpaceItemDtoToJson(_SpaceItemDto instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'category': instance.category,
      'tags': instance.tags,
      'color': instance.color,
      'description': instance.description,
    };
