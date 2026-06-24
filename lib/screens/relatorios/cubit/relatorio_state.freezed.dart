// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'relatorio_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RelatorioState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelatorioState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RelatorioState()';
}


}

/// @nodoc
class $RelatorioStateCopyWith<$Res>  {
$RelatorioStateCopyWith(RelatorioState _, $Res Function(RelatorioState) __);
}


/// Adds pattern-matching-related methods to [RelatorioState].
extension RelatorioStatePatterns on RelatorioState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RelatorioError value)?  error,TResult Function( RelatorioInitial value)?  initial,TResult Function( RelatorioLoaded value)?  loaded,TResult Function( RelatorioLoading value)?  loading,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RelatorioError() when error != null:
return error(_that);case RelatorioInitial() when initial != null:
return initial(_that);case RelatorioLoaded() when loaded != null:
return loaded(_that);case RelatorioLoading() when loading != null:
return loading(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RelatorioError value)  error,required TResult Function( RelatorioInitial value)  initial,required TResult Function( RelatorioLoaded value)  loaded,required TResult Function( RelatorioLoading value)  loading,}){
final _that = this;
switch (_that) {
case RelatorioError():
return error(_that);case RelatorioInitial():
return initial(_that);case RelatorioLoaded():
return loaded(_that);case RelatorioLoading():
return loading(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RelatorioError value)?  error,TResult? Function( RelatorioInitial value)?  initial,TResult? Function( RelatorioLoaded value)?  loaded,TResult? Function( RelatorioLoading value)?  loading,}){
final _that = this;
switch (_that) {
case RelatorioError() when error != null:
return error(_that);case RelatorioInitial() when initial != null:
return initial(_that);case RelatorioLoaded() when loaded != null:
return loaded(_that);case RelatorioLoading() when loading != null:
return loading(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  error,TResult Function()?  initial,TResult Function( Map<int, String> categoryNamesById,  Map<int, Invoice> entryInvoices,  Map<int, Invoice> exitInvoices,  List<Product> products,  RelatorioEstoqueOverviewData estoqueOverview,  RelatorioNotasOverviewData notasOverview,  ProductDetailsReportData? selectedProductDetails)?  loaded,TResult Function()?  loading,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RelatorioError() when error != null:
return error(_that.message);case RelatorioInitial() when initial != null:
return initial();case RelatorioLoaded() when loaded != null:
return loaded(_that.categoryNamesById,_that.entryInvoices,_that.exitInvoices,_that.products,_that.estoqueOverview,_that.notasOverview,_that.selectedProductDetails);case RelatorioLoading() when loading != null:
return loading();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  error,required TResult Function()  initial,required TResult Function( Map<int, String> categoryNamesById,  Map<int, Invoice> entryInvoices,  Map<int, Invoice> exitInvoices,  List<Product> products,  RelatorioEstoqueOverviewData estoqueOverview,  RelatorioNotasOverviewData notasOverview,  ProductDetailsReportData? selectedProductDetails)  loaded,required TResult Function()  loading,}) {final _that = this;
switch (_that) {
case RelatorioError():
return error(_that.message);case RelatorioInitial():
return initial();case RelatorioLoaded():
return loaded(_that.categoryNamesById,_that.entryInvoices,_that.exitInvoices,_that.products,_that.estoqueOverview,_that.notasOverview,_that.selectedProductDetails);case RelatorioLoading():
return loading();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  error,TResult? Function()?  initial,TResult? Function( Map<int, String> categoryNamesById,  Map<int, Invoice> entryInvoices,  Map<int, Invoice> exitInvoices,  List<Product> products,  RelatorioEstoqueOverviewData estoqueOverview,  RelatorioNotasOverviewData notasOverview,  ProductDetailsReportData? selectedProductDetails)?  loaded,TResult? Function()?  loading,}) {final _that = this;
switch (_that) {
case RelatorioError() when error != null:
return error(_that.message);case RelatorioInitial() when initial != null:
return initial();case RelatorioLoaded() when loaded != null:
return loaded(_that.categoryNamesById,_that.entryInvoices,_that.exitInvoices,_that.products,_that.estoqueOverview,_that.notasOverview,_that.selectedProductDetails);case RelatorioLoading() when loading != null:
return loading();case _:
  return null;

}
}

}

/// @nodoc


class RelatorioError implements RelatorioState {
   RelatorioError({required this.message});
  

 final  String message;

/// Create a copy of RelatorioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RelatorioErrorCopyWith<RelatorioError> get copyWith => _$RelatorioErrorCopyWithImpl<RelatorioError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelatorioError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RelatorioState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $RelatorioErrorCopyWith<$Res> implements $RelatorioStateCopyWith<$Res> {
  factory $RelatorioErrorCopyWith(RelatorioError value, $Res Function(RelatorioError) _then) = _$RelatorioErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RelatorioErrorCopyWithImpl<$Res>
    implements $RelatorioErrorCopyWith<$Res> {
  _$RelatorioErrorCopyWithImpl(this._self, this._then);

  final RelatorioError _self;
  final $Res Function(RelatorioError) _then;

/// Create a copy of RelatorioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(RelatorioError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RelatorioInitial implements RelatorioState {
   RelatorioInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelatorioInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RelatorioState.initial()';
}


}




