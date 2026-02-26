// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SalesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function(Map<int, Invoice> items) loaded,
    required TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)
        loadedAll,
    required TResult Function(Map<int, Customer> customers) loadedCustomers,
    required TResult Function() loading,
    required TResult Function() loadingProducts,
    required TResult Function(String message) loadProductsFailure,
    required TResult Function(Map<int, Invoice> items) saved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? initial,
    TResult? Function(Map<int, Invoice> items)? loaded,
    TResult? Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult? Function(Map<int, Customer> customers)? loadedCustomers,
    TResult? Function()? loading,
    TResult? Function()? loadingProducts,
    TResult? Function(String message)? loadProductsFailure,
    TResult? Function(Map<int, Invoice> items)? saved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function(Map<int, Invoice> items)? loaded,
    TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult Function(Map<int, Customer> customers)? loadedCustomers,
    TResult Function()? loading,
    TResult Function()? loadingProducts,
    TResult Function(String message)? loadProductsFailure,
    TResult Function(Map<int, Invoice> items)? saved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SalesError value) error,
    required TResult Function(SalesInitial value) initial,
    required TResult Function(SalesLoaded value) loaded,
    required TResult Function(SalesLoadedAll value) loadedAll,
    required TResult Function(SalesLoadedCustomers value) loadedCustomers,
    required TResult Function(SalesLoading value) loading,
    required TResult Function(SalesLoadingProducts value) loadingProducts,
    required TResult Function(SalesLoadProductsFailure value)
        loadProductsFailure,
    required TResult Function(SalesSaved value) saved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SalesError value)? error,
    TResult? Function(SalesInitial value)? initial,
    TResult? Function(SalesLoaded value)? loaded,
    TResult? Function(SalesLoadedAll value)? loadedAll,
    TResult? Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult? Function(SalesLoading value)? loading,
    TResult? Function(SalesLoadingProducts value)? loadingProducts,
    TResult? Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult? Function(SalesSaved value)? saved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SalesError value)? error,
    TResult Function(SalesInitial value)? initial,
    TResult Function(SalesLoaded value)? loaded,
    TResult Function(SalesLoadedAll value)? loadedAll,
    TResult Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult Function(SalesLoading value)? loading,
    TResult Function(SalesLoadingProducts value)? loadingProducts,
    TResult Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult Function(SalesSaved value)? saved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalesStateCopyWith<$Res> {
  factory $SalesStateCopyWith(
          SalesState value, $Res Function(SalesState) then) =
      _$SalesStateCopyWithImpl<$Res, SalesState>;
}

