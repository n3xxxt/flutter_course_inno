import 'package:flutter/material.dart';

import '../../domain/entities/space_item.dart';
import 'animated_like_button.dart';
import 'space_item_cover.dart';

const _tagColor = Color(0xFFE3EFEA);
const _tagTextColor = Color(0xFF2F5D50);

class SpaceItemCard extends StatelessWidget {
  const SpaceItemCard({
    super.key,
    required this.item,
    required this.isLiked,
    required this.onLikeTap,
    required this.onTap,
  });

  final SpaceItem item;
  final bool isLiked;
  final VoidCallback onLikeTap;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(14);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: radius,
        border: Border.all(color: const Color(0xFFE6E4DF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CatalogCover(
                  item: item,
                  isLiked: isLiked,
                  onLikeTap: onLikeTap,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      if (item.subtitle.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          item.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                      if (item.description.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(
                          item.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF444444),
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          _CatalogTag(
                            label: item.category.label,
                            icon: item.category.icon,
                          ),
                          for (final tag in item.tags) _CatalogTag(label: tag),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CatalogCover extends StatelessWidget {
  const _CatalogCover({
    required this.item,
    required this.isLiked,
    required this.onLikeTap,
  });

  final SpaceItem item;
  final bool isLiked;
  final VoidCallback onLikeTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 78,
      height: 106,
      child: Stack(
        children: [
          SpaceItemCover(item: item),
          Positioned(
            top: 6,
            right: 6,
            child: AnimatedLikeButton(isLiked: isLiked, onTap: onLikeTap),
          ),
        ],
      ),
    );
  }
}

class _CatalogTag extends StatelessWidget {
  const _CatalogTag({required this.label, this.icon});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _tagColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: _tagTextColor),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, color: _tagTextColor),
            ),
          ),
        ],
      ),
    );
  }
}
