// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SalesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SalesState()';
}


}

/// @nodoc
class $SalesStateCopyWith<$Res>  {
$SalesStateCopyWith(SalesState _, $Res Function(SalesState) __);
}


/// Adds pattern-matching-related methods to [SalesState].
extension SalesStatePatterns on SalesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SalesError value)?  error,TResult Function( SalesInitial value)?  initial,TResult Function( SalesLoaded value)?  loaded,TResult Function( SalesLoadedAll value)?  loadedAll,TResult Function( SalesLoadedCustomers value)?  loadedCustomers,TResult Function( SalesLoading value)?  loading,TResult Function( SalesLoadingProducts value)?  loadingProducts,TResult Function( SalesLoadProductsFailure value)?  loadProductsFailure,TResult Function( SalesSaved value)?  saved,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SalesError() when error != null:
return error(_that);case SalesInitial() when initial != null:
return initial(_that);case SalesLoaded() when loaded != null:
return loaded(_that);case SalesLoadedAll() when loadedAll != null:
return loadedAll(_that);case SalesLoadedCustomers() when loadedCustomers != null:
return loadedCustomers(_that);case SalesLoading() when loading != null:
return loading(_that);case SalesLoadingProducts() when loadingProducts != null:
return loadingProducts(_that);case SalesLoadProductsFailure() when loadProductsFailure != null:
return loadProductsFailure(_that);case SalesSaved() when saved != null:
return saved(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SalesError value)  error,required TResult Function( SalesInitial value)  initial,required TResult Function( SalesLoaded value)  loaded,required TResult Function( SalesLoadedAll value)  loadedAll,required TResult Function( SalesLoadedCustomers value)  loadedCustomers,required TResult Function( SalesLoading value)  loading,required TResult Function( SalesLoadingProducts value)  loadingProducts,required TResult Function( SalesLoadProductsFailure value)  loadProductsFailure,required TResult Function( SalesSaved value)  saved,}){
final _that = this;
switch (_that) {
case SalesError():
return error(_that);case SalesInitial():
return initial(_that);case SalesLoaded():
return loaded(_that);case SalesLoadedAll():
return loadedAll(_that);case SalesLoadedCustomers():
return loadedCustomers(_that);case SalesLoading():
return loading(_that);case SalesLoadingProducts():
return loadingProducts(_that);case SalesLoadProductsFailure():
return loadProductsFailure(_that);case SalesSaved():
return saved(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SalesError value)?  error,TResult? Function( SalesInitial value)?  initial,TResult? Function( SalesLoaded value)?  loaded,TResult? Function( SalesLoadedAll value)?  loadedAll,TResult? Function( SalesLoadedCustomers value)?  loadedCustomers,TResult? Function( SalesLoading value)?  loading,TResult? Function( SalesLoadingProducts value)?  loadingProducts,TResult? Function( SalesLoadProductsFailure value)?  loadProductsFailure,TResult? Function( SalesSaved value)?  saved,}){
final _that = this;
switch (_that) {
case SalesError() when error != null:
return error(_that);case SalesInitial() when initial != null:
return initial(_that);case SalesLoaded() when loaded != null:
return loaded(_that);case SalesLoadedAll() when loadedAll != null:
return loadedAll(_that);case SalesLoadedCustomers() when loadedCustomers != null:
return loadedCustomers(_that);case SalesLoading() when loading != null:
return loading(_that);case SalesLoadingProducts() when loadingProducts != null:
return loadingProducts(_that);case SalesLoadProductsFailure() when loadProductsFailure != null:
return loadProductsFailure(_that);case SalesSaved() when saved != null:
return saved(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  error,TResult Function()?  initial,TResult Function( Map<int, Invoice> items)?  loaded,TResult Function( List<Product> products,  List<PaymentMethodType> paymentMethods,  Map<int, Customer> customers,  Map<int, Company> companies,  Map<int, Invoice> invoices)?  loadedAll,TResult Function( Map<int, Customer> customers)?  loadedCustomers,TResult Function()?  loading,TResult Function()?  loadingProducts,TResult Function( String message)?  loadProductsFailure,TResult Function( Map<int, Invoice> items)?  saved,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SalesError() when error != null:
return error(_that.message);case SalesInitial() when initial != null:
return initial();case SalesLoaded() when loaded != null:
return loaded(_that.items);case SalesLoadedAll() when loadedAll != null:
return loadedAll(_that.products,_that.paymentMethods,_that.customers,_that.companies,_that.invoices);case SalesLoadedCustomers() when loadedCustomers != null:
return loadedCustomers(_that.customers);case SalesLoading() when loading != null:
return loading();case SalesLoadingProducts() when loadingProducts != null:
return loadingProducts();case SalesLoadProductsFailure() when loadProductsFailure != null:
return loadProductsFailure(_that.message);case SalesSaved() when saved != null:
return saved(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  error,required TResult Function()  initial,required TResult Function( Map<int, Invoice> items)  loaded,required TResult Function( List<Product> products,  List<PaymentMethodType> paymentMethods,  Map<int, Customer> customers,  Map<int, Company> companies,  Map<int, Invoice> invoices)  loadedAll,required TResult Function( Map<int, Customer> customers)  loadedCustomers,required TResult Function()  loading,required TResult Function()  loadingProducts,required TResult Function( String message)  loadProductsFailure,required TResult Function( Map<int, Invoice> items)  saved,}) {final _that = this;
switch (_that) {
case SalesError():
return error(_that.message);case SalesInitial():
return initial();case SalesLoaded():
return loaded(_that.items);case SalesLoadedAll():
return loadedAll(_that.products,_that.paymentMethods,_that.customers,_that.companies,_that.invoices);case SalesLoadedCustomers():
return loadedCustomers(_that.customers);case SalesLoading():
return loading();case SalesLoadingProducts():
return loadingProducts();case SalesLoadProductsFailure():
return loadProductsFailure(_that.message);case SalesSaved():
return saved(_that.items);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  error,TResult? Function()?  initial,TResult? Function( Map<int, Invoice> items)?  loaded,TResult? Function( List<Product> products,  List<PaymentMethodType> paymentMethods,  Map<int, Customer> customers,  Map<int, Company> companies,  Map<int, Invoice> invoices)?  loadedAll,TResult? Function( Map<int, Customer> customers)?  loadedCustomers,TResult? Function()?  loading,TResult? Function()?  loadingProducts,TResult? Function( String message)?  loadProductsFailure,TResult? Function( Map<int, Invoice> items)?  saved,}) {final _that = this;
switch (_that) {
case SalesError() when error != null:
return error(_that.message);case SalesInitial() when initial != null:
return initial();case SalesLoaded() when loaded != null:
return loaded(_that.items);case SalesLoadedAll() when loadedAll != null:
return loadedAll(_that.products,_that.paymentMethods,_that.customers,_that.companies,_that.invoices);case SalesLoadedCustomers() when loadedCustomers != null:
return loadedCustomers(_that.customers);case SalesLoading() when loading != null:
return loading();case SalesLoadingProducts() when loadingProducts != null:
return loadingProducts();case SalesLoadProductsFailure() when loadProductsFailure != null:
return loadProductsFailure(_that.message);case SalesSaved() when saved != null:
return saved(_that.items);case _:
  return null;

}
}

}

/// @nodoc


class SalesError implements SalesState {
   SalesError({required this.message});
  

 final  String message;

/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesErrorCopyWith<SalesError> get copyWith => _$SalesErrorCopyWithImpl<SalesError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SalesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SalesErrorCopyWith<$Res> implements $SalesStateCopyWith<$Res> {
  factory $SalesErrorCopyWith(SalesError value, $Res Function(SalesError) _then) = _$SalesErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SalesErrorCopyWithImpl<$Res>
    implements $SalesErrorCopyWith<$Res> {
  _$SalesErrorCopyWithImpl(this._self, this._then);

  final SalesError _self;
  final $Res Function(SalesError) _then;

/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SalesError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SalesInitial implements SalesState {
   SalesInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SalesState.initial()';
}


}




/// @nodoc


class SalesLoaded implements SalesState {
   SalesLoaded({required final  Map<int, Invoice> items}): _items = items;
  

 final  Map<int, Invoice> _items;
 Map<int, Invoice> get items {
  if (_items is EqualUnmodifiableMapView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_items);
}


/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesLoadedCopyWith<SalesLoaded> get copyWith => _$SalesLoadedCopyWithImpl<SalesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesLoaded&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'SalesState.loaded(items: $items)';
}


}

/// @nodoc
abstract mixin class $SalesLoadedCopyWith<$Res> implements $SalesStateCopyWith<$Res> {
  factory $SalesLoadedCopyWith(SalesLoaded value, $Res Function(SalesLoaded) _then) = _$SalesLoadedCopyWithImpl;
@useResult
$Res call({
 Map<int, Invoice> items
});




}
/// @nodoc
class _$SalesLoadedCopyWithImpl<$Res>
    implements $SalesLoadedCopyWith<$Res> {
  _$SalesLoadedCopyWithImpl(this._self, this._then);

  final SalesLoaded _self;
  final $Res Function(SalesLoaded) _then;

/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(SalesLoaded(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as Map<int, Invoice>,
  ));
}


}

/// @nodoc


class SalesLoadedAll implements SalesState {
   SalesLoadedAll({required final  List<Product> products, required final  List<PaymentMethodType> paymentMethods, required final  Map<int, Customer> customers, required final  Map<int, Company> companies, required final  Map<int, Invoice> invoices}): _products = products,_paymentMethods = paymentMethods,_customers = customers,_companies = companies,_invoices = invoices;
  

 final  List<Product> _products;
 List<Product> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  List<PaymentMethodType> _paymentMethods;
 List<PaymentMethodType> get paymentMethods {
  if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paymentMethods);
}

 final  Map<int, Customer> _customers;
 Map<int, Customer> get customers {
  if (_customers is EqualUnmodifiableMapView) return _customers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_customers);
}

 final  Map<int, Company> _companies;
 Map<int, Company> get companies {
  if (_companies is EqualUnmodifiableMapView) return _companies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_companies);
}

 final  Map<int, Invoice> _invoices;
 Map<int, Invoice> get invoices {
  if (_invoices is EqualUnmodifiableMapView) return _invoices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_invoices);
}


