// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductState()';
}


}

/// @nodoc
class $ProductStateCopyWith<$Res>  {
$ProductStateCopyWith(ProductState _, $Res Function(ProductState) __);
}


/// Adds pattern-matching-related methods to [ProductState].
extension ProductStatePatterns on ProductState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProductStateDeleteSuccess value)?  deleteSuccess,TResult Function( ProductStateError value)?  error,TResult Function( ProductStateInsertSuccess value)?  insertSuccess,TResult Function( ProductStateLoading value)?  loading,TResult Function( ProductStateLoaded value)?  loaded,TResult Function( ProductStateUpdateSuccess value)?  updateSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProductStateDeleteSuccess() when deleteSuccess != null:
return deleteSuccess(_that);case ProductStateError() when error != null:
return error(_that);case ProductStateInsertSuccess() when insertSuccess != null:
return insertSuccess(_that);case ProductStateLoading() when loading != null:
return loading(_that);case ProductStateLoaded() when loaded != null:
return loaded(_that);case ProductStateUpdateSuccess() when updateSuccess != null:
return updateSuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProductStateDeleteSuccess value)  deleteSuccess,required TResult Function( ProductStateError value)  error,required TResult Function( ProductStateInsertSuccess value)  insertSuccess,required TResult Function( ProductStateLoading value)  loading,required TResult Function( ProductStateLoaded value)  loaded,required TResult Function( ProductStateUpdateSuccess value)  updateSuccess,}){
final _that = this;
switch (_that) {
case ProductStateDeleteSuccess():
return deleteSuccess(_that);case ProductStateError():
return error(_that);case ProductStateInsertSuccess():
return insertSuccess(_that);case ProductStateLoading():
return loading(_that);case ProductStateLoaded():
return loaded(_that);case ProductStateUpdateSuccess():
return updateSuccess(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProductStateDeleteSuccess value)?  deleteSuccess,TResult? Function( ProductStateError value)?  error,TResult? Function( ProductStateInsertSuccess value)?  insertSuccess,TResult? Function( ProductStateLoading value)?  loading,TResult? Function( ProductStateLoaded value)?  loaded,TResult? Function( ProductStateUpdateSuccess value)?  updateSuccess,}){
final _that = this;
switch (_that) {
case ProductStateDeleteSuccess() when deleteSuccess != null:
return deleteSuccess(_that);case ProductStateError() when error != null:
return error(_that);case ProductStateInsertSuccess() when insertSuccess != null:
return insertSuccess(_that);case ProductStateLoading() when loading != null:
return loading(_that);case ProductStateLoaded() when loaded != null:
return loaded(_that);case ProductStateUpdateSuccess() when updateSuccess != null:
return updateSuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<Product> produtos)?  deleteSuccess,TResult Function( String message)?  error,TResult Function( List<Product> produtos)?  insertSuccess,TResult Function()?  loading,TResult Function( List<Product> produtos)?  loaded,TResult Function( List<Product> produtos)?  updateSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProductStateDeleteSuccess() when deleteSuccess != null:
return deleteSuccess(_that.produtos);case ProductStateError() when error != null:
return error(_that.message);case ProductStateInsertSuccess() when insertSuccess != null:
return insertSuccess(_that.produtos);case ProductStateLoading() when loading != null:
return loading();case ProductStateLoaded() when loaded != null:
return loaded(_that.produtos);case ProductStateUpdateSuccess() when updateSuccess != null:
return updateSuccess(_that.produtos);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<Product> produtos)  deleteSuccess,required TResult Function( String message)  error,required TResult Function( List<Product> produtos)  insertSuccess,required TResult Function()  loading,required TResult Function( List<Product> produtos)  loaded,required TResult Function( List<Product> produtos)  updateSuccess,}) {final _that = this;
switch (_that) {
case ProductStateDeleteSuccess():
return deleteSuccess(_that.produtos);case ProductStateError():
return error(_that.message);case ProductStateInsertSuccess():
return insertSuccess(_that.produtos);case ProductStateLoading():
return loading();case ProductStateLoaded():
return loaded(_that.produtos);case ProductStateUpdateSuccess():
return updateSuccess(_that.produtos);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<Product> produtos)?  deleteSuccess,TResult? Function( String message)?  error,TResult? Function( List<Product> produtos)?  insertSuccess,TResult? Function()?  loading,TResult? Function( List<Product> produtos)?  loaded,TResult? Function( List<Product> produtos)?  updateSuccess,}) {final _that = this;
switch (_that) {
case ProductStateDeleteSuccess() when deleteSuccess != null:
return deleteSuccess(_that.produtos);case ProductStateError() when error != null:
return error(_that.message);case ProductStateInsertSuccess() when insertSuccess != null:
return insertSuccess(_that.produtos);case ProductStateLoading() when loading != null:
return loading();case ProductStateLoaded() when loaded != null:
return loaded(_that.produtos);case ProductStateUpdateSuccess() when updateSuccess != null:
return updateSuccess(_that.produtos);case _:
  return null;

}
}

}

