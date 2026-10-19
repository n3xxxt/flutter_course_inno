import 'package:flutter/material.dart';

enum SpaceCategory {
  planet('Планета', Icons.public),
  mission('Миссия', Icons.rocket_launch),
  telescope('Телескоп', Icons.satellite_alt);

  const SpaceCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}

const _defaultColor = Color(0xFF2F5D50);

class SpaceItem {
  const SpaceItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.tags,
    required this.color,
    required this.description,
  });

  /// Черновик нового элемента: id выдаёт сервер.
  const SpaceItem.draft({
    required this.title,
    this.subtitle = '',
    this.category = SpaceCategory.planet,
  }) : id = '',
       tags = const [],
       description = '',
       color = _defaultColor;

  /// Создаёт элемент из JSON-объекта сервера.
  factory SpaceItem.fromJson(Map<String, dynamic> json) {
    return SpaceItem(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      category: SpaceCategory.values.byName(json['category'] as String),
      tags: List<String>.from(json['tags'] as List),
      color: Color(int.parse('FF${json['color']}', radix: 16)),
      description: json['description'] as String,
    );
  }

  final String id;
  final String title;
  final String subtitle;
  final SpaceCategory category;
  final List<String> tags;
  final Color color;
  final String description;

  /// JSON для отправки на сервер, без id.
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'category': category.name,
      'description': description,
      'tags': tags,
      'color': (color.toARGB32() & 0xFFFFFF)
          .toRadixString(16)
          .padLeft(6, '0')
          .toUpperCase(),
    };
  }
}
