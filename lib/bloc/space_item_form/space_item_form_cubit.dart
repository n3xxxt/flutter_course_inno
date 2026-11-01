import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/catalog_repository.dart';
import '../../domain/entities/space_item.dart';
import 'space_item_form_state.dart';

/// Логика формы добавления и редактирования элемента каталога.
class SpaceItemFormCubit extends Cubit<SpaceItemFormState> {
  SpaceItemFormCubit({this.initial, required this.onSubmit})
    : super(
        SpaceItemFormState(
          category: initial?.category ?? SpaceCategory.planet,
          isEditing: initial != null,
        ),
      );

  final SpaceItem? initial;
  final Future<void> Function(SpaceItem item) onSubmit;

  void selectCategory(SpaceCategory value) {
    _emit(state.copyWith(category: value));
  }

  void titleChanged(String value) {
    if (state.showTitleError) _emit(state.copyWith(showTitleError: false));
  }

  /// Возвращает true, если элемент успешно сохранён.
  Future<bool> submit({
    required String title,
    required String subtitle,
    required String description,
  }) async {
    if (state.isSending) return false;
    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      _emit(state.copyWith(showTitleError: true));
      return false;
    }
    _emit(state.copyWith(isSending: true, clearSubmitError: true));
    final trimmedSubtitle = subtitle.trim();
    final trimmedDescription = description.trim();
    final base = initial;
    final item = base == null
        ? SpaceItem.draft(
            title: trimmedTitle,
            subtitle: trimmedSubtitle,
            category: state.category,
            description: trimmedDescription,
          )
        : base.copyWith(
            title: trimmedTitle,
            subtitle: trimmedSubtitle,
            category: state.category,
            description: trimmedDescription,
          );
    try {
      await onSubmit(item);
      return true;
    } on CatalogException catch (e) {
      _emit(state.copyWith(submitError: e.message));
      return false;
    } finally {
      _emit(state.copyWith(isSending: false));
    }
  }

  void _emit(SpaceItemFormState value) {
    if (!isClosed) emit(value);
  }
}
