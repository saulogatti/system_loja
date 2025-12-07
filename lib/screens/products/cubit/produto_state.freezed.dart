// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'produto_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProductStateFindByCodeFailure value)?  findByCodeFailure,TResult Function( ProductStateFindByCodeSuccess value)?  findByCodeSuccess,TResult Function( ProductStateFindByIdSuccess value)?  findByIdSuccess,TResult Function( ProductStateInsertSuccess value)?  insertSuccess,TResult Function( ProductStateNewIdGenerated value)?  newIdGenerated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProductStateFindByCodeFailure() when findByCodeFailure != null:
return findByCodeFailure(_that);case ProductStateFindByCodeSuccess() when findByCodeSuccess != null:
return findByCodeSuccess(_that);case ProductStateFindByIdSuccess() when findByIdSuccess != null:
return findByIdSuccess(_that);case ProductStateInsertSuccess() when insertSuccess != null:
return insertSuccess(_that);case ProductStateNewIdGenerated() when newIdGenerated != null:
return newIdGenerated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProductStateFindByCodeFailure value)  findByCodeFailure,required TResult Function( ProductStateFindByCodeSuccess value)  findByCodeSuccess,required TResult Function( ProductStateFindByIdSuccess value)  findByIdSuccess,required TResult Function( ProductStateInsertSuccess value)  insertSuccess,required TResult Function( ProductStateNewIdGenerated value)  newIdGenerated,}){
final _that = this;
switch (_that) {
case ProductStateFindByCodeFailure():
return findByCodeFailure(_that);case ProductStateFindByCodeSuccess():
return findByCodeSuccess(_that);case ProductStateFindByIdSuccess():
return findByIdSuccess(_that);case ProductStateInsertSuccess():
return insertSuccess(_that);case ProductStateNewIdGenerated():
return newIdGenerated(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProductStateFindByCodeFailure value)?  findByCodeFailure,TResult? Function( ProductStateFindByCodeSuccess value)?  findByCodeSuccess,TResult? Function( ProductStateFindByIdSuccess value)?  findByIdSuccess,TResult? Function( ProductStateInsertSuccess value)?  insertSuccess,TResult? Function( ProductStateNewIdGenerated value)?  newIdGenerated,}){
final _that = this;
switch (_that) {
case ProductStateFindByCodeFailure() when findByCodeFailure != null:
return findByCodeFailure(_that);case ProductStateFindByCodeSuccess() when findByCodeSuccess != null:
return findByCodeSuccess(_that);case ProductStateFindByIdSuccess() when findByIdSuccess != null:
return findByIdSuccess(_that);case ProductStateInsertSuccess() when insertSuccess != null:
return insertSuccess(_that);case ProductStateNewIdGenerated() when newIdGenerated != null:
return newIdGenerated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  findByCodeFailure,TResult Function( Produto produto)?  findByCodeSuccess,TResult Function( Produto produto)?  findByIdSuccess,TResult Function( List<Produto> produtos)?  insertSuccess,TResult Function( int newId)?  newIdGenerated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProductStateFindByCodeFailure() when findByCodeFailure != null:
return findByCodeFailure(_that.message);case ProductStateFindByCodeSuccess() when findByCodeSuccess != null:
return findByCodeSuccess(_that.produto);case ProductStateFindByIdSuccess() when findByIdSuccess != null:
return findByIdSuccess(_that.produto);case ProductStateInsertSuccess() when insertSuccess != null:
return insertSuccess(_that.produtos);case ProductStateNewIdGenerated() when newIdGenerated != null:
return newIdGenerated(_that.newId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  findByCodeFailure,required TResult Function( Produto produto)  findByCodeSuccess,required TResult Function( Produto produto)  findByIdSuccess,required TResult Function( List<Produto> produtos)  insertSuccess,required TResult Function( int newId)  newIdGenerated,}) {final _that = this;
switch (_that) {
case ProductStateFindByCodeFailure():
return findByCodeFailure(_that.message);case ProductStateFindByCodeSuccess():
return findByCodeSuccess(_that.produto);case ProductStateFindByIdSuccess():
return findByIdSuccess(_that.produto);case ProductStateInsertSuccess():
return insertSuccess(_that.produtos);case ProductStateNewIdGenerated():
return newIdGenerated(_that.newId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  findByCodeFailure,TResult? Function( Produto produto)?  findByCodeSuccess,TResult? Function( Produto produto)?  findByIdSuccess,TResult? Function( List<Produto> produtos)?  insertSuccess,TResult? Function( int newId)?  newIdGenerated,}) {final _that = this;
switch (_that) {
case ProductStateFindByCodeFailure() when findByCodeFailure != null:
return findByCodeFailure(_that.message);case ProductStateFindByCodeSuccess() when findByCodeSuccess != null:
return findByCodeSuccess(_that.produto);case ProductStateFindByIdSuccess() when findByIdSuccess != null:
return findByIdSuccess(_that.produto);case ProductStateInsertSuccess() when insertSuccess != null:
return insertSuccess(_that.produtos);case ProductStateNewIdGenerated() when newIdGenerated != null:
return newIdGenerated(_that.newId);case _:
  return null;

}
}

}

/// @nodoc


class ProductStateFindByCodeFailure implements ProductState {
   ProductStateFindByCodeFailure({required this.message});
  

 final  String message;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductStateFindByCodeFailureCopyWith<ProductStateFindByCodeFailure> get copyWith => _$ProductStateFindByCodeFailureCopyWithImpl<ProductStateFindByCodeFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductStateFindByCodeFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ProductState.findByCodeFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class $ProductStateFindByCodeFailureCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory $ProductStateFindByCodeFailureCopyWith(ProductStateFindByCodeFailure value, $Res Function(ProductStateFindByCodeFailure) _then) = _$ProductStateFindByCodeFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ProductStateFindByCodeFailureCopyWithImpl<$Res>
    implements $ProductStateFindByCodeFailureCopyWith<$Res> {
  _$ProductStateFindByCodeFailureCopyWithImpl(this._self, this._then);

  final ProductStateFindByCodeFailure _self;
  final $Res Function(ProductStateFindByCodeFailure) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ProductStateFindByCodeFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ProductStateFindByCodeSuccess implements ProductState {
   ProductStateFindByCodeSuccess({required this.produto});
  

 final  Produto produto;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductStateFindByCodeSuccessCopyWith<ProductStateFindByCodeSuccess> get copyWith => _$ProductStateFindByCodeSuccessCopyWithImpl<ProductStateFindByCodeSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductStateFindByCodeSuccess&&(identical(other.produto, produto) || other.produto == produto));
}


@override
int get hashCode => Object.hash(runtimeType,produto);

@override
String toString() {
  return 'ProductState.findByCodeSuccess(produto: $produto)';
}


}

/// @nodoc
abstract mixin class $ProductStateFindByCodeSuccessCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory $ProductStateFindByCodeSuccessCopyWith(ProductStateFindByCodeSuccess value, $Res Function(ProductStateFindByCodeSuccess) _then) = _$ProductStateFindByCodeSuccessCopyWithImpl;
@useResult
$Res call({
 Produto produto
});




}
/// @nodoc
class _$ProductStateFindByCodeSuccessCopyWithImpl<$Res>
    implements $ProductStateFindByCodeSuccessCopyWith<$Res> {
  _$ProductStateFindByCodeSuccessCopyWithImpl(this._self, this._then);

  final ProductStateFindByCodeSuccess _self;
  final $Res Function(ProductStateFindByCodeSuccess) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? produto = null,}) {
  return _then(ProductStateFindByCodeSuccess(
produto: null == produto ? _self.produto : produto // ignore: cast_nullable_to_non_nullable
as Produto,
  ));
}


}

