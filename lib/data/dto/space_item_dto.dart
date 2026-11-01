import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'space_item_dto.freezed.dart';
part 'space_item_dto.g.dart';

/// Преобразует Timestamp Firestore в DateTime, прочее в null.
class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Object? json) => json is Timestamp ? json.toDate() : null;

  @override
  Object? toJson(DateTime? object) => object;
}

/// Документ коллекции items в Firestore.
@freezed
abstract class SpaceItemDto with _$SpaceItemDto {
  const factory SpaceItemDto({
    required String title,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default('')
    String id,
    @Default('') String subtitle,
    String? category,
    @Default(<String>[]) List<String> tags,
    String? color,
    @Default('') String description,
    @TimestampConverter() @JsonKey(includeToJson: false) DateTime? createdAt,
  }) = _SpaceItemDto;

  factory SpaceItemDto.fromJson(Map<String, dynamic> json) =>
      _$SpaceItemDtoFromJson(json);
}