/// @nodoc


class ProductStateDeleteSuccess implements ProductState {
   ProductStateDeleteSuccess({required  List<Product> produtos}): _produtos = produtos;
  

 final  List<Product> _produtos;
 List<Product> get produtos {
  if (_produtos is EqualUnmodifiableListView) return _produtos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_produtos);
}


/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductStateDeleteSuccessCopyWith<ProductStateDeleteSuccess> get copyWith => _$ProductStateDeleteSuccessCopyWithImpl<ProductStateDeleteSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductStateDeleteSuccess&&const DeepCollectionEquality().equals(other._produtos, _produtos));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_produtos));

@override
String toString() {
  return 'ProductState.deleteSuccess(produtos: $produtos)';
}


}

/// @nodoc
abstract mixin class $ProductStateDeleteSuccessCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory $ProductStateDeleteSuccessCopyWith(ProductStateDeleteSuccess value, $Res Function(ProductStateDeleteSuccess) _then) = _$ProductStateDeleteSuccessCopyWithImpl;
@useResult
$Res call({
 List<Product> produtos
});




}
/// @nodoc
class _$ProductStateDeleteSuccessCopyWithImpl<$Res>
    implements $ProductStateDeleteSuccessCopyWith<$Res> {
  _$ProductStateDeleteSuccessCopyWithImpl(this._self, this._then);

  final ProductStateDeleteSuccess _self;
  final $Res Function(ProductStateDeleteSuccess) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? produtos = null,}) {
  return _then(ProductStateDeleteSuccess(
produtos: null == produtos ? _self._produtos : produtos // ignore: cast_nullable_to_non_nullable
as List<Product>,
  ));
}


}

/// @nodoc


class ProductStateError implements ProductState {
   ProductStateError({required this.message});
  

 final  String message;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductStateErrorCopyWith<ProductStateError> get copyWith => _$ProductStateErrorCopyWithImpl<ProductStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ProductState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ProductStateErrorCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory $ProductStateErrorCopyWith(ProductStateError value, $Res Function(ProductStateError) _then) = _$ProductStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ProductStateErrorCopyWithImpl<$Res>
    implements $ProductStateErrorCopyWith<$Res> {
  _$ProductStateErrorCopyWithImpl(this._self, this._then);

  final ProductStateError _self;
  final $Res Function(ProductStateError) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ProductStateError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ProductStateInsertSuccess implements ProductState {
   ProductStateInsertSuccess({required  List<Product> produtos}): _produtos = produtos;
  

 final  List<Product> _produtos;
 List<Product> get produtos {
  if (_produtos is EqualUnmodifiableListView) return _produtos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_produtos);
}


/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductStateInsertSuccessCopyWith<ProductStateInsertSuccess> get copyWith => _$ProductStateInsertSuccessCopyWithImpl<ProductStateInsertSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductStateInsertSuccess&&const DeepCollectionEquality().equals(other._produtos, _produtos));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_produtos));

@override
String toString() {
  return 'ProductState.insertSuccess(produtos: $produtos)';
}


}