/// @nodoc


class RelatorioLoaded implements RelatorioState {
   RelatorioLoaded({required  Map<int, String> categoryNamesById, required  Map<int, Invoice> entryInvoices, required  Map<int, Invoice> exitInvoices, required  List<Product> products, required this.estoqueOverview, required this.notasOverview, this.selectedProductDetails}): _categoryNamesById = categoryNamesById,_entryInvoices = entryInvoices,_exitInvoices = exitInvoices,_products = products;
  

 final  Map<int, String> _categoryNamesById;
 Map<int, String> get categoryNamesById {
  if (_categoryNamesById is EqualUnmodifiableMapView) return _categoryNamesById;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_categoryNamesById);
}

 final  Map<int, Invoice> _entryInvoices;
 Map<int, Invoice> get entryInvoices {
  if (_entryInvoices is EqualUnmodifiableMapView) return _entryInvoices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_entryInvoices);
}

 final  Map<int, Invoice> _exitInvoices;
 Map<int, Invoice> get exitInvoices {
  if (_exitInvoices is EqualUnmodifiableMapView) return _exitInvoices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_exitInvoices);
}

 final  List<Product> _products;
 List<Product> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  RelatorioEstoqueOverviewData estoqueOverview;
 final  RelatorioNotasOverviewData notasOverview;
 final  ProductDetailsReportData? selectedProductDetails;

/// Create a copy of RelatorioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RelatorioLoadedCopyWith<RelatorioLoaded> get copyWith => _$RelatorioLoadedCopyWithImpl<RelatorioLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelatorioLoaded&&const DeepCollectionEquality().equals(other._categoryNamesById, _categoryNamesById)&&const DeepCollectionEquality().equals(other._entryInvoices, _entryInvoices)&&const DeepCollectionEquality().equals(other._exitInvoices, _exitInvoices)&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.estoqueOverview, estoqueOverview) || other.estoqueOverview == estoqueOverview)&&(identical(other.notasOverview, notasOverview) || other.notasOverview == notasOverview)&&(identical(other.selectedProductDetails, selectedProductDetails) || other.selectedProductDetails == selectedProductDetails));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categoryNamesById),const DeepCollectionEquality().hash(_entryInvoices),const DeepCollectionEquality().hash(_exitInvoices),const DeepCollectionEquality().hash(_products),estoqueOverview,notasOverview,selectedProductDetails);

@override
String toString() {
  return 'RelatorioState.loaded(categoryNamesById: $categoryNamesById, entryInvoices: $entryInvoices, exitInvoices: $exitInvoices, products: $products, estoqueOverview: $estoqueOverview, notasOverview: $notasOverview, selectedProductDetails: $selectedProductDetails)';
}


}

/// @nodoc
abstract mixin class $RelatorioLoadedCopyWith<$Res> implements $RelatorioStateCopyWith<$Res> {
  factory $RelatorioLoadedCopyWith(RelatorioLoaded value, $Res Function(RelatorioLoaded) _then) = _$RelatorioLoadedCopyWithImpl;
@useResult
$Res call({
 Map<int, String> categoryNamesById, Map<int, Invoice> entryInvoices, Map<int, Invoice> exitInvoices, List<Product> products, RelatorioEstoqueOverviewData estoqueOverview, RelatorioNotasOverviewData notasOverview, ProductDetailsReportData? selectedProductDetails
});




}
/// @nodoc
class _$RelatorioLoadedCopyWithImpl<$Res>
    implements $RelatorioLoadedCopyWith<$Res> {
  _$RelatorioLoadedCopyWithImpl(this._self, this._then);

  final RelatorioLoaded _self;
  final $Res Function(RelatorioLoaded) _then;

/// Create a copy of RelatorioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categoryNamesById = null,Object? entryInvoices = null,Object? exitInvoices = null,Object? products = null,Object? estoqueOverview = null,Object? notasOverview = null,Object? selectedProductDetails = freezed,}) {
  return _then(RelatorioLoaded(
categoryNamesById: null == categoryNamesById ? _self._categoryNamesById : categoryNamesById // ignore: cast_nullable_to_non_nullable
as Map<int, String>,entryInvoices: null == entryInvoices ? _self._entryInvoices : entryInvoices // ignore: cast_nullable_to_non_nullable
as Map<int, Invoice>,exitInvoices: null == exitInvoices ? _self._exitInvoices : exitInvoices // ignore: cast_nullable_to_non_nullable
as Map<int, Invoice>,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,estoqueOverview: null == estoqueOverview ? _self.estoqueOverview : estoqueOverview // ignore: cast_nullable_to_non_nullable
as RelatorioEstoqueOverviewData,notasOverview: null == notasOverview ? _self.notasOverview : notasOverview // ignore: cast_nullable_to_non_nullable
as RelatorioNotasOverviewData,selectedProductDetails: freezed == selectedProductDetails ? _self.selectedProductDetails : selectedProductDetails // ignore: cast_nullable_to_non_nullable
as ProductDetailsReportData?,
  ));
}


}

/// @nodoc


class RelatorioLoading implements RelatorioState {
   RelatorioLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelatorioLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RelatorioState.loading()';
}


}




// dart format on
