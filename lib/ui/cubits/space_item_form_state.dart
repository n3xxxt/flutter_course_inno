import '../../domain/entities/space_item.dart';

/// Состояние формы добавления и редактирования элемента каталога.
class SpaceItemFormState {
  const SpaceItemFormState({
    required this.category,
    this.isSending = false,
    this.showTitleError = false,
    this.submitError,
    this.saved = false,
  });

  final SpaceCategory category;
  final bool isSending;
  final bool showTitleError;
  final String? submitError;
  final bool saved;

  SpaceItemFormState copyWith({
    SpaceCategory? category,
    bool? isSending,
    bool? showTitleError,
    String? submitError,
    bool clearSubmitError = false,
    bool? saved,
  }) {
    return SpaceItemFormState(
      category: category ?? this.category,
      isSending: isSending ?? this.isSending,
      showTitleError: showTitleError ?? this.showTitleError,
      submitError: clearSubmitError ? null : (submitError ?? this.submitError),
      saved: saved ?? this.saved,
    );
  }
}
