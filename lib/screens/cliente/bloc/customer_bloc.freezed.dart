// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CustomerBlocEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerBlocEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerBlocEvent()';
}


}

/// @nodoc
class $CustomerBlocEventCopyWith<$Res>  {
$CustomerBlocEventCopyWith(CustomerBlocEvent _, $Res Function(CustomerBlocEvent) __);
}


/// Adds pattern-matching-related methods to [CustomerBlocEvent].
extension CustomerBlocEventPatterns on CustomerBlocEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _RegisterCustomer value)?  registerCustomer,TResult Function( _LoadCustomers value)?  loadCustomers,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterCustomer() when registerCustomer != null:
return registerCustomer(_that);case _LoadCustomers() when loadCustomers != null:
return loadCustomers(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _RegisterCustomer value)  registerCustomer,required TResult Function( _LoadCustomers value)  loadCustomers,}){
final _that = this;
switch (_that) {
case _RegisterCustomer():
return registerCustomer(_that);case _LoadCustomers():
return loadCustomers(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _RegisterCustomer value)?  registerCustomer,TResult? Function( _LoadCustomers value)?  loadCustomers,}){
final _that = this;
switch (_that) {
case _RegisterCustomer() when registerCustomer != null:
return registerCustomer(_that);case _LoadCustomers() when loadCustomers != null:
return loadCustomers(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String name,  String cpf,  String email,  String phone,  String address)?  registerCustomer,TResult Function()?  loadCustomers,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterCustomer() when registerCustomer != null:
return registerCustomer(_that.name,_that.cpf,_that.email,_that.phone,_that.address);case _LoadCustomers() when loadCustomers != null:
return loadCustomers();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String name,  String cpf,  String email,  String phone,  String address)  registerCustomer,required TResult Function()  loadCustomers,}) {final _that = this;
switch (_that) {
case _RegisterCustomer():
return registerCustomer(_that.name,_that.cpf,_that.email,_that.phone,_that.address);case _LoadCustomers():
return loadCustomers();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String name,  String cpf,  String email,  String phone,  String address)?  registerCustomer,TResult? Function()?  loadCustomers,}) {final _that = this;
switch (_that) {
case _RegisterCustomer() when registerCustomer != null:
return registerCustomer(_that.name,_that.cpf,_that.email,_that.phone,_that.address);case _LoadCustomers() when loadCustomers != null:
return loadCustomers();case _:
  return null;

}
}

}

/// @nodoc


class _RegisterCustomer implements CustomerBlocEvent {
  const _RegisterCustomer({required this.name, required this.cpf, required this.email, required this.phone, required this.address});
  

 final  String name;
 final  String cpf;
 final  String email;
 final  String phone;
 final  String address;

/// Create a copy of CustomerBlocEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterCustomerCopyWith<_RegisterCustomer> get copyWith => __$RegisterCustomerCopyWithImpl<_RegisterCustomer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterCustomer&&(identical(other.name, name) || other.name == name)&&(identical(other.cpf, cpf) || other.cpf == cpf)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address));
}


@override
int get hashCode => Object.hash(runtimeType,name,cpf,email,phone,address);

@override
String toString() {
  return 'CustomerBlocEvent.registerCustomer(name: $name, cpf: $cpf, email: $email, phone: $phone, address: $address)';
}


}

/// @nodoc
abstract mixin class _$RegisterCustomerCopyWith<$Res> implements $CustomerBlocEventCopyWith<$Res> {
  factory _$RegisterCustomerCopyWith(_RegisterCustomer value, $Res Function(_RegisterCustomer) _then) = __$RegisterCustomerCopyWithImpl;
@useResult
$Res call({
 String name, String cpf, String email, String phone, String address
});




}
/// @nodoc
class __$RegisterCustomerCopyWithImpl<$Res>
    implements _$RegisterCustomerCopyWith<$Res> {
  __$RegisterCustomerCopyWithImpl(this._self, this._then);

  final _RegisterCustomer _self;
  final $Res Function(_RegisterCustomer) _then;

/// Create a copy of CustomerBlocEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? cpf = null,Object? email = null,Object? phone = null,Object? address = null,}) {
  return _then(_RegisterCustomer(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cpf: null == cpf ? _self.cpf : cpf // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadCustomers implements CustomerBlocEvent {
  const _LoadCustomers();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadCustomers);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerBlocEvent.loadCustomers()';
}


}




/// @nodoc
mixin _$CustomerBlocState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerBlocState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerBlocState()';
}


}

/// @nodoc
class $CustomerBlocStateCopyWith<$Res>  {
$CustomerBlocStateCopyWith(CustomerBlocState _, $Res Function(CustomerBlocState) __);
}