/// @nodoc
class _$SalesStateCopyWithImpl<$Res, $Val extends SalesState>
    implements $SalesStateCopyWith<$Res> {
  _$SalesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SalesErrorImplCopyWith<$Res> {
  factory _$$SalesErrorImplCopyWith(
          _$SalesErrorImpl value, $Res Function(_$SalesErrorImpl) then) =
      __$$SalesErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SalesErrorImplCopyWithImpl<$Res>
    extends _$SalesStateCopyWithImpl<$Res, _$SalesErrorImpl>
    implements _$$SalesErrorImplCopyWith<$Res> {
  __$$SalesErrorImplCopyWithImpl(
      _$SalesErrorImpl _value, $Res Function(_$SalesErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SalesErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SalesErrorImpl implements SalesError {
  _$SalesErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'SalesState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesErrorImplCopyWith<_$SalesErrorImpl> get copyWith =>
      __$$SalesErrorImplCopyWithImpl<_$SalesErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function(Map<int, Invoice> items) loaded,
    required TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)
        loadedAll,
    required TResult Function(Map<int, Customer> customers) loadedCustomers,
    required TResult Function() loading,
    required TResult Function() loadingProducts,
    required TResult Function(String message) loadProductsFailure,
    required TResult Function(Map<int, Invoice> items) saved,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? initial,
    TResult? Function(Map<int, Invoice> items)? loaded,
    TResult? Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult? Function(Map<int, Customer> customers)? loadedCustomers,
    TResult? Function()? loading,
    TResult? Function()? loadingProducts,
    TResult? Function(String message)? loadProductsFailure,
    TResult? Function(Map<int, Invoice> items)? saved,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function(Map<int, Invoice> items)? loaded,
    TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult Function(Map<int, Customer> customers)? loadedCustomers,
    TResult Function()? loading,
    TResult Function()? loadingProducts,
    TResult Function(String message)? loadProductsFailure,
    TResult Function(Map<int, Invoice> items)? saved,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SalesError value) error,
    required TResult Function(SalesInitial value) initial,
    required TResult Function(SalesLoaded value) loaded,
    required TResult Function(SalesLoadedAll value) loadedAll,
    required TResult Function(SalesLoadedCustomers value) loadedCustomers,
    required TResult Function(SalesLoading value) loading,
    required TResult Function(SalesLoadingProducts value) loadingProducts,
    required TResult Function(SalesLoadProductsFailure value)
        loadProductsFailure,
    required TResult Function(SalesSaved value) saved,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SalesError value)? error,
    TResult? Function(SalesInitial value)? initial,
    TResult? Function(SalesLoaded value)? loaded,
    TResult? Function(SalesLoadedAll value)? loadedAll,
    TResult? Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult? Function(SalesLoading value)? loading,
    TResult? Function(SalesLoadingProducts value)? loadingProducts,
    TResult? Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult? Function(SalesSaved value)? saved,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SalesError value)? error,
    TResult Function(SalesInitial value)? initial,
    TResult Function(SalesLoaded value)? loaded,
    TResult Function(SalesLoadedAll value)? loadedAll,
    TResult Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult Function(SalesLoading value)? loading,
    TResult Function(SalesLoadingProducts value)? loadingProducts,
    TResult Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult Function(SalesSaved value)? saved,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SalesError implements SalesState {
  factory SalesError({required final String message}) = _$SalesErrorImpl;

  String get message;

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesErrorImplCopyWith<_$SalesErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SalesInitialImplCopyWith<$Res> {
  factory _$$SalesInitialImplCopyWith(
          _$SalesInitialImpl value, $Res Function(_$SalesInitialImpl) then) =
      __$$SalesInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SalesInitialImplCopyWithImpl<$Res>
    extends _$SalesStateCopyWithImpl<$Res, _$SalesInitialImpl>
    implements _$$SalesInitialImplCopyWith<$Res> {
  __$$SalesInitialImplCopyWithImpl(
      _$SalesInitialImpl _value, $Res Function(_$SalesInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SalesInitialImpl implements SalesInitial {
  _$SalesInitialImpl();

  @override
  String toString() {
    return 'SalesState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SalesInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function(Map<int, Invoice> items) loaded,
    required TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)
        loadedAll,
    required TResult Function(Map<int, Customer> customers) loadedCustomers,
    required TResult Function() loading,
    required TResult Function() loadingProducts,
    required TResult Function(String message) loadProductsFailure,
    required TResult Function(Map<int, Invoice> items) saved,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? initial,
    TResult? Function(Map<int, Invoice> items)? loaded,
    TResult? Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult? Function(Map<int, Customer> customers)? loadedCustomers,
    TResult? Function()? loading,
    TResult? Function()? loadingProducts,
    TResult? Function(String message)? loadProductsFailure,
    TResult? Function(Map<int, Invoice> items)? saved,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function(Map<int, Invoice> items)? loaded,
    TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult Function(Map<int, Customer> customers)? loadedCustomers,
    TResult Function()? loading,
    TResult Function()? loadingProducts,
    TResult Function(String message)? loadProductsFailure,
    TResult Function(Map<int, Invoice> items)? saved,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SalesError value) error,
    required TResult Function(SalesInitial value) initial,
    required TResult Function(SalesLoaded value) loaded,
    required TResult Function(SalesLoadedAll value) loadedAll,
    required TResult Function(SalesLoadedCustomers value) loadedCustomers,
    required TResult Function(SalesLoading value) loading,
    required TResult Function(SalesLoadingProducts value) loadingProducts,
    required TResult Function(SalesLoadProductsFailure value)
        loadProductsFailure,
    required TResult Function(SalesSaved value) saved,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SalesError value)? error,
    TResult? Function(SalesInitial value)? initial,
    TResult? Function(SalesLoaded value)? loaded,
    TResult? Function(SalesLoadedAll value)? loadedAll,
    TResult? Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult? Function(SalesLoading value)? loading,
    TResult? Function(SalesLoadingProducts value)? loadingProducts,
    TResult? Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult? Function(SalesSaved value)? saved,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SalesError value)? error,
    TResult Function(SalesInitial value)? initial,
    TResult Function(SalesLoaded value)? loaded,
    TResult Function(SalesLoadedAll value)? loadedAll,
    TResult Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult Function(SalesLoading value)? loading,
    TResult Function(SalesLoadingProducts value)? loadingProducts,
    TResult Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult Function(SalesSaved value)? saved,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SalesInitial implements SalesState {
  factory SalesInitial() = _$SalesInitialImpl;
}

/// @nodoc
abstract class _$$SalesLoadedImplCopyWith<$Res> {
  factory _$$SalesLoadedImplCopyWith(
          _$SalesLoadedImpl value, $Res Function(_$SalesLoadedImpl) then) =
      __$$SalesLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<int, Invoice> items});
}

/// @nodoc
class __$$SalesLoadedImplCopyWithImpl<$Res>
    extends _$SalesStateCopyWithImpl<$Res, _$SalesLoadedImpl>
    implements _$$SalesLoadedImplCopyWith<$Res> {
  __$$SalesLoadedImplCopyWithImpl(
      _$SalesLoadedImpl _value, $Res Function(_$SalesLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$SalesLoadedImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as Map<int, Invoice>,
    ));
  }
}

/// @nodoc

class _$SalesLoadedImpl implements SalesLoaded {
  _$SalesLoadedImpl({required final Map<int, Invoice> items}) : _items = items;

  final Map<int, Invoice> _items;
  @override
  Map<int, Invoice> get items {
    if (_items is EqualUnmodifiableMapView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_items);
  }

  @override
  String toString() {
    return 'SalesState.loaded(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesLoadedImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesLoadedImplCopyWith<_$SalesLoadedImpl> get copyWith =>
      __$$SalesLoadedImplCopyWithImpl<_$SalesLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function(Map<int, Invoice> items) loaded,
    required TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)
        loadedAll,
    required TResult Function(Map<int, Customer> customers) loadedCustomers,
    required TResult Function() loading,
    required TResult Function() loadingProducts,
    required TResult Function(String message) loadProductsFailure,
    required TResult Function(Map<int, Invoice> items) saved,
  }) {
    return loaded(items);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? initial,
    TResult? Function(Map<int, Invoice> items)? loaded,
    TResult? Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult? Function(Map<int, Customer> customers)? loadedCustomers,
    TResult? Function()? loading,
    TResult? Function()? loadingProducts,
    TResult? Function(String message)? loadProductsFailure,
    TResult? Function(Map<int, Invoice> items)? saved,
  }) {
    return loaded?.call(items);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function(Map<int, Invoice> items)? loaded,
    TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult Function(Map<int, Customer> customers)? loadedCustomers,
    TResult Function()? loading,
    TResult Function()? loadingProducts,
    TResult Function(String message)? loadProductsFailure,
    TResult Function(Map<int, Invoice> items)? saved,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(items);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SalesError value) error,
    required TResult Function(SalesInitial value) initial,
    required TResult Function(SalesLoaded value) loaded,
    required TResult Function(SalesLoadedAll value) loadedAll,
    required TResult Function(SalesLoadedCustomers value) loadedCustomers,
    required TResult Function(SalesLoading value) loading,
    required TResult Function(SalesLoadingProducts value) loadingProducts,
    required TResult Function(SalesLoadProductsFailure value)
        loadProductsFailure,
    required TResult Function(SalesSaved value) saved,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SalesError value)? error,
    TResult? Function(SalesInitial value)? initial,
    TResult? Function(SalesLoaded value)? loaded,
    TResult? Function(SalesLoadedAll value)? loadedAll,
    TResult? Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult? Function(SalesLoading value)? loading,
    TResult? Function(SalesLoadingProducts value)? loadingProducts,
    TResult? Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult? Function(SalesSaved value)? saved,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SalesError value)? error,
    TResult Function(SalesInitial value)? initial,
    TResult Function(SalesLoaded value)? loaded,
    TResult Function(SalesLoadedAll value)? loadedAll,
    TResult Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult Function(SalesLoading value)? loading,
    TResult Function(SalesLoadingProducts value)? loadingProducts,
    TResult Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult Function(SalesSaved value)? saved,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class SalesLoaded implements SalesState {
  factory SalesLoaded({required final Map<int, Invoice> items}) =
      _$SalesLoadedImpl;

  Map<int, Invoice> get items;

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesLoadedImplCopyWith<_$SalesLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SalesLoadedAllImplCopyWith<$Res> {
  factory _$$SalesLoadedAllImplCopyWith(_$SalesLoadedAllImpl value,
          $Res Function(_$SalesLoadedAllImpl) then) =
      __$$SalesLoadedAllImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<Product> products,
      List<PaymentMethodType> paymentMethods,
      Map<int, Customer> customers,
      Map<int, Company> companies,
      Map<int, Invoice> invoices});
}

