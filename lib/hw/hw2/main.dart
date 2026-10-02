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
    required this.subtitle,
    required this.category,
    required this.year,
    required this.colors,
    this.isLiked = false,
  });

  final String title;
  final String subtitle;
  final SpaceCategory category;
  final String year;
  final List<Color> colors;
  final bool isLiked;
}

const _items = [
  SpaceItem(
    title: 'Марс',
    subtitle: 'Красная планета с крупнейшим вулканом Солнечной системы',
    category: SpaceCategory.planet,
    year: 'Известна с древности',
    colors: [Color(0xFFE5533D), Color(0xFF8E2A1B)],
    isLiked: true,
  ),
  SpaceItem(
    title: 'Юпитер',
    subtitle: 'Газовый гигант, внутри которого поместилась бы тысяча Земель',
    category: SpaceCategory.planet,
    year: 'Известен с древности',
    colors: [Color(0xFFE0A96D), Color(0xFF8B5A2B)],
  ),
  SpaceItem(
    title: 'Сатурн',
    subtitle: 'Планета с самыми яркими кольцами из льда и камня',
    category: SpaceCategory.planet,
    year: 'Известен с древности',
    colors: [Color(0xFFF2D49B), Color(0xFFB08A4A)],
    isLiked: true,
  ),
  SpaceItem(
    title: 'Нептун',
    subtitle: 'Ледяной гигант с самыми сильными ветрами',
    category: SpaceCategory.planet,
    year: '1846',
    colors: [Color(0xFF4A7BD0), Color(0xFF1B2F6E)],
  ),
  SpaceItem(
    title: 'Восток-1',
    subtitle: 'Первый полёт человека в космос',
    category: SpaceCategory.mission,
    year: '1961',
    colors: [Color(0xFFD32F2F), Color(0xFF4A0E0E)],
    isLiked: true,
  ),
  SpaceItem(
    title: 'Аполлон-11',
    subtitle: 'Первая высадка людей на Луну',
    category: SpaceCategory.mission,
    year: '1969',
    colors: [Color(0xFF9E9E9E), Color(0xFF263238)],
  ),
  SpaceItem(
    title: 'Вояджер-1: самый далёкий от Земли рукотворный объект в истории',
    subtitle: 'Покинул гелиосферу и продолжает передавать данные из '
        'межзвёздного пространства спустя десятилетия после запуска',
    category: SpaceCategory.mission,
    year: '1977',
    colors: [Color(0xFF7E57C2), Color(0xFF1A0F3C)],
  ),
  SpaceItem(
    title: 'Луноход-1',
    subtitle: 'Первый планетоход, успешно работавший на другом небесном теле',
    category: SpaceCategory.mission,
    year: '1970',
    colors: [Color(0xFF78909C), Color(0xFF37474F)],
  ),
  SpaceItem(
    title: 'Хаббл',
    subtitle: 'Орбитальный телескоп, изменивший представление о Вселенной',
    category: SpaceCategory.telescope,
    year: '1990',
    colors: [Color(0xFF26A69A), Color(0xFF004D40)],
    isLiked: true,
  ),
  SpaceItem(
    title: 'Джеймс Уэбб',
    subtitle: 'Инфракрасный телескоп, заглядывающий к первым галактикам',
    category: SpaceCategory.telescope,
    year: '2021',
    colors: [Color(0xFFFFB300), Color(0xFFB45F06)],
  ),
];

class CatalogApp extends StatelessWidget {
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Каталог космоса',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B2F6E)),
        scaffoldBackgroundColor: const Color(0xFFF3F4F8),
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
        title: const Text('Каталог космоса'),
        centerTitle: true,
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
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, 4),
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
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      item.category.icon,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item.category.label,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.year,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.black45,
                        ),
                      ),
                    ),
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
      width: 88,
      height: 88,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: item.colors,
              ),
            ),
          ),
          Center(
            child: Text(
              item.title.characters.first,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: Icon(
              item.isLiked ? Icons.favorite : Icons.favorite_border,
              size: 20,
              color: item.isLiked ? Colors.redAccent : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
