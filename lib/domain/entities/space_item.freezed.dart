// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'space_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SpaceItem {

 String get id; String get title; String get subtitle; SpaceCategory get category; List<String> get tags; Color get color; String get description; DateTime? get createdAt;
/// Create a copy of SpaceItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpaceItemCopyWith<SpaceItem> get copyWith => _$SpaceItemCopyWithImpl<SpaceItem>(this as SpaceItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SpaceItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpaceItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.subtitle, _this.subtitle) || other.subtitle == _this.subtitle)&&(identical(other.category, _this.category) || other.category == _this.category)&&const DeepCollectionEquality().equals(other.tags, _this.tags)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as SpaceItem;
  return Object.hash(runtimeType,_this.id,_this.title,_this.subtitle,_this.category,const DeepCollectionEquality().hash(_this.tags),_this.color,_this.description,_this.createdAt);
}

@override
String toString() {
  final _this = this as SpaceItem;
  return 'SpaceItem(id: ${_this.id}, title: ${_this.title}, subtitle: ${_this.subtitle}, category: ${_this.category}, tags: ${_this.tags}, color: ${_this.color}, description: ${_this.description}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $SpaceItemCopyWith<$Res>  {
  factory $SpaceItemCopyWith(SpaceItem value, $Res Function(SpaceItem) _then) = _$SpaceItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, String subtitle, SpaceCategory category, List<String> tags, Color color, String description, DateTime? createdAt
});




}
/// @nodoc
class _$SpaceItemCopyWithImpl<$Res>
    implements $SpaceItemCopyWith<$Res> {
  _$SpaceItemCopyWithImpl(this._self, this._then);

  final SpaceItem _self;
  final $Res Function(SpaceItem) _then;

/// Create a copy of SpaceItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? category = null,Object? tags = null,Object? color = null,Object? description = null,Object? createdAt = freezed,}) {
  return _then(SpaceItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SpaceCategory,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SpaceItem].
extension SpaceItemPatterns on SpaceItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpaceItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpaceItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpaceItem value)  $default,){
final _that = this;
switch (_that) {
case _SpaceItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpaceItem value)?  $default,){
final _that = this;
switch (_that) {
case _SpaceItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String subtitle,  SpaceCategory category,  List<String> tags,  Color color,  String description,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpaceItem() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.category,_that.tags,_that.color,_that.description,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String subtitle,  SpaceCategory category,  List<String> tags,  Color color,  String description,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _SpaceItem():
return $default(_that.id,_that.title,_that.subtitle,_that.category,_that.tags,_that.color,_that.description,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String subtitle,  SpaceCategory category,  List<String> tags,  Color color,  String description,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SpaceItem() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.category,_that.tags,_that.color,_that.description,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _SpaceItem implements SpaceItem {
  const _SpaceItem({required this.id, required this.title, required this.subtitle, required this.category, required  List<String> tags, required this.color, required this.description, this.createdAt}): _tags = tags;
  

@override final  String id;
@override final  String title;
@override final  String subtitle;
@override final  SpaceCategory category;
 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  Color color;
@override final  String description;
@override final  DateTime? createdAt;

/// Create a copy of SpaceItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpaceItemCopyWith<_SpaceItem> get copyWith => __$SpaceItemCopyWithImpl<_SpaceItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpaceItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.tags, _tags)&&(identical(other.color, color) || other.color == color)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,subtitle,category,const DeepCollectionEquality().hash(_tags),color,description,createdAt);
}

@override
String toString() {
    return 'SpaceItem(id: $id, title: $title, subtitle: $subtitle, category: $category, tags: $tags, color: $color, description: $description, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SpaceItemCopyWith<$Res> implements $SpaceItemCopyWith<$Res> {
  factory _$SpaceItemCopyWith(_SpaceItem value, $Res Function(_SpaceItem) _then) = __$SpaceItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String subtitle, SpaceCategory category, List<String> tags, Color color, String description, DateTime? createdAt
});




}
/// @nodoc
class __$SpaceItemCopyWithImpl<$Res>
    implements _$SpaceItemCopyWith<$Res> {
  __$SpaceItemCopyWithImpl(this._self, this._then);

  final _SpaceItem _self;
  final $Res Function(_SpaceItem) _then;

/// Create a copy of SpaceItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? category = null,Object? tags = null,Object? color = null,Object? description = null,Object? createdAt = freezed,}) {
  return _then(_SpaceItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SpaceCategory,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