/// @nodoc
class __$$SalesLoadedAllImplCopyWithImpl<$Res>
    extends _$SalesStateCopyWithImpl<$Res, _$SalesLoadedAllImpl>
    implements _$$SalesLoadedAllImplCopyWith<$Res> {
  __$$SalesLoadedAllImplCopyWithImpl(
      _$SalesLoadedAllImpl _value, $Res Function(_$SalesLoadedAllImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? products = null,
    Object? paymentMethods = null,
    Object? customers = null,
    Object? companies = null,
    Object? invoices = null,
  }) {
    return _then(_$SalesLoadedAllImpl(
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      paymentMethods: null == paymentMethods
          ? _value._paymentMethods
          : paymentMethods // ignore: cast_nullable_to_non_nullable
              as List<PaymentMethodType>,
      customers: null == customers
          ? _value._customers
          : customers // ignore: cast_nullable_to_non_nullable
              as Map<int, Customer>,
      companies: null == companies
          ? _value._companies
          : companies // ignore: cast_nullable_to_non_nullable
              as Map<int, Company>,
      invoices: null == invoices
          ? _value._invoices
          : invoices // ignore: cast_nullable_to_non_nullable
              as Map<int, Invoice>,
    ));
  }
}

/// @nodoc

class _$SalesLoadedAllImpl implements SalesLoadedAll {
  _$SalesLoadedAllImpl(
      {required final List<Product> products,
      required final List<PaymentMethodType> paymentMethods,
      required final Map<int, Customer> customers,
      required final Map<int, Company> companies,
      required final Map<int, Invoice> invoices})
      : _products = products,
        _paymentMethods = paymentMethods,
        _customers = customers,
        _companies = companies,
        _invoices = invoices;

