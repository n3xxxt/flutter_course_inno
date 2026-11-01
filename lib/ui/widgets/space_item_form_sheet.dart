import 'package:flutter/material.dart';

import '../../domain/entities/space_item.dart';
import 'space_item_form.dart';

/// Открывает форму элемента в bottom sheet; результат true при успешном сохранении.
Future<bool?> showSpaceItemSheet(
  BuildContext context, {
  SpaceItem? initial,
  required Future<void> Function(SpaceItem item) onSubmit,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SpaceItemForm(initial: initial, onSubmit: onSubmit),
      ),
    ),
  );
}