/// Adds pattern-matching-related methods to [CustomerBlocState].
extension CustomerBlocStatePatterns on CustomerBlocState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _CustomersLoaded value)?  customersLoaded,TResult Function( _CustomerAdded value)?  customerAdded,TResult Function( _CustomerError value)?  customerError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _CustomersLoaded() when customersLoaded != null:
return customersLoaded(_that);case _CustomerAdded() when customerAdded != null:
return customerAdded(_that);case _CustomerError() when customerError != null:
return customerError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _CustomersLoaded value)  customersLoaded,required TResult Function( _CustomerAdded value)  customerAdded,required TResult Function( _CustomerError value)  customerError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _CustomersLoaded():
return customersLoaded(_that);case _CustomerAdded():
return customerAdded(_that);case _CustomerError():
return customerError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _CustomersLoaded value)?  customersLoaded,TResult? Function( _CustomerAdded value)?  customerAdded,TResult? Function( _CustomerError value)?  customerError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _CustomersLoaded() when customersLoaded != null:
return customersLoaded(_that);case _CustomerAdded() when customerAdded != null:
return customerAdded(_that);case _CustomerError() when customerError != null:
return customerError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Customer> customers)?  customersLoaded,TResult Function( Customer customer)?  customerAdded,TResult Function( String message)?  customerError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _CustomersLoaded() when customersLoaded != null:
return customersLoaded(_that.customers);case _CustomerAdded() when customerAdded != null:
return customerAdded(_that.customer);case _CustomerError() when customerError != null:
return customerError(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Customer> customers)  customersLoaded,required TResult Function( Customer customer)  customerAdded,required TResult Function( String message)  customerError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _CustomersLoaded():
return customersLoaded(_that.customers);case _CustomerAdded():
return customerAdded(_that.customer);case _CustomerError():
return customerError(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Customer> customers)?  customersLoaded,TResult? Function( Customer customer)?  customerAdded,TResult? Function( String message)?  customerError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _CustomersLoaded() when customersLoaded != null:
return customersLoaded(_that.customers);case _CustomerAdded() when customerAdded != null:
return customerAdded(_that.customer);case _CustomerError() when customerError != null:
return customerError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CustomerBlocState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerBlocState.initial()';
}


}




/// @nodoc


class _Loading implements CustomerBlocState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CustomerBlocState.loading()';
}


}




/// @nodoc


class _CustomersLoaded implements CustomerBlocState {
  const _CustomersLoaded({required final  List<Customer> customers}): _customers = customers;
  

 final  List<Customer> _customers;
 List<Customer> get customers {
  if (_customers is EqualUnmodifiableListView) return _customers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customers);
}


/// Create a copy of CustomerBlocState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomersLoadedCopyWith<_CustomersLoaded> get copyWith => __$CustomersLoadedCopyWithImpl<_CustomersLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomersLoaded&&const DeepCollectionEquality().equals(other._customers, _customers));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_customers));

@override
String toString() {
  return 'CustomerBlocState.customersLoaded(customers: $customers)';
}


}

/// @nodoc
abstract mixin class _$CustomersLoadedCopyWith<$Res> implements $CustomerBlocStateCopyWith<$Res> {
  factory _$CustomersLoadedCopyWith(_CustomersLoaded value, $Res Function(_CustomersLoaded) _then) = __$CustomersLoadedCopyWithImpl;
@useResult
$Res call({
 List<Customer> customers
});




}
/// @nodoc
class __$CustomersLoadedCopyWithImpl<$Res>
    implements _$CustomersLoadedCopyWith<$Res> {
  __$CustomersLoadedCopyWithImpl(this._self, this._then);

  final _CustomersLoaded _self;
  final $Res Function(_CustomersLoaded) _then;

/// Create a copy of CustomerBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customers = null,}) {
  return _then(_CustomersLoaded(
customers: null == customers ? _self._customers : customers // ignore: cast_nullable_to_non_nullable
as List<Customer>,
  ));
}


}

/// @nodoc


class _CustomerAdded implements CustomerBlocState {
  const _CustomerAdded({required this.customer});
  

 final  Customer customer;

/// Create a copy of CustomerBlocState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerAddedCopyWith<_CustomerAdded> get copyWith => __$CustomerAddedCopyWithImpl<_CustomerAdded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerAdded&&(identical(other.customer, customer) || other.customer == customer));
}


@override
int get hashCode => Object.hash(runtimeType,customer);

@override
String toString() {
  return 'CustomerBlocState.customerAdded(customer: $customer)';
}


}

/// @nodoc
abstract mixin class _$CustomerAddedCopyWith<$Res> implements $CustomerBlocStateCopyWith<$Res> {
  factory _$CustomerAddedCopyWith(_CustomerAdded value, $Res Function(_CustomerAdded) _then) = __$CustomerAddedCopyWithImpl;
@useResult
$Res call({
 Customer customer
});




}
/// @nodoc
class __$CustomerAddedCopyWithImpl<$Res>
    implements _$CustomerAddedCopyWith<$Res> {
  __$CustomerAddedCopyWithImpl(this._self, this._then);

  final _CustomerAdded _self;
  final $Res Function(_CustomerAdded) _then;

/// Create a copy of CustomerBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customer = null,}) {
  return _then(_CustomerAdded(
customer: null == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as Customer,
  ));
}


}

/// @nodoc


class _CustomerError implements CustomerBlocState {
  const _CustomerError({required this.message});
  

 final  String message;

/// Create a copy of CustomerBlocState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerErrorCopyWith<_CustomerError> get copyWith => __$CustomerErrorCopyWithImpl<_CustomerError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CustomerBlocState.customerError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$CustomerErrorCopyWith<$Res> implements $CustomerBlocStateCopyWith<$Res> {
  factory _$CustomerErrorCopyWith(_CustomerError value, $Res Function(_CustomerError) _then) = __$CustomerErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$CustomerErrorCopyWithImpl<$Res>
    implements _$CustomerErrorCopyWith<$Res> {
  __$CustomerErrorCopyWithImpl(this._self, this._then);

  final _CustomerError _self;
  final $Res Function(_CustomerError) _then;

/// Create a copy of CustomerBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_CustomerError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