  final List<Product> _products;
  @override
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<PaymentMethodType> _paymentMethods;
  @override
  List<PaymentMethodType> get paymentMethods {
    if (_paymentMethods is EqualUnmodifiableListView) return _paymentMethods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paymentMethods);
  }

  final Map<int, Customer> _customers;
  @override
  Map<int, Customer> get customers {
    if (_customers is EqualUnmodifiableMapView) return _customers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customers);
  }

  final Map<int, Company> _companies;
  @override
  Map<int, Company> get companies {
    if (_companies is EqualUnmodifiableMapView) return _companies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_companies);
  }

  final Map<int, Invoice> _invoices;
  @override
  Map<int, Invoice> get invoices {
    if (_invoices is EqualUnmodifiableMapView) return _invoices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_invoices);
  }

  @override
  String toString() {
    return 'SalesState.loadedAll(products: $products, paymentMethods: $paymentMethods, customers: $customers, companies: $companies, invoices: $invoices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesLoadedAllImpl &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality()
                .equals(other._paymentMethods, _paymentMethods) &&
            const DeepCollectionEquality()
                .equals(other._customers, _customers) &&
            const DeepCollectionEquality()
                .equals(other._companies, _companies) &&
            const DeepCollectionEquality().equals(other._invoices, _invoices));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_paymentMethods),
      const DeepCollectionEquality().hash(_customers),
      const DeepCollectionEquality().hash(_companies),
      const DeepCollectionEquality().hash(_invoices));

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesLoadedAllImplCopyWith<_$SalesLoadedAllImpl> get copyWith =>
      __$$SalesLoadedAllImplCopyWithImpl<_$SalesLoadedAllImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function(Map<int, Invoice> items) loaded,
    required TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)
        loadedAll,
    required TResult Function(Map<int, Customer> customers) loadedCustomers,
    required TResult Function() loading,
    required TResult Function() loadingProducts,
    required TResult Function(String message) loadProductsFailure,
    required TResult Function(Map<int, Invoice> items) saved,
  }) {
    return loadedAll(products, paymentMethods, customers, companies, invoices);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? initial,
    TResult? Function(Map<int, Invoice> items)? loaded,
    TResult? Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult? Function(Map<int, Customer> customers)? loadedCustomers,
    TResult? Function()? loading,
    TResult? Function()? loadingProducts,
    TResult? Function(String message)? loadProductsFailure,
    TResult? Function(Map<int, Invoice> items)? saved,
  }) {
    return loadedAll?.call(products, paymentMethods, customers, companies, invoices);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function(Map<int, Invoice> items)? loaded,
    TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult Function(Map<int, Customer> customers)? loadedCustomers,
    TResult Function()? loading,
    TResult Function()? loadingProducts,
    TResult Function(String message)? loadProductsFailure,
    TResult Function(Map<int, Invoice> items)? saved,
    required TResult orElse(),
  }) {
    if (loadedAll != null) {
      return loadedAll(products, paymentMethods, customers, companies, invoices);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SalesError value) error,
    required TResult Function(SalesInitial value) initial,
    required TResult Function(SalesLoaded value) loaded,
    required TResult Function(SalesLoadedAll value) loadedAll,
    required TResult Function(SalesLoadedCustomers value) loadedCustomers,
    required TResult Function(SalesLoading value) loading,
    required TResult Function(SalesLoadingProducts value) loadingProducts,
    required TResult Function(SalesLoadProductsFailure value)
        loadProductsFailure,
    required TResult Function(SalesSaved value) saved,
  }) {
    return loadedAll(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SalesError value)? error,
    TResult? Function(SalesInitial value)? initial,
    TResult? Function(SalesLoaded value)? loaded,
    TResult? Function(SalesLoadedAll value)? loadedAll,
    TResult? Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult? Function(SalesLoading value)? loading,
    TResult? Function(SalesLoadingProducts value)? loadingProducts,
    TResult? Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult? Function(SalesSaved value)? saved,
  }) {
    return loadedAll?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SalesError value)? error,
    TResult Function(SalesInitial value)? initial,
    TResult Function(SalesLoaded value)? loaded,
    TResult Function(SalesLoadedAll value)? loadedAll,
    TResult Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult Function(SalesLoading value)? loading,
    TResult Function(SalesLoadingProducts value)? loadingProducts,
    TResult Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult Function(SalesSaved value)? saved,
    required TResult orElse(),
  }) {
    if (loadedAll != null) {
      return loadedAll(this);
    }
    return orElse();
  }
}

abstract class SalesLoadedAll implements SalesState {
  factory SalesLoadedAll(
      {required final List<Product> products,
      required final List<PaymentMethodType> paymentMethods,
      required final Map<int, Customer> customers,
      required final Map<int, Company> companies,
      required final Map<int, Invoice> invoices}) = _$SalesLoadedAllImpl;

  List<Product> get products;
  List<PaymentMethodType> get paymentMethods;
  Map<int, Customer> get customers;
  Map<int, Company> get companies;
  Map<int, Invoice> get invoices;

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesLoadedAllImplCopyWith<_$SalesLoadedAllImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SalesLoadedCustomersImplCopyWith<$Res> {
  factory _$$SalesLoadedCustomersImplCopyWith(_$SalesLoadedCustomersImpl value,
          $Res Function(_$SalesLoadedCustomersImpl) then) =
      __$$SalesLoadedCustomersImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<int, Customer> customers});
}