/// @nodoc


class ProductStateFindByIdSuccess implements ProductState {
   ProductStateFindByIdSuccess({required this.produto});
  

 final  Produto produto;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductStateFindByIdSuccessCopyWith<ProductStateFindByIdSuccess> get copyWith => _$ProductStateFindByIdSuccessCopyWithImpl<ProductStateFindByIdSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductStateFindByIdSuccess&&(identical(other.produto, produto) || other.produto == produto));
}


@override
int get hashCode => Object.hash(runtimeType,produto);

@override
String toString() {
  return 'ProductState.findByIdSuccess(produto: $produto)';
}


}

/// @nodoc
abstract mixin class $ProductStateFindByIdSuccessCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory $ProductStateFindByIdSuccessCopyWith(ProductStateFindByIdSuccess value, $Res Function(ProductStateFindByIdSuccess) _then) = _$ProductStateFindByIdSuccessCopyWithImpl;
@useResult
$Res call({
 Produto produto
});




}
/// @nodoc
class _$ProductStateFindByIdSuccessCopyWithImpl<$Res>
    implements $ProductStateFindByIdSuccessCopyWith<$Res> {
  _$ProductStateFindByIdSuccessCopyWithImpl(this._self, this._then);

  final ProductStateFindByIdSuccess _self;
  final $Res Function(ProductStateFindByIdSuccess) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? produto = null,}) {
  return _then(ProductStateFindByIdSuccess(
produto: null == produto ? _self.produto : produto // ignore: cast_nullable_to_non_nullable
as Produto,
  ));
}


}

/// @nodoc


class ProductStateInsertSuccess implements ProductState {
   ProductStateInsertSuccess({required final  List<Produto> produtos}): _produtos = produtos;
  

 final  List<Produto> _produtos;
 List<Produto> get produtos {
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
 List<Produto> produtos
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
as List<Produto>,
  ));
}


}

/// @nodoc


class ProductStateNewIdGenerated implements ProductState {
   ProductStateNewIdGenerated({required this.newId});
  

 final  int newId;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductStateNewIdGeneratedCopyWith<ProductStateNewIdGenerated> get copyWith => _$ProductStateNewIdGeneratedCopyWithImpl<ProductStateNewIdGenerated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductStateNewIdGenerated&&(identical(other.newId, newId) || other.newId == newId));
}


@override
int get hashCode => Object.hash(runtimeType,newId);

@override
String toString() {
  return 'ProductState.newIdGenerated(newId: $newId)';
}


}

/// @nodoc
abstract mixin class $ProductStateNewIdGeneratedCopyWith<$Res> implements $ProductStateCopyWith<$Res> {
  factory $ProductStateNewIdGeneratedCopyWith(ProductStateNewIdGenerated value, $Res Function(ProductStateNewIdGenerated) _then) = _$ProductStateNewIdGeneratedCopyWithImpl;
@useResult
$Res call({
 int newId
});




}
/// @nodoc
class _$ProductStateNewIdGeneratedCopyWithImpl<$Res>
    implements $ProductStateNewIdGeneratedCopyWith<$Res> {
  _$ProductStateNewIdGeneratedCopyWithImpl(this._self, this._then);

  final ProductStateNewIdGenerated _self;
  final $Res Function(ProductStateNewIdGenerated) _then;

/// Create a copy of ProductState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? newId = null,}) {
  return _then(ProductStateNewIdGenerated(
newId: null == newId ? _self.newId : newId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