/// @nodoc
abstract mixin class $ProductStateInsertSuccessCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory $ProductStateInsertSuccessCopyWith(ProductStateInsertSuccess value, $Res Function(ProductStateInsertSuccess) _then) = _$ProductStateInsertSuccessCopyWithImpl;
@useResult
$Res call({
 List<Product> produtos
});




}
/// @nodoc
class _$ProductStateInsertSuccessCopyWithImpl<$Res>
    implements $ProductStateInsertSuccessCopyWith<$Res> {
  _$ProductStateInsertSuccessCopyWithImpl(this._self, this._then);

  final ProductStateInsertSuccess _self;
  final $Res Function(ProductStateInsertSuccess) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? produtos = null,}) {
  return _then(ProductStateInsertSuccess(
produtos: null == produtos ? _self._produtos : produtos // ignore: cast_nullable_to_non_nullable
as List<Product>,
  ));
}


}

/// @nodoc


class ProductStateLoading implements ProductState {
   ProductStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductState.loading()';
}


}




/// @nodoc


class ProductStateLoaded implements ProductState {
   ProductStateLoaded({required  List<Product> produtos}): _produtos = produtos;
  

 final  List<Product> _produtos;
 List<Product> get produtos {
  if (_produtos is EqualUnmodifiableListView) return _produtos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_produtos);
}


/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductStateLoadedCopyWith<ProductStateLoaded> get copyWith => _$ProductStateLoadedCopyWithImpl<ProductStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductStateLoaded&&const DeepCollectionEquality().equals(other._produtos, _produtos));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_produtos));

@override
String toString() {
  return 'ProductState.loaded(produtos: $produtos)';
}


}

/// @nodoc
abstract mixin class $ProductStateLoadedCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory $ProductStateLoadedCopyWith(ProductStateLoaded value, $Res Function(ProductStateLoaded) _then) = _$ProductStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<Product> produtos
});




}
/// @nodoc
class _$ProductStateLoadedCopyWithImpl<$Res>
    implements $ProductStateLoadedCopyWith<$Res> {
  _$ProductStateLoadedCopyWithImpl(this._self, this._then);

  final ProductStateLoaded _self;
  final $Res Function(ProductStateLoaded) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? produtos = null,}) {
  return _then(ProductStateLoaded(
produtos: null == produtos ? _self._produtos : produtos // ignore: cast_nullable_to_non_nullable
as List<Product>,
  ));
}


}

/// @nodoc


class ProductStateUpdateSuccess implements ProductState {
   ProductStateUpdateSuccess({required  List<Product> produtos}): _produtos = produtos;
  

 final  List<Product> _produtos;
 List<Product> get produtos {
  if (_produtos is EqualUnmodifiableListView) return _produtos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_produtos);
}


/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductStateUpdateSuccessCopyWith<ProductStateUpdateSuccess> get copyWith => _$ProductStateUpdateSuccessCopyWithImpl<ProductStateUpdateSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductStateUpdateSuccess&&const DeepCollectionEquality().equals(other._produtos, _produtos));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_produtos));

@override
String toString() {
  return 'ProductState.updateSuccess(produtos: $produtos)';
}


}

/// @nodoc
abstract mixin class $ProductStateUpdateSuccessCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory $ProductStateUpdateSuccessCopyWith(ProductStateUpdateSuccess value, $Res Function(ProductStateUpdateSuccess) _then) = _$ProductStateUpdateSuccessCopyWithImpl;
@useResult
$Res call({
 List<Product> produtos
});




}
/// @nodoc
class _$ProductStateUpdateSuccessCopyWithImpl<$Res>
    implements $ProductStateUpdateSuccessCopyWith<$Res> {
  _$ProductStateUpdateSuccessCopyWithImpl(this._self, this._then);

  final ProductStateUpdateSuccess _self;
  final $Res Function(ProductStateUpdateSuccess) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? produtos = null,}) {
  return _then(ProductStateUpdateSuccess(
produtos: null == produtos ? _self._produtos : produtos // ignore: cast_nullable_to_non_nullable
as List<Product>,
  ));
}


}

// dart format on