/// @nodoc
class __$$SalesLoadedCustomersImplCopyWithImpl<$Res>
    extends _$SalesStateCopyWithImpl<$Res, _$SalesLoadedCustomersImpl>
    implements _$$SalesLoadedCustomersImplCopyWith<$Res> {
  __$$SalesLoadedCustomersImplCopyWithImpl(_$SalesLoadedCustomersImpl _value,
      $Res Function(_$SalesLoadedCustomersImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customers = null,
  }) {
    return _then(_$SalesLoadedCustomersImpl(
      customers: null == customers
          ? _value._customers
          : customers // ignore: cast_nullable_to_non_nullable
              as Map<int, Customer>,
    ));
  }
}

/// @nodoc

class _$SalesLoadedCustomersImpl implements SalesLoadedCustomers {
  _$SalesLoadedCustomersImpl({required final Map<int, Customer> customers})
      : _customers = customers;

  final Map<int, Customer> _customers;
  @override
  Map<int, Customer> get customers {
    if (_customers is EqualUnmodifiableMapView) return _customers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_customers);
  }

  @override
  String toString() {
    return 'SalesState.loadedCustomers(customers: $customers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesLoadedCustomersImpl &&
            const DeepCollectionEquality()
                .equals(other._customers, _customers));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_customers));

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesLoadedCustomersImplCopyWith<_$SalesLoadedCustomersImpl>
      get copyWith =>
          __$$SalesLoadedCustomersImplCopyWithImpl<_$SalesLoadedCustomersImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function(Map<int, Invoice> items) loaded,
    required TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)
        loadedAll,
    required TResult Function(Map<int, Customer> customers) loadedCustomers,
    required TResult Function() loading,
    required TResult Function() loadingProducts,
    required TResult Function(String message) loadProductsFailure,
    required TResult Function(Map<int, Invoice> items) saved,
  }) {
    return loadedCustomers(customers);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? initial,
    TResult? Function(Map<int, Invoice> items)? loaded,
    TResult? Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult? Function(Map<int, Customer> customers)? loadedCustomers,
    TResult? Function()? loading,
    TResult? Function()? loadingProducts,
    TResult? Function(String message)? loadProductsFailure,
    TResult? Function(Map<int, Invoice> items)? saved,
  }) {
    return loadedCustomers?.call(customers);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function(Map<int, Invoice> items)? loaded,
    TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult Function(Map<int, Customer> customers)? loadedCustomers,
    TResult Function()? loading,
    TResult Function()? loadingProducts,
    TResult Function(String message)? loadProductsFailure,
    TResult Function(Map<int, Invoice> items)? saved,
    required TResult orElse(),
  }) {
    if (loadedCustomers != null) {
      return loadedCustomers(customers);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SalesError value) error,
    required TResult Function(SalesInitial value) initial,
    required TResult Function(SalesLoaded value) loaded,
    required TResult Function(SalesLoadedAll value) loadedAll,
    required TResult Function(SalesLoadedCustomers value) loadedCustomers,
    required TResult Function(SalesLoading value) loading,
    required TResult Function(SalesLoadingProducts value) loadingProducts,
    required TResult Function(SalesLoadProductsFailure value)
        loadProductsFailure,
    required TResult Function(SalesSaved value) saved,
  }) {
    return loadedCustomers(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SalesError value)? error,
    TResult? Function(SalesInitial value)? initial,
    TResult? Function(SalesLoaded value)? loaded,
    TResult? Function(SalesLoadedAll value)? loadedAll,
    TResult? Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult? Function(SalesLoading value)? loading,
    TResult? Function(SalesLoadingProducts value)? loadingProducts,
    TResult? Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult? Function(SalesSaved value)? saved,
  }) {
    return loadedCustomers?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SalesError value)? error,
    TResult Function(SalesInitial value)? initial,
    TResult Function(SalesLoaded value)? loaded,
    TResult Function(SalesLoadedAll value)? loadedAll,
    TResult Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult Function(SalesLoading value)? loading,
    TResult Function(SalesLoadingProducts value)? loadingProducts,
    TResult Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult Function(SalesSaved value)? saved,
    required TResult orElse(),
  }) {
    if (loadedCustomers != null) {
      return loadedCustomers(this);
    }
    return orElse();
  }
}

abstract class SalesLoadedCustomers implements SalesState {
  factory SalesLoadedCustomers({required final Map<int, Customer> customers}) =
      _$SalesLoadedCustomersImpl;