/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesLoadedAllCopyWith<SalesLoadedAll> get copyWith => _$SalesLoadedAllCopyWithImpl<SalesLoadedAll>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesLoadedAll&&const DeepCollectionEquality().equals(other._products, _products)&&const DeepCollectionEquality().equals(other._paymentMethods, _paymentMethods)&&const DeepCollectionEquality().equals(other._customers, _customers)&&const DeepCollectionEquality().equals(other._companies, _companies)&&const DeepCollectionEquality().equals(other._invoices, _invoices));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_paymentMethods),const DeepCollectionEquality().hash(_customers),const DeepCollectionEquality().hash(_companies),const DeepCollectionEquality().hash(_invoices));

@override
String toString() {
  return 'SalesState.loadedAll(products: $products, paymentMethods: $paymentMethods, customers: $customers, companies: $companies, invoices: $invoices)';
}


}

/// @nodoc
abstract mixin class $SalesLoadedAllCopyWith<$Res> implements $SalesStateCopyWith<$Res> {
  factory $SalesLoadedAllCopyWith(SalesLoadedAll value, $Res Function(SalesLoadedAll) _then) = _$SalesLoadedAllCopyWithImpl;
@useResult
$Res call({
 List<Product> products, List<PaymentMethodType> paymentMethods, Map<int, Customer> customers, Map<int, Company> companies, Map<int, Invoice> invoices
});




}
/// @nodoc
class _$SalesLoadedAllCopyWithImpl<$Res>
    implements $SalesLoadedAllCopyWith<$Res> {
  _$SalesLoadedAllCopyWithImpl(this._self, this._then);

  final SalesLoadedAll _self;
  final $Res Function(SalesLoadedAll) _then;

/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? products = null,Object? paymentMethods = null,Object? customers = null,Object? companies = null,Object? invoices = null,}) {
  return _then(SalesLoadedAll(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,paymentMethods: null == paymentMethods ? _self._paymentMethods : paymentMethods // ignore: cast_nullable_to_non_nullable
as List<PaymentMethodType>,customers: null == customers ? _self._customers : customers // ignore: cast_nullable_to_non_nullable
as Map<int, Customer>,companies: null == companies ? _self._companies : companies // ignore: cast_nullable_to_non_nullable
as Map<int, Company>,invoices: null == invoices ? _self._invoices : invoices // ignore: cast_nullable_to_non_nullable
as Map<int, Invoice>,
  ));
}


}

