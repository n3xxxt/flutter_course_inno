import 'package:flutter/material.dart';

import '../../domain/entities/space_item.dart';
import '../dto/space_item_dto.dart';

/// Преобразует DTO элемента каталога в энтити.
extension SpaceItemDtoMapper on SpaceItemDto {
  SpaceItem toEntity() {
    final parsedColor = color == null
        ? null
        : int.tryParse('FF$color', radix: 16);
    return SpaceItem(
      id: id,
      title: title,
      subtitle: subtitle,
      category: SpaceCategory.values.firstWhere(
        (c) => c.name == category,
        orElse: () => SpaceCategory.planet,
      ),
      tags: tags,
      color: parsedColor == null ? defaultSpaceItemColor : Color(parsedColor),
      description: description,
      createdAt: createdAt,
    );
  }
}

/// Преобразует энтити элемента каталога в DTO.
extension SpaceItemToDto on SpaceItem {
  SpaceItemDto toDto() {
    return SpaceItemDto(
      id: id,
      title: title,
      subtitle: subtitle,
      category: category.name,
      tags: tags,
      color: (color.toARGB32() & 0xFFFFFF)
          .toRadixString(16)
          .padLeft(6, '0')
          .toUpperCase(),
      description: description,
      createdAt: createdAt,
    );
  }
}