  Map<int, Customer> get customers;

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesLoadedCustomersImplCopyWith<_$SalesLoadedCustomersImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SalesLoadingImplCopyWith<$Res> {
  factory _$$SalesLoadingImplCopyWith(
          _$SalesLoadingImpl value, $Res Function(_$SalesLoadingImpl) then) =
      __$$SalesLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SalesLoadingImplCopyWithImpl<$Res>
    extends _$SalesStateCopyWithImpl<$Res, _$SalesLoadingImpl>
    implements _$$SalesLoadingImplCopyWith<$Res> {
  __$$SalesLoadingImplCopyWithImpl(
      _$SalesLoadingImpl _value, $Res Function(_$SalesLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SalesLoadingImpl implements SalesLoading {
  _$SalesLoadingImpl();

  @override
  String toString() {
    return 'SalesState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SalesLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function(Map<int, Invoice> items) loaded,
    required TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)
        loadedAll,
    required TResult Function(Map<int, Customer> customers) loadedCustomers,
    required TResult Function() loading,
    required TResult Function() loadingProducts,
    required TResult Function(String message) loadProductsFailure,
    required TResult Function(Map<int, Invoice> items) saved,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? initial,
    TResult? Function(Map<int, Invoice> items)? loaded,
    TResult? Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult? Function(Map<int, Customer> customers)? loadedCustomers,
    TResult? Function()? loading,
    TResult? Function()? loadingProducts,
    TResult? Function(String message)? loadProductsFailure,
    TResult? Function(Map<int, Invoice> items)? saved,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function(Map<int, Invoice> items)? loaded,
    TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult Function(Map<int, Customer> customers)? loadedCustomers,
    TResult Function()? loading,
    TResult Function()? loadingProducts,
    TResult Function(String message)? loadProductsFailure,
    TResult Function(Map<int, Invoice> items)? saved,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SalesError value) error,
    required TResult Function(SalesInitial value) initial,
    required TResult Function(SalesLoaded value) loaded,
    required TResult Function(SalesLoadedAll value) loadedAll,
    required TResult Function(SalesLoadedCustomers value) loadedCustomers,
    required TResult Function(SalesLoading value) loading,
    required TResult Function(SalesLoadingProducts value) loadingProducts,
    required TResult Function(SalesLoadProductsFailure value)
        loadProductsFailure,
    required TResult Function(SalesSaved value) saved,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SalesError value)? error,
    TResult? Function(SalesInitial value)? initial,
    TResult? Function(SalesLoaded value)? loaded,
    TResult? Function(SalesLoadedAll value)? loadedAll,
    TResult? Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult? Function(SalesLoading value)? loading,
    TResult? Function(SalesLoadingProducts value)? loadingProducts,
    TResult? Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult? Function(SalesSaved value)? saved,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SalesError value)? error,
    TResult Function(SalesInitial value)? initial,
    TResult Function(SalesLoaded value)? loaded,
    TResult Function(SalesLoadedAll value)? loadedAll,
    TResult Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult Function(SalesLoading value)? loading,
    TResult Function(SalesLoadingProducts value)? loadingProducts,
    TResult Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult Function(SalesSaved value)? saved,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class SalesLoading implements SalesState {
  factory SalesLoading() = _$SalesLoadingImpl;
}

/// @nodoc
abstract class _$$SalesLoadingProductsImplCopyWith<$Res> {
  factory _$$SalesLoadingProductsImplCopyWith(_$SalesLoadingProductsImpl value,
          $Res Function(_$SalesLoadingProductsImpl) then) =
      __$$SalesLoadingProductsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SalesLoadingProductsImplCopyWithImpl<$Res>
    extends _$SalesStateCopyWithImpl<$Res, _$SalesLoadingProductsImpl>
    implements _$$SalesLoadingProductsImplCopyWith<$Res> {
  __$$SalesLoadingProductsImplCopyWithImpl(_$SalesLoadingProductsImpl _value,
      $Res Function(_$SalesLoadingProductsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SalesLoadingProductsImpl implements SalesLoadingProducts {
  _$SalesLoadingProductsImpl();

  @override
  String toString() {
    return 'SalesState.loadingProducts()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesLoadingProductsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function(Map<int, Invoice> items) loaded,
    required TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)
        loadedAll,
    required TResult Function(Map<int, Customer> customers) loadedCustomers,
    required TResult Function() loading,
    required TResult Function() loadingProducts,
    required TResult Function(String message) loadProductsFailure,
    required TResult Function(Map<int, Invoice> items) saved,
  }) {
    return loadingProducts();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? initial,
    TResult? Function(Map<int, Invoice> items)? loaded,
    TResult? Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult? Function(Map<int, Customer> customers)? loadedCustomers,
    TResult? Function()? loading,
    TResult? Function()? loadingProducts,
    TResult? Function(String message)? loadProductsFailure,
    TResult? Function(Map<int, Invoice> items)? saved,
  }) {
    return loadingProducts?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function(Map<int, Invoice> items)? loaded,
    TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult Function(Map<int, Customer> customers)? loadedCustomers,
    TResult Function()? loading,
    TResult Function()? loadingProducts,
    TResult Function(String message)? loadProductsFailure,
    TResult Function(Map<int, Invoice> items)? saved,
    required TResult orElse(),
  }) {
    if (loadingProducts != null) {
      return loadingProducts();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SalesError value) error,
    required TResult Function(SalesInitial value) initial,
    required TResult Function(SalesLoaded value) loaded,
    required TResult Function(SalesLoadedAll value) loadedAll,
    required TResult Function(SalesLoadedCustomers value) loadedCustomers,
    required TResult Function(SalesLoading value) loading,
    required TResult Function(SalesLoadingProducts value) loadingProducts,
    required TResult Function(SalesLoadProductsFailure value)
        loadProductsFailure,
    required TResult Function(SalesSaved value) saved,
  }) {
    return loadingProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SalesError value)? error,
    TResult? Function(SalesInitial value)? initial,
    TResult? Function(SalesLoaded value)? loaded,
    TResult? Function(SalesLoadedAll value)? loadedAll,
    TResult? Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult? Function(SalesLoading value)? loading,
    TResult? Function(SalesLoadingProducts value)? loadingProducts,
    TResult? Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult? Function(SalesSaved value)? saved,
  }) {
    return loadingProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SalesError value)? error,
    TResult Function(SalesInitial value)? initial,
    TResult Function(SalesLoaded value)? loaded,
    TResult Function(SalesLoadedAll value)? loadedAll,
    TResult Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult Function(SalesLoading value)? loading,
    TResult Function(SalesLoadingProducts value)? loadingProducts,
    TResult Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult Function(SalesSaved value)? saved,
    required TResult orElse(),
  }) {
    if (loadingProducts != null) {
      return loadingProducts(this);
    }
    return orElse();
  }
}

