// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'space_item_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpaceItemDto {

 String get title;@JsonKey(includeFromJson: false, includeToJson: false) String get id; String get subtitle; String? get category; List<String> get tags; String? get color; String get description;@TimestampConverter()@JsonKey(includeToJson: false) DateTime? get createdAt;
/// Create a copy of SpaceItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpaceItemDtoCopyWith<SpaceItemDto> get copyWith => _$SpaceItemDtoCopyWithImpl<SpaceItemDto>(this as SpaceItemDto, _$identity);

  /// Serializes this SpaceItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SpaceItemDto;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpaceItemDto&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.category, _this.category) || other.category == _this.category)&&const DeepCollectionEquality().equals(other.tags, _this.tags)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SpaceItemDto;
  return Object.hash(runtimeType,_this.title,_this.id,_this.subtitle,_this.category,const DeepCollectionEquality().hash(_this.tags),_this.color,_this.description,_this.createdAt);
}

@override
String toString() {
  final _this = this as SpaceItemDto;
  return 'SpaceItemDto(title: ${_this.title}, id: ${_this.id}, subtitle: ${_this.subtitle}, category: ${_this.category}, tags: ${_this.tags}, color: ${_this.color}, description: ${_this.description}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $SpaceItemDtoCopyWith<$Res>  {
  factory $SpaceItemDtoCopyWith(SpaceItemDto value, $Res Function(SpaceItemDto) _then) = _$SpaceItemDtoCopyWithImpl;
@useResult
$Res call({
 String title,@JsonKey(includeFromJson: false, includeToJson: false) String id, String subtitle, String? category, List<String> tags, String? color, String description,@TimestampConverter()@JsonKey(includeToJson: false) DateTime? createdAt
});




}
/// @nodoc
class _$SpaceItemDtoCopyWithImpl<$Res>
    implements $SpaceItemDtoCopyWith<$Res> {
  _$SpaceItemDtoCopyWithImpl(this._self, this._then);

  final SpaceItemDto _self;
  final $Res Function(SpaceItemDto) _then;

/// Create a copy of SpaceItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? id = null,Object? subtitle = null,Object? category = freezed,Object? tags = null,Object? color = freezed,Object? description = null,Object? createdAt = freezed,}) {
  return _then(SpaceItemDto(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SpaceItemDto].
extension SpaceItemDtoPatterns on SpaceItemDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpaceItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpaceItemDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpaceItemDto value)  $default,){
final _that = this;
switch (_that) {
case _SpaceItemDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpaceItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _SpaceItemDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title, @JsonKey(includeFromJson: false, includeToJson: false)  String id,  String subtitle,  String? category,  List<String> tags,  String? color,  String description, @TimestampConverter()@JsonKey(includeToJson: false)  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpaceItemDto() when $default != null:
return $default(_that.title,_that.id,_that.subtitle,_that.category,_that.tags,_that.color,_that.description,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title, @JsonKey(includeFromJson: false, includeToJson: false)  String id,  String subtitle,  String? category,  List<String> tags,  String? color,  String description, @TimestampConverter()@JsonKey(includeToJson: false)  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _SpaceItemDto():
return $default(_that.title,_that.id,_that.subtitle,_that.category,_that.tags,_that.color,_that.description,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title, @JsonKey(includeFromJson: false, includeToJson: false)  String id,  String subtitle,  String? category,  List<String> tags,  String? color,  String description, @TimestampConverter()@JsonKey(includeToJson: false)  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SpaceItemDto() when $default != null:
return $default(_that.title,_that.id,_that.subtitle,_that.category,_that.tags,_that.color,_that.description,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpaceItemDto implements SpaceItemDto {
  const _SpaceItemDto({required this.title, @JsonKey(includeFromJson: false, includeToJson: false) this.id = '', this.subtitle = '', this.category,  List<String> tags = const <String>[], this.color, this.description = '', @TimestampConverter()@JsonKey(includeToJson: false) this.createdAt}): _tags = tags;
  factory _SpaceItemDto.fromJson(Map<String, dynamic> json) => _$SpaceItemDtoFromJson(json);

@override final  String title;
@override@JsonKey(includeFromJson: false, includeToJson: false) final  String id;
@override@JsonKey() final  String subtitle;
@override final  String? category;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String? color;
@override@JsonKey() final  String description;
@override@TimestampConverter()@JsonKey(includeToJson: false) final  DateTime? createdAt;

/// Create a copy of SpaceItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpaceItemDtoCopyWith<_SpaceItemDto> get copyWith => __$SpaceItemDtoCopyWithImpl<_SpaceItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpaceItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpaceItemDto&&(identical(other.title, title) || other.title == title)&&(identical(other.id, id) || other.id == id)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.tags, _tags)&&(identical(other.color, color) || other.color == color)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,title,id,subtitle,category,const DeepCollectionEquality().hash(_tags),color,description,createdAt);
}

@override
String toString() {
    return 'SpaceItemDto(title: $title, id: $id, subtitle: $subtitle, category: $category, tags: $tags, color: $color, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SpaceItemDtoCopyWith<$Res> implements $SpaceItemDtoCopyWith<$Res> {
  factory _$SpaceItemDtoCopyWith(_SpaceItemDto value, $Res Function(_SpaceItemDto) _then) = __$SpaceItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String title,@JsonKey(includeFromJson: false, includeToJson: false) String id, String subtitle, String? category, List<String> tags, String? color, String description,@TimestampConverter()@JsonKey(includeToJson: false) DateTime? createdAt
});




}
/// @nodoc
class __$SpaceItemDtoCopyWithImpl<$Res>
    implements _$SpaceItemDtoCopyWith<$Res> {
  __$SpaceItemDtoCopyWithImpl(this._self, this._then);

  final _SpaceItemDto _self;
  final $Res Function(_SpaceItemDto) _then;

/// Create a copy of SpaceItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? id = null,Object? subtitle = null,Object? category = freezed,Object? tags = null,Object? color = freezed,Object? description = null,Object? createdAt = freezed,}) {
  return _then(_SpaceItemDto(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