/// @nodoc


class SalesLoadedCustomers implements SalesState {
   SalesLoadedCustomers({required final  Map<int, Customer> customers}): _customers = customers;
  

 final  Map<int, Customer> _customers;
 Map<int, Customer> get customers {
  if (_customers is EqualUnmodifiableMapView) return _customers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_customers);
}


/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesLoadedCustomersCopyWith<SalesLoadedCustomers> get copyWith => _$SalesLoadedCustomersCopyWithImpl<SalesLoadedCustomers>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesLoadedCustomers&&const DeepCollectionEquality().equals(other._customers, _customers));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_customers));

@override
String toString() {
  return 'SalesState.loadedCustomers(customers: $customers)';
}


}

/// @nodoc
abstract mixin class $SalesLoadedCustomersCopyWith<$Res> implements $SalesStateCopyWith<$Res> {
  factory $SalesLoadedCustomersCopyWith(SalesLoadedCustomers value, $Res Function(SalesLoadedCustomers) _then) = _$SalesLoadedCustomersCopyWithImpl;
@useResult
$Res call({
 Map<int, Customer> customers
});




}
/// @nodoc
class _$SalesLoadedCustomersCopyWithImpl<$Res>
    implements $SalesLoadedCustomersCopyWith<$Res> {
  _$SalesLoadedCustomersCopyWithImpl(this._self, this._then);

  final SalesLoadedCustomers _self;
  final $Res Function(SalesLoadedCustomers) _then;

/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customers = null,}) {
  return _then(SalesLoadedCustomers(
customers: null == customers ? _self._customers : customers // ignore: cast_nullable_to_non_nullable
as Map<int, Customer>,
  ));
}


}