abstract class SalesLoadingProducts implements SalesState {
  factory SalesLoadingProducts() = _$SalesLoadingProductsImpl;
}

/// @nodoc
abstract class _$$SalesLoadProductsFailureImplCopyWith<$Res> {
  factory _$$SalesLoadProductsFailureImplCopyWith(
          _$SalesLoadProductsFailureImpl value,
          $Res Function(_$SalesLoadProductsFailureImpl) then) =
      __$$SalesLoadProductsFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SalesLoadProductsFailureImplCopyWithImpl<$Res>
    extends _$SalesStateCopyWithImpl<$Res, _$SalesLoadProductsFailureImpl>
    implements _$$SalesLoadProductsFailureImplCopyWith<$Res> {
  __$$SalesLoadProductsFailureImplCopyWithImpl(
      _$SalesLoadProductsFailureImpl _value,
      $Res Function(_$SalesLoadProductsFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SalesLoadProductsFailureImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SalesLoadProductsFailureImpl implements SalesLoadProductsFailure {
  _$SalesLoadProductsFailureImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'SalesState.loadProductsFailure(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesLoadProductsFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesLoadProductsFailureImplCopyWith<_$SalesLoadProductsFailureImpl>
      get copyWith => __$$SalesLoadProductsFailureImplCopyWithImpl<
          _$SalesLoadProductsFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function(Map<int, Invoice> items) loaded,
    required TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)
        loadedAll,
    required TResult Function(Map<int, Customer> customers) loadedCustomers,
    required TResult Function() loading,
    required TResult Function() loadingProducts,
    required TResult Function(String message) loadProductsFailure,
    required TResult Function(Map<int, Invoice> items) saved,
  }) {
    return loadProductsFailure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? initial,
    TResult? Function(Map<int, Invoice> items)? loaded,
    TResult? Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult? Function(Map<int, Customer> customers)? loadedCustomers,
    TResult? Function()? loading,
    TResult? Function()? loadingProducts,
    TResult? Function(String message)? loadProductsFailure,
    TResult? Function(Map<int, Invoice> items)? saved,
  }) {
    return loadProductsFailure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function(Map<int, Invoice> items)? loaded,
    TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult Function(Map<int, Customer> customers)? loadedCustomers,
    TResult Function()? loading,
    TResult Function()? loadingProducts,
    TResult Function(String message)? loadProductsFailure,
    TResult Function(Map<int, Invoice> items)? saved,
    required TResult orElse(),
  }) {
    if (loadProductsFailure != null) {
      return loadProductsFailure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SalesError value) error,
    required TResult Function(SalesInitial value) initial,
    required TResult Function(SalesLoaded value) loaded,
    required TResult Function(SalesLoadedAll value) loadedAll,
    required TResult Function(SalesLoadedCustomers value) loadedCustomers,
    required TResult Function(SalesLoading value) loading,
    required TResult Function(SalesLoadingProducts value) loadingProducts,
    required TResult Function(SalesLoadProductsFailure value)
        loadProductsFailure,
    required TResult Function(SalesSaved value) saved,
  }) {
    return loadProductsFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SalesError value)? error,
    TResult? Function(SalesInitial value)? initial,
    TResult? Function(SalesLoaded value)? loaded,
    TResult? Function(SalesLoadedAll value)? loadedAll,
    TResult? Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult? Function(SalesLoading value)? loading,
    TResult? Function(SalesLoadingProducts value)? loadingProducts,
    TResult? Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult? Function(SalesSaved value)? saved,
  }) {
    return loadProductsFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SalesError value)? error,
    TResult Function(SalesInitial value)? initial,
    TResult Function(SalesLoaded value)? loaded,
    TResult Function(SalesLoadedAll value)? loadedAll,
    TResult Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult Function(SalesLoading value)? loading,
    TResult Function(SalesLoadingProducts value)? loadingProducts,
    TResult Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult Function(SalesSaved value)? saved,
    required TResult orElse(),
  }) {
    if (loadProductsFailure != null) {
      return loadProductsFailure(this);
    }
    return orElse();
  }
}

