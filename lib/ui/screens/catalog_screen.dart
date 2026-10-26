import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/app_strings.dart';
import '../../data/catalog_repository.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/catalog_cubit.dart';
import '../cubits/catalog_state.dart';
import '../widgets/space_item_card.dart';
import '../widgets/space_item_form_sheet.dart';
import 'details_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _toggleLike(BuildContext context, String id) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await context.read<CatalogCubit>().toggleLike(id);
    } on CatalogException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Future<void> _add(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final cubit = context.read<CatalogCubit>();
    final added = await showSpaceItemSheet(context, onSubmit: cubit.addItem);
    if (added == true) {
      messenger.showSnackBar(
        const SnackBar(content: Text(AppStrings.objectAdded)),
      );
    }
  }

  void _clearSearch(BuildContext context) {
    _searchController.clear();
    context.read<CatalogCubit>().search('');
  }

  void _openDetails(BuildContext context, String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<CatalogCubit>(),
          child: DetailsScreen(itemId: id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogCubit, CatalogState>(
      builder: (context, state) {
        final loaded = state is CatalogLoaded ? state : null;
        final cubit = context.read<CatalogCubit>();
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
                  AppStrings.appTitle,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                if (loaded != null)
                  Text(
                    AppStrings.itemsCount(loaded.items.length),
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                tooltip: AppStrings.addObjectTooltip,
                onPressed: loaded == null ? null : () => _add(context),
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: AppStrings.signOutTooltip,
                onPressed: () => context.read<AuthCubit>().signOut(),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(112),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      enabled: loaded != null,
                      onChanged: cubit.search,
                      decoration: InputDecoration(
                        hintText: AppStrings.searchHint,
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: (loaded?.query.isEmpty ?? true)
                            ? null
                            : IconButton(
                                icon: const Icon(Icons.clear),
                                tooltip: AppStrings.clearTooltip,
                                onPressed: () => _clearSearch(context),
                              ),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.favorite,
                          size: 18,
                          color: Color(0xFFD9534F),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          AppStrings.favoritesCount(
                            loaded?.favoritesCount ?? 0,
                          ),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        const Spacer(),
                        FilterChip(
                          label: const Text(AppStrings.onlyFavorites),
                          selected: loaded?.onlyFavorites ?? false,
                          onSelected: loaded == null
                              ? null
                              : (_) => cubit.toggleOnlyFavorites(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: switch (state) {
            CatalogLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            CatalogError(:final message) => _ErrorView(
              message: message,
              onRetry: cubit.load,
            ),
            CatalogLoaded() => _buildList(context, state),
          },
        );
      },
    );
  }

  Widget _buildList(BuildContext context, CatalogLoaded state) {
    final items = state.visibleItems;
    if (items.isEmpty) {
      final query = state.query.trim();
      final text = query.isNotEmpty
          ? AppStrings.nothingFound(query)
          : state.onlyFavorites
          ? AppStrings.emptyFavorites
          : AppStrings.emptyCatalog;
      return _EmptyView(text: text);
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];
        return SpaceItemCard(
          key: ValueKey(item.id),
          item: item,
          isLiked: state.isLiked(item.id),
          onLikeTap: () => _toggleLike(context, item.id),
          onTap: () => _openDetails(context, item.id),
        );
      },
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox_outlined, size: 48, color: Colors.black38),
            const SizedBox(height: 12),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, size: 48, color: Colors.black38),
            const SizedBox(height: 12),
            const Text(
              AppStrings.catalogLoadFailed,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: const Text(AppStrings.retryButton),
            ),
          ],
        ),
      ),
    );
  }
}
