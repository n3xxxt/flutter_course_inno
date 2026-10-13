import 'package:flutter/material.dart';

import '../../domain/entities/space_item.dart';
import '../widgets/space_item_card.dart';

const _items = [
  SpaceItem(
    id: 1,
    title: 'Марс',
    subtitle: 'Солнечная система · с древности',
    category: SpaceCategory.planet,
    tags: ['Земная группа'],
    color: Color(0xFF8E3B2C),
    description: 'Красная планета с самым высоким вулканом — Олимпом.',
  ),
  SpaceItem(
    id: 2,
    title: 'Юпитер',
    subtitle: 'Солнечная система · с древности',
    category: SpaceCategory.planet,
    tags: ['Газовый гигант'],
    color: Color(0xFFB08550),
  ),
  SpaceItem(
    id: 3,
    title: 'Сатурн',
    subtitle: 'Солнечная система · с древности',
    category: SpaceCategory.planet,
    tags: ['Кольца'],
    color: Color(0xFFB59A3C),
    description: 'Самые заметные кольца из льда и камня.',
  ),
  SpaceItem(
    id: 4,
    title: 'Нептун',
    subtitle: 'Урбен Леверье, Иоганн Галле · 1846',
    category: SpaceCategory.planet,
    tags: ['Ледяной гигант'],
    color: Color(0xFF3F5682),
  ),
  SpaceItem(
    id: 5,
    title: 'Восток-1',
    subtitle: 'ОКБ-1, Сергей Королёв · 1961',
    category: SpaceCategory.mission,
    tags: ['Пилотируемая'],
    color: Color(0xFF9C3E3E),
    description: 'Первый полёт человека в космос — Юрий Гагарин.',
  ),
  SpaceItem(
    id: 6,
    title: 'Аполлон-11',
    subtitle: 'НАСА · 1969',
    category: SpaceCategory.mission,
    tags: ['Пилотируемая', 'Луна'],
    color: Color(0xFF5E6470),
  ),
  SpaceItem(
    id: 7,
    title: 'Вояджер-1: самый далёкий от Земли рукотворный объект в истории',
    subtitle: 'Лаборатория реактивного движения НАСА · 1977',
    category: SpaceCategory.mission,
    tags: ['Межзвёздная'],
    color: Color(0xFF6C5A7E),
  ),
  SpaceItem(
    id: 8,
    title: 'Луноход-1',
    subtitle: 'НПО имени Лавочкина · 1970',
    category: SpaceCategory.mission,
    tags: ['Луна'],
    color: Color(0xFF3F7270),
  ),
  SpaceItem(
    id: 9,
    title: 'Хаббл',
    subtitle: 'НАСА, ЕКА · 1990',
    category: SpaceCategory.telescope,
    tags: ['Орбитальный'],
    color: Color(0xFF2F6E62),
    description: 'Орбитальный телескоп, снявший «Столпы творения».',
  ),
  SpaceItem(
    id: 10,
    title: 'Джеймс Уэбб',
    subtitle: 'НАСА, ЕКА, ККА · 2021',
    category: SpaceCategory.telescope,
    tags: ['Инфракрасный'],
    color: Color(0xFFB07A2E),
  ),
];

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final Set<int> _likedIds = {};
  bool _onlyFavorites = false;

  void _toggleLike(int id) {
    setState(() {
      if (_likedIds.contains(id)) {
        _likedIds.remove(id);
      } else {
        _likedIds.add(id);
      }
    });
  }

  void _toggleOnlyFavorites() {
    setState(() => _onlyFavorites = !_onlyFavorites);
  }

  @override
  Widget build(BuildContext context) {
    final visibleItems = _onlyFavorites
        ? _items.where((item) => _likedIds.contains(item.id)).toList()
        : _items;

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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Row(
              children: [
                const Icon(Icons.favorite, size: 18, color: Color(0xFFD9534F)),
                const SizedBox(width: 6),
                Text(
                  'В избранном: ${_likedIds.length}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const Spacer(),
                FilterChip(
                  label: const Text('Только избранные'),
                  selected: _onlyFavorites,
                  onSelected: (_) => _toggleOnlyFavorites(),
                ),
              ],
            ),
          ),
        ),
      ),
      body: visibleItems.isEmpty
          ? const Center(
              child: Text(
                'Ничего не нашлось',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: visibleItems.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (_, index) {
                final item = visibleItems[index];
                return SpaceItemCard(
                  item: item,
                  isLiked: _likedIds.contains(item.id),
                  onLikeTap: () => _toggleLike(item.id),
                );
              },
            ),
    );
  }
}
