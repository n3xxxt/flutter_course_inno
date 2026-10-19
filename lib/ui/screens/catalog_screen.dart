import 'package:flutter/material.dart';

import '../../data/space_items_api.dart';
import '../notifiers/catalog_notifier.dart';
import '../notifiers/favorites_notifier.dart';
import '../widgets/add_space_item_form.dart';
import '../widgets/space_item_card.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key, required this.api});

  final SpaceItemsApi api;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late final CatalogNotifier _catalog;
  final _favorites = FavoritesNotifier();
  final _onlyFavorites = ValueNotifier(false);
  final _showForm = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _catalog = CatalogNotifier(widget.api);
    _catalog.load();
  }

  @override
  void dispose() {
    _catalog.dispose();
    _favorites.dispose();
    _onlyFavorites.dispose();
    _showForm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        toolbarHeight: 72,
        centerTitle: false,
        actions: [
          ListenableBuilder(
            listenable: Listenable.merge([_showForm, _catalog]),
            builder: (context, _) {
              final show = _showForm.value;
              return IconButton(
                icon: Icon(show ? Icons.close : Icons.add),
                tooltip: show ? 'Скрыть форму' : 'Добавить объект',
                onPressed: (_catalog.isLoading || _catalog.error != null)
                    ? null
                    : () => _showForm.value = !show,
              );
            },
          ),
        ],
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
            ListenableBuilder(
              listenable: _catalog,
              builder: (context, _) => Text(
                '${_catalog.items.length} объектов в каталоге',
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
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
                ListenableBuilder(
                  listenable: _favorites,
                  builder: (context, _) => Text(
                    'В избранном: ${_favorites.count}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ),
                const Spacer(),
                ListenableBuilder(
                  listenable: _onlyFavorites,
                  builder: (context, _) => FilterChip(
                    label: const Text('Только избранные'),
                    selected: _onlyFavorites.value,
                    onSelected: (_) =>
                        _onlyFavorites.value = !_onlyFavorites.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListenableBuilder(
        listenable: _catalog,
        builder: (context, _) => _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_catalog.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_catalog.error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, size: 48, color: Colors.black38),
              const SizedBox(height: 12),
              const Text(
                'Не удалось загрузить каталог',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                _catalog.error!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _catalog.load,
                child: const Text('Обновить'),
              ),
            ],
          ),
        ),
      );
    }
    return ListenableBuilder(
      listenable: Listenable.merge([
        _catalog,
        _favorites,
        _onlyFavorites,
        _showForm,
      ]),
      builder: (context, _) {
        final items = _catalog.items;
        final visibleItems = _onlyFavorites.value
            ? items.where((item) => _favorites.isLiked(item.id)).toList()
            : items;
        return CustomScrollView(
          slivers: [
            if (_showForm.value)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: AddSpaceItemForm(catalog: _catalog),
                ),
              ),
            if (visibleItems.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'Ничего не нашлось',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList.separated(
                  itemCount: visibleItems.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (_, index) {
                    final item = visibleItems[index];
                    return SpaceItemCard(
                      item: item,
                      isLiked: _favorites.isLiked(item.id),
                      onLikeTap: () => _favorites.toggle(item.id),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
