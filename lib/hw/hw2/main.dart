import 'package:flutter/material.dart';

void main() {
  runApp(const CatalogApp());
}

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
    required this.title,
    required this.author,
    required this.year,
    required this.category,
    required this.tags,
    required this.color,
    this.isLiked = false,
  });

  final String title;
  final String author;
  final String year;
  final SpaceCategory category;
  final List<String> tags;
  final Color color;
  final bool isLiked;
}

const _items = [
  SpaceItem(
    title: 'Марс',
    author: 'Солнечная система',
    year: 'с древности',
    category: SpaceCategory.planet,
    tags: ['Земная группа'],
    color: Color(0xFF8E3B2C),
    isLiked: true,
  ),
  SpaceItem(
    title: 'Юпитер',
    author: 'Солнечная система',
    year: 'с древности',
    category: SpaceCategory.planet,
    tags: ['Газовый гигант'],
    color: Color(0xFFB08550),
  ),
  SpaceItem(
    title: 'Сатурн',
    author: 'Солнечная система',
    year: 'с древности',
    category: SpaceCategory.planet,
    tags: ['Кольца'],
    color: Color(0xFFB59A3C),
    isLiked: true,
  ),
  SpaceItem(
    title: 'Нептун',
    author: 'Урбен Леверье, Иоганн Галле',
    year: '1846',
    category: SpaceCategory.planet,
    tags: ['Ледяной гигант'],
    color: Color(0xFF3F5682),
  ),
  SpaceItem(
    title: 'Восток-1',
    author: 'ОКБ-1, Сергей Королёв',
    year: '1961',
    category: SpaceCategory.mission,
    tags: ['Пилотируемая'],
    color: Color(0xFF9C3E3E),
    isLiked: true,
  ),
  SpaceItem(
    title: 'Аполлон-11',
    author: 'НАСА',
    year: '1969',
    category: SpaceCategory.mission,
    tags: ['Пилотируемая', 'Луна'],
    color: Color(0xFF5E6470),
  ),
  SpaceItem(
    title: 'Вояджер-1: самый далёкий от Земли рукотворный объект в истории',
    author: 'Лаборатория реактивного движения НАСА',
    year: '1977',
    category: SpaceCategory.mission,
    tags: ['Межзвёздная'],
    color: Color(0xFF6C5A7E),
  ),
  SpaceItem(
    title: 'Луноход-1',
    author: 'НПО имени Лавочкина',
    year: '1970',
    category: SpaceCategory.mission,
    tags: ['Луна'],
    color: Color(0xFF3F7270),
  ),
  SpaceItem(
    title: 'Хаббл',
    author: 'НАСА, ЕКА',
    year: '1990',
    category: SpaceCategory.telescope,
    tags: ['Орбитальный'],
    color: Color(0xFF2F6E62),
    isLiked: true,
  ),
  SpaceItem(
    title: 'Джеймс Уэбб',
    author: 'НАСА, ЕКА, ККА',
    year: '2021',
    category: SpaceCategory.telescope,
    tags: ['Инфракрасный'],
    color: Color(0xFFB07A2E),
  ),
];

const _backgroundColor = Color(0xFFF3F1EC);
const _tagColor = Color(0xFFE3EFEA);
const _tagTextColor = Color(0xFF2F5D50);

class CatalogApp extends StatelessWidget {
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Каталог космоса',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _tagTextColor),
        scaffoldBackgroundColor: _backgroundColor,
      ),
      home: const CatalogScreen(),
    );
  }
}

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        toolbarHeight: 72,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Каталог космоса',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            Text(
              '${_items.length} объектов в каталоге',
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _items.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (_, index) => CatalogCard(item: _items[index]),
      ),
    );
  }
}

class CatalogCard extends StatelessWidget {
  const CatalogCard({super.key, required this.item});

  final SpaceItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE6E4DF)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CatalogCover(item: item),
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
                const SizedBox(height: 4),
                Text(
                  '${item.author} · ${item.year}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
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
    );
  }
}

class _CatalogCover extends StatelessWidget {
  const _CatalogCover({required this.item});

  final SpaceItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 78,
      height: 106,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: item.color,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Center(
            child: Text(
              item.title.characters.first,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              width: 26,
              height: 26,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                item.isLiked ? Icons.favorite : Icons.favorite_border,
                size: 16,
                color: item.isLiked
                    ? const Color(0xFFD9534F)
                    : const Color(0xFF555555),
              ),
            ),
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
