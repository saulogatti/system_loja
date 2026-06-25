// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryState()';
}


}

/// @nodoc
class $CategoryStateCopyWith<$Res>  {
$CategoryStateCopyWith(CategoryState _, $Res Function(CategoryState) __);
}


/// Adds pattern-matching-related methods to [CategoryState].
extension CategoryStatePatterns on CategoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CategoryCreated value)?  created,TResult Function( CategoryDeleted value)?  deleted,TResult Function( CategoryError value)?  error,TResult Function( CategoryInitial value)?  initial,TResult Function( CategoryLoaded value)?  loaded,TResult Function( CategoryLoading value)?  loading,TResult Function( CategoryUpdated value)?  updated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CategoryCreated() when created != null:
return created(_that);case CategoryDeleted() when deleted != null:
return deleted(_that);case CategoryError() when error != null:
return error(_that);case CategoryInitial() when initial != null:
return initial(_that);case CategoryLoaded() when loaded != null:
return loaded(_that);case CategoryLoading() when loading != null:
return loading(_that);case CategoryUpdated() when updated != null:
return updated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CategoryCreated value)  created,required TResult Function( CategoryDeleted value)  deleted,required TResult Function( CategoryError value)  error,required TResult Function( CategoryInitial value)  initial,required TResult Function( CategoryLoaded value)  loaded,required TResult Function( CategoryLoading value)  loading,required TResult Function( CategoryUpdated value)  updated,}){
final _that = this;
switch (_that) {
case CategoryCreated():
return created(_that);case CategoryDeleted():
return deleted(_that);case CategoryError():
return error(_that);case CategoryInitial():
return initial(_that);case CategoryLoaded():
return loaded(_that);case CategoryLoading():
return loading(_that);case CategoryUpdated():
return updated(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CategoryCreated value)?  created,TResult? Function( CategoryDeleted value)?  deleted,TResult? Function( CategoryError value)?  error,TResult? Function( CategoryInitial value)?  initial,TResult? Function( CategoryLoaded value)?  loaded,TResult? Function( CategoryLoading value)?  loading,TResult? Function( CategoryUpdated value)?  updated,}){
final _that = this;
switch (_that) {
case CategoryCreated() when created != null:
return created(_that);case CategoryDeleted() when deleted != null:
return deleted(_that);case CategoryError() when error != null:
return error(_that);case CategoryInitial() when initial != null:
return initial(_that);case CategoryLoaded() when loaded != null:
return loaded(_that);case CategoryLoading() when loading != null:
return loading(_that);case CategoryUpdated() when updated != null:
return updated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<Category> categories)?  created,TResult Function( List<Category> categories)?  deleted,TResult Function( String message)?  error,TResult Function()?  initial,TResult Function( List<Category> categories)?  loaded,TResult Function()?  loading,TResult Function( List<Category> categories)?  updated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CategoryCreated() when created != null:
return created(_that.categories);case CategoryDeleted() when deleted != null:
return deleted(_that.categories);case CategoryError() when error != null:
return error(_that.message);case CategoryInitial() when initial != null:
return initial();case CategoryLoaded() when loaded != null:
return loaded(_that.categories);case CategoryLoading() when loading != null:
return loading();case CategoryUpdated() when updated != null:
return updated(_that.categories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<Category> categories)  created,required TResult Function( List<Category> categories)  deleted,required TResult Function( String message)  error,required TResult Function()  initial,required TResult Function( List<Category> categories)  loaded,required TResult Function()  loading,required TResult Function( List<Category> categories)  updated,}) {final _that = this;
switch (_that) {
case CategoryCreated():
return created(_that.categories);case CategoryDeleted():
return deleted(_that.categories);case CategoryError():
return error(_that.message);case CategoryInitial():
return initial();case CategoryLoaded():
return loaded(_that.categories);case CategoryLoading():
return loading();case CategoryUpdated():
return updated(_that.categories);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<Category> categories)?  created,TResult? Function( List<Category> categories)?  deleted,TResult? Function( String message)?  error,TResult? Function()?  initial,TResult? Function( List<Category> categories)?  loaded,TResult? Function()?  loading,TResult? Function( List<Category> categories)?  updated,}) {final _that = this;
switch (_that) {
case CategoryCreated() when created != null:
return created(_that.categories);case CategoryDeleted() when deleted != null:
return deleted(_that.categories);case CategoryError() when error != null:
return error(_that.message);case CategoryInitial() when initial != null:
return initial();case CategoryLoaded() when loaded != null:
return loaded(_that.categories);case CategoryLoading() when loading != null:
return loading();case CategoryUpdated() when updated != null:
return updated(_that.categories);case _:
  return null;

}
}

}

/// @nodoc


class CategoryCreated implements CategoryState {
  const CategoryCreated({required  List<Category> categories}): _categories = categories;
  

 final  List<Category> _categories;
 List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryCreatedCopyWith<CategoryCreated> get copyWith => _$CategoryCreatedCopyWithImpl<CategoryCreated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryCreated&&const DeepCollectionEquality().equals(other._categories, _categories));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'CategoryState.created(categories: $categories)';
}


}