/// @nodoc


class SalesLoading implements SalesState {
   SalesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SalesState.loading()';
}


}




/// @nodoc


class SalesLoadingProducts implements SalesState {
   SalesLoadingProducts();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesLoadingProducts);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SalesState.loadingProducts()';
}


}




/// @nodoc


class SalesLoadProductsFailure implements SalesState {
   SalesLoadProductsFailure({required this.message});
  

 final  String message;

/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesLoadProductsFailureCopyWith<SalesLoadProductsFailure> get copyWith => _$SalesLoadProductsFailureCopyWithImpl<SalesLoadProductsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesLoadProductsFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SalesState.loadProductsFailure(message: $message)';
}


}

/// @nodoc
abstract mixin class $SalesLoadProductsFailureCopyWith<$Res> implements $SalesStateCopyWith<$Res> {
  factory $SalesLoadProductsFailureCopyWith(SalesLoadProductsFailure value, $Res Function(SalesLoadProductsFailure) _then) = _$SalesLoadProductsFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SalesLoadProductsFailureCopyWithImpl<$Res>
    implements $SalesLoadProductsFailureCopyWith<$Res> {
  _$SalesLoadProductsFailureCopyWithImpl(this._self, this._then);

  final SalesLoadProductsFailure _self;
  final $Res Function(SalesLoadProductsFailure) _then;

/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SalesLoadProductsFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SalesSaved implements SalesState {
   SalesSaved({required final  Map<int, Invoice> items}): _items = items;
  

 final  Map<int, Invoice> _items;
 Map<int, Invoice> get items {
  if (_items is EqualUnmodifiableMapView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_items);
}


/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesSavedCopyWith<SalesSaved> get copyWith => _$SalesSavedCopyWithImpl<SalesSaved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesSaved&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'SalesState.saved(items: $items)';
}


}

/// @nodoc
abstract mixin class $SalesSavedCopyWith<$Res> implements $SalesStateCopyWith<$Res> {
  factory $SalesSavedCopyWith(SalesSaved value, $Res Function(SalesSaved) _then) = _$SalesSavedCopyWithImpl;
@useResult
$Res call({
 Map<int, Invoice> items
});




}
/// @nodoc
class _$SalesSavedCopyWithImpl<$Res>
    implements $SalesSavedCopyWith<$Res> {
  _$SalesSavedCopyWithImpl(this._self, this._then);

  final SalesSaved _self;
  final $Res Function(SalesSaved) _then;

/// Create a copy of SalesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(SalesSaved(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as Map<int, Invoice>,
  ));
}


}

// dart format on
