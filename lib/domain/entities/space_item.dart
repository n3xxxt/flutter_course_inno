import 'package:flutter/material.dart';
import '../../core/app_strings.dart';

enum SpaceCategory {
  planet(AppStrings.categoryPlanet, Icons.public),
  mission(AppStrings.categoryMission, Icons.rocket_launch),
  telescope(AppStrings.categoryTelescope, Icons.satellite_alt);

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
    this.createdAt,
  });

  /// Черновик нового элемента: id выдаёт сервер.
  const SpaceItem.draft({
    required this.title,
    this.subtitle = '',
    this.category = SpaceCategory.planet,
    this.description = '',
  }) : id = '',
       createdAt = null,
       tags = const [],
       color = _defaultColor;

  /// Создаёт элемент из JSON-объекта сервера.
  factory SpaceItem.fromJson(Map<String, dynamic> json) {
    final categoryName = json['category'];
    final rawColor = json['color'];
    final parsedColor = rawColor is String
        ? int.tryParse('FF$rawColor', radix: 16)
        : null;
    return SpaceItem(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String? ?? '',
      category: SpaceCategory.values.firstWhere(
        (c) => c.name == categoryName,
        orElse: () => SpaceCategory.planet,
      ),
      tags: json['tags'] == null
          ? const []
          : List<String>.from(json['tags'] as List),
      color: parsedColor == null ? _defaultColor : Color(parsedColor),
      description: json['description'] as String? ?? '',
      createdAt: json['createdAt'] as DateTime?,
    );
  }

  final String id;
  final String title;
  final String subtitle;
  final SpaceCategory category;
  final List<String> tags;
  final Color color;
  final String description;
  final DateTime? createdAt;

  /// Копия элемента с изменёнными полями.
  SpaceItem copyWith({
    String? title,
    String? subtitle,
    SpaceCategory? category,
    String? description,
  }) {
    return SpaceItem(
      id: id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      category: category ?? this.category,
      tags: tags,
      color: color,
      description: description ?? this.description,
      createdAt: createdAt,
    );
  }

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
