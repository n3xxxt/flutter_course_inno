import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/app_strings.dart';

part 'space_item.freezed.dart';

enum SpaceCategory {
  planet(AppStrings.categoryPlanet, Icons.public),
  mission(AppStrings.categoryMission, Icons.rocket_launch),
  telescope(AppStrings.categoryTelescope, Icons.satellite_alt);

  const SpaceCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}

/// Цвет элемента каталога по умолчанию.
const defaultSpaceItemColor = Color(0xFF2F5D50);

/// Элемент каталога космоса.
@freezed
abstract class SpaceItem with _$SpaceItem {
  const factory SpaceItem({
    required String id,
    required String title,
    required String subtitle,
    required SpaceCategory category,
    required List<String> tags,
    required Color color,
    required String description,
    DateTime? createdAt,
  }) = _SpaceItem;

  /// Черновик нового элемента: id выдаёт сервер.
  factory SpaceItem.draft({
    required String title,
    String subtitle = '',
    SpaceCategory category = SpaceCategory.planet,
    String description = '',
  }) {
    return SpaceItem(
      id: '',
      title: title,
      subtitle: subtitle,
      category: category,
      tags: const [],
      color: defaultSpaceItemColor,
      description: description,
    );
  }
}