/// @nodoc
abstract mixin class $CategoryCreatedCopyWith<$Res> implements $CategoryStateCopyWith<$Res> {
  factory $CategoryCreatedCopyWith(CategoryCreated value, $Res Function(CategoryCreated) _then) = _$CategoryCreatedCopyWithImpl;
@useResult
$Res call({
 List<Category> categories
});




}
/// @nodoc
class _$CategoryCreatedCopyWithImpl<$Res>
    implements $CategoryCreatedCopyWith<$Res> {
  _$CategoryCreatedCopyWithImpl(this._self, this._then);

  final CategoryCreated _self;
  final $Res Function(CategoryCreated) _then;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categories = null,}) {
  return _then(CategoryCreated(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,
  ));
}


}

/// @nodoc


class CategoryDeleted implements CategoryState {
  const CategoryDeleted({required  List<Category> categories}): _categories = categories;
  

 final  List<Category> _categories;
 List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryDeletedCopyWith<CategoryDeleted> get copyWith => _$CategoryDeletedCopyWithImpl<CategoryDeleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryDeleted&&const DeepCollectionEquality().equals(other._categories, _categories));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'CategoryState.deleted(categories: $categories)';
}


}

/// @nodoc
abstract mixin class $CategoryDeletedCopyWith<$Res> implements $CategoryStateCopyWith<$Res> {
  factory $CategoryDeletedCopyWith(CategoryDeleted value, $Res Function(CategoryDeleted) _then) = _$CategoryDeletedCopyWithImpl;
@useResult
$Res call({
 List<Category> categories
});




}
/// @nodoc
class _$CategoryDeletedCopyWithImpl<$Res>
    implements $CategoryDeletedCopyWith<$Res> {
  _$CategoryDeletedCopyWithImpl(this._self, this._then);

  final CategoryDeleted _self;
  final $Res Function(CategoryDeleted) _then;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categories = null,}) {
  return _then(CategoryDeleted(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,
  ));
}


}

/// @nodoc


class CategoryError implements CategoryState {
  const CategoryError({required this.message});
  

 final  String message;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryErrorCopyWith<CategoryError> get copyWith => _$CategoryErrorCopyWithImpl<CategoryError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CategoryState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CategoryErrorCopyWith<$Res> implements $CategoryStateCopyWith<$Res> {
  factory $CategoryErrorCopyWith(CategoryError value, $Res Function(CategoryError) _then) = _$CategoryErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CategoryErrorCopyWithImpl<$Res>
    implements $CategoryErrorCopyWith<$Res> {
  _$CategoryErrorCopyWithImpl(this._self, this._then);

  final CategoryError _self;
  final $Res Function(CategoryError) _then;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CategoryError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CategoryInitial implements CategoryState {
  const CategoryInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryState.initial()';
}


}




/// @nodoc


class CategoryLoaded implements CategoryState {
  const CategoryLoaded({required  List<Category> categories}): _categories = categories;
  

 final  List<Category> _categories;
 List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryLoadedCopyWith<CategoryLoaded> get copyWith => _$CategoryLoadedCopyWithImpl<CategoryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryLoaded&&const DeepCollectionEquality().equals(other._categories, _categories));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'CategoryState.loaded(categories: $categories)';
}


}

/// @nodoc
abstract mixin class $CategoryLoadedCopyWith<$Res> implements $CategoryStateCopyWith<$Res> {
  factory $CategoryLoadedCopyWith(CategoryLoaded value, $Res Function(CategoryLoaded) _then) = _$CategoryLoadedCopyWithImpl;
@useResult
$Res call({
 List<Category> categories
});




}
/// @nodoc
class _$CategoryLoadedCopyWithImpl<$Res>
    implements $CategoryLoadedCopyWith<$Res> {
  _$CategoryLoadedCopyWithImpl(this._self, this._then);

  final CategoryLoaded _self;
  final $Res Function(CategoryLoaded) _then;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categories = null,}) {
  return _then(CategoryLoaded(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,
  ));
}


}

/// @nodoc


class CategoryLoading implements CategoryState {
  const CategoryLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryState.loading()';
}


}




/// @nodoc


class CategoryUpdated implements CategoryState {
  const CategoryUpdated({required  List<Category> categories}): _categories = categories;
  

 final  List<Category> _categories;
 List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryUpdatedCopyWith<CategoryUpdated> get copyWith => _$CategoryUpdatedCopyWithImpl<CategoryUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryUpdated&&const DeepCollectionEquality().equals(other._categories, _categories));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'CategoryState.updated(categories: $categories)';
}


}

/// @nodoc
abstract mixin class $CategoryUpdatedCopyWith<$Res> implements $CategoryStateCopyWith<$Res> {
  factory $CategoryUpdatedCopyWith(CategoryUpdated value, $Res Function(CategoryUpdated) _then) = _$CategoryUpdatedCopyWithImpl;
@useResult
$Res call({
 List<Category> categories
});




}
/// @nodoc
class _$CategoryUpdatedCopyWithImpl<$Res>
    implements $CategoryUpdatedCopyWith<$Res> {
  _$CategoryUpdatedCopyWithImpl(this._self, this._then);

  final CategoryUpdated _self;
  final $Res Function(CategoryUpdated) _then;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categories = null,}) {
  return _then(CategoryUpdated(
categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,
  ));
}


}

// dart format on
