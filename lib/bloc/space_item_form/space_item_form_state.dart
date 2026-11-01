import '../../domain/entities/space_item.dart';

/// Состояние формы добавления и редактирования элемента каталога.
class SpaceItemFormState {
  const SpaceItemFormState({
    required this.category,
    required this.isEditing,
    this.isSending = false,
    this.showTitleError = false,
    this.submitError,
  });

  final SpaceCategory category;
  final bool isEditing;
  final bool isSending;
  final bool showTitleError;
  final String? submitError;

  SpaceItemFormState copyWith({
    SpaceCategory? category,
    bool? isSending,
    bool? showTitleError,
    String? submitError,
    bool clearSubmitError = false,
  }) {
    return SpaceItemFormState(
      category: category ?? this.category,
      isEditing: isEditing,
      isSending: isSending ?? this.isSending,
      showTitleError: showTitleError ?? this.showTitleError,
      submitError: clearSubmitError ? null : (submitError ?? this.submitError),
    );
  }
}
