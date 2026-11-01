import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/catalog_repository.dart';
import '../../domain/entities/space_item.dart';
import '../../bloc/catalog/catalog_cubit.dart';
import '../../bloc/catalog/catalog_state.dart';
import '../widgets/animated_like_button.dart';
import '../widgets/space_item_card.dart';
import '../widgets/space_item_cover.dart';
import '../widgets/space_item_form_sheet.dart';
import '../../core/app_strings.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.itemId});

  final String itemId;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  SpaceItem? _lastItem;
  bool _closing = false;

  void _onState(BuildContext context, CatalogState state) {
    if (state is! CatalogLoaded || _closing) return;
    if (state.itemById(widget.itemId) != null) return;
    _closing = true;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final route = ModalRoute.of(context);
    if (route == null || !route.isActive) return;
    navigator.popUntil((r) => r == route);
    navigator.pop();
    messenger.showSnackBar(
      const SnackBar(content: Text(AppStrings.itemDeleted)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CatalogCubit, CatalogState>(
      listener: _onState,
      builder: (context, state) {
        final loaded = state is CatalogLoaded ? state : null;
        final item = loaded?.itemById(widget.itemId) ?? _lastItem;
        _lastItem = item;
        return _DetailsView(
          itemId: widget.itemId,
          item: item,
          isLiked: item != null && (loaded?.isLiked(item.id) ?? false),
        );
      },
    );
  }
}

class _DetailsView extends StatelessWidget {
  const _DetailsView({
    required this.itemId,
    required this.item,
    required this.isLiked,
  });

  final String itemId;
  final SpaceItem? item;
  final bool isLiked;

  Future<void> _toggleLike(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await context.read<CatalogCubit>().toggleLike(itemId);
    } on CatalogException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Future<void> _edit(BuildContext context, SpaceItem item) async {
    final messenger = ScaffoldMessenger.of(context);
    final cubit = context.read<CatalogCubit>();
    final saved = await showSpaceItemSheet(
      context,
      initial: item,
      onSubmit: cubit.updateItem,
    );
    if (saved == true) {
      messenger.showSnackBar(
        const SnackBar(content: Text(AppStrings.changesSaved)),
      );
    }
  }

  Future<void> _delete(BuildContext context, SpaceItem item) async {
    final messenger = ScaffoldMessenger.of(context);
    final cubit = context.read<CatalogCubit>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(AppStrings.deleteItemTitle),
        content: Text(AppStrings.deleteItemMessage(item.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text(AppStrings.delete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await cubit.deleteItem(itemId);
    } on CatalogException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = this.item;
    if (item == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text(AppStrings.itemNotFound)),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: AppStrings.edit,
            onPressed: () => _edit(context, item),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: AppStrings.delete,
            onPressed: () => _delete(context, item),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SpaceItemCover(
                  item: item,
                  width: double.infinity,
                  height: 220,
                  borderRadius: 14,
                  letterSize: 96,
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: AnimatedLikeButton(
                    isLiked: isLiked,
                    onTap: () => _toggleLike(context),
                    size: 40,
                    iconSize: 22,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            if (item.subtitle.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                item.subtitle,
                style: const TextStyle(fontSize: 15, color: Colors.black54),
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(item.category.icon, size: 18),
                const SizedBox(width: 6),
                Text(item.category.label),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              AppStrings.description,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            item.description.isEmpty
                ? const Text(
                    AppStrings.noDescription,
                    style: TextStyle(color: Colors.black45),
                  )
                : Text(item.description),
            if (item.tags.isNotEmpty) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final tag in item.tags) SpaceItemTag(label: tag),
                ],
              ),
            ],
            if (item.createdAt != null) ...[
              const SizedBox(height: 16),
              Text(
                AppStrings.addedOn(_formatDate(item.createdAt!)),
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

String _formatDate(DateTime date) {
  final d = date.day.toString().padLeft(2, '0');
  final m = date.month.toString().padLeft(2, '0');
  return '$d.$m.${date.year}';
}
