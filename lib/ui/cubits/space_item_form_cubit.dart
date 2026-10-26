import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/catalog_repository.dart';
import '../../domain/entities/space_item.dart';
import 'space_item_form_state.dart';

/// Логика формы добавления и редактирования элемента каталога.
class SpaceItemFormCubit extends Cubit<SpaceItemFormState> {
  SpaceItemFormCubit({this.initial, required this.onSubmit})
    : super(
        SpaceItemFormState(category: initial?.category ?? SpaceCategory.planet),
      );

  final SpaceItem? initial;
  final Future<void> Function(SpaceItem item) onSubmit;

  bool get isEditing => initial != null;

  void selectCategory(SpaceCategory value) {
    emit(state.copyWith(category: value));
  }

  void titleChanged() {
    if (state.showTitleError) emit(state.copyWith(showTitleError: false));
  }

  Future<void> submit({
    required String title,
    required String subtitle,
    required String description,
  }) async {
    if (state.isSending) return;
    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      emit(state.copyWith(showTitleError: true));
      return;
    }
    emit(state.copyWith(isSending: true, clearSubmitError: true));
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
      if (!isClosed) emit(state.copyWith(isSending: false, saved: true));
    } on CatalogException catch (e) {
      if (isClosed) return;
      emit(state.copyWith(isSending: false, submitError: e.message));
    } catch (_) {
      if (!isClosed) emit(state.copyWith(isSending: false));
      rethrow;
    }
  }
}
