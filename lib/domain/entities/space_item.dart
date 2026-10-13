import 'package:flutter/material.dart';

enum SpaceCategory {
  planet('Планета', Icons.public),
  mission('Миссия', Icons.rocket_launch),
  telescope('Телескоп', Icons.satellite_alt);

  const SpaceCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}

class SpaceItem {
  const SpaceItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.tags,
    required this.color,
    this.description,
  });

  final int id;
  final String title;
  final String subtitle;
  final SpaceCategory category;
  final List<String> tags;
  final Color color;
  final String? description;
}
