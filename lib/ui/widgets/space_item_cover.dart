import 'package:flutter/material.dart';

import '../../domain/entities/space_item.dart';

/// Тег Hero для обложки элемента.
String spaceItemHeroTag(String id) => 'space-item-cover-$id';

/// Цветная обложка элемента с первой буквой названия.
class SpaceItemCover extends StatelessWidget {
  const SpaceItemCover({
    super.key,
    required this.item,
    this.width = 78,
    this.height = 106,
    this.borderRadius = 8,
    this.letterSize = 40,
  });

  final SpaceItem item;
  final double width;
  final double height;
  final double borderRadius;
  final double letterSize;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: spaceItemHeroTag(item.id),
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Text(
          item.title.characters.take(1).toString(),
          style: TextStyle(
            fontSize: letterSize,
            fontWeight: FontWeight.w600,
            color: Colors.white.withValues(alpha: 0.6),
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