abstract class SalesLoadProductsFailure implements SalesState {
  factory SalesLoadProductsFailure({required final String message}) =
      _$SalesLoadProductsFailureImpl;

  String get message;

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesLoadProductsFailureImplCopyWith<_$SalesLoadProductsFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SalesSavedImplCopyWith<$Res> {
  factory _$$SalesSavedImplCopyWith(
          _$SalesSavedImpl value, $Res Function(_$SalesSavedImpl) then) =
      __$$SalesSavedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<int, Invoice> items});
}

/// @nodoc
class __$$SalesSavedImplCopyWithImpl<$Res>
    extends _$SalesStateCopyWithImpl<$Res, _$SalesSavedImpl>
    implements _$$SalesSavedImplCopyWith<$Res> {
  __$$SalesSavedImplCopyWithImpl(
      _$SalesSavedImpl _value, $Res Function(_$SalesSavedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$SalesSavedImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as Map<int, Invoice>,
    ));
  }
}

/// @nodoc

class _$SalesSavedImpl implements SalesSaved {
  _$SalesSavedImpl({required final Map<int, Invoice> items}) : _items = items;

  final Map<int, Invoice> _items;
  @override
  Map<int, Invoice> get items {
    if (_items is EqualUnmodifiableMapView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_items);
  }

  @override
  String toString() {
    return 'SalesState.saved(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalesSavedImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SalesSavedImplCopyWith<_$SalesSavedImpl> get copyWith =>
      __$$SalesSavedImplCopyWithImpl<_$SalesSavedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() initial,
    required TResult Function(Map<int, Invoice> items) loaded,
    required TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)
        loadedAll,
    required TResult Function(Map<int, Customer> customers) loadedCustomers,
    required TResult Function() loading,
    required TResult Function() loadingProducts,
    required TResult Function(String message) loadProductsFailure,
    required TResult Function(Map<int, Invoice> items) saved,
  }) {
    return saved(items);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? initial,
    TResult? Function(Map<int, Invoice> items)? loaded,
    TResult? Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult? Function(Map<int, Customer> customers)? loadedCustomers,
    TResult? Function()? loading,
    TResult? Function()? loadingProducts,
    TResult? Function(String message)? loadProductsFailure,
    TResult? Function(Map<int, Invoice> items)? saved,
  }) {
    return saved?.call(items);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? initial,
    TResult Function(Map<int, Invoice> items)? loaded,
    TResult Function(
            List<Product> products,
            List<PaymentMethodType> paymentMethods,
            Map<int, Customer> customers,
            Map<int, Company> companies,
            Map<int, Invoice> invoices)?
        loadedAll,
    TResult Function(Map<int, Customer> customers)? loadedCustomers,
    TResult Function()? loading,
    TResult Function()? loadingProducts,
    TResult Function(String message)? loadProductsFailure,
    TResult Function(Map<int, Invoice> items)? saved,
    required TResult orElse(),
  }) {
    if (saved != null) {
      return saved(items);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SalesError value) error,
    required TResult Function(SalesInitial value) initial,
    required TResult Function(SalesLoaded value) loaded,
    required TResult Function(SalesLoadedAll value) loadedAll,
    required TResult Function(SalesLoadedCustomers value) loadedCustomers,
    required TResult Function(SalesLoading value) loading,
    required TResult Function(SalesLoadingProducts value) loadingProducts,
    required TResult Function(SalesLoadProductsFailure value)
        loadProductsFailure,
    required TResult Function(SalesSaved value) saved,
  }) {
    return saved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SalesError value)? error,
    TResult? Function(SalesInitial value)? initial,
    TResult? Function(SalesLoaded value)? loaded,
    TResult? Function(SalesLoadedAll value)? loadedAll,
    TResult? Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult? Function(SalesLoading value)? loading,
    TResult? Function(SalesLoadingProducts value)? loadingProducts,
    TResult? Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult? Function(SalesSaved value)? saved,
  }) {
    return saved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SalesError value)? error,
    TResult Function(SalesInitial value)? initial,
    TResult Function(SalesLoaded value)? loaded,
    TResult Function(SalesLoadedAll value)? loadedAll,
    TResult Function(SalesLoadedCustomers value)? loadedCustomers,
    TResult Function(SalesLoading value)? loading,
    TResult Function(SalesLoadingProducts value)? loadingProducts,
    TResult Function(SalesLoadProductsFailure value)? loadProductsFailure,
    TResult Function(SalesSaved value)? saved,
    required TResult orElse(),
  }) {
    if (saved != null) {
      return saved(this);
    }
    return orElse();
  }
}

abstract class SalesSaved implements SalesState {
  factory SalesSaved({required final Map<int, Invoice> items}) =
      _$SalesSavedImpl;

  Map<int, Invoice> get items;

  /// Create a copy of SalesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SalesSavedImplCopyWith<_$SalesSavedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
