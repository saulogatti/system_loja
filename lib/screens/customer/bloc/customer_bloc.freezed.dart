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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _RegisterCustomer value)?  registerCustomer,TResult Function( _LoadCustomers value)?  loadCustomers,TResult Function( _DeleteCustomer value)?  deleteCustomer,TResult Function( _FindCustomerByCpf value)?  findCustomerByCpf,TResult Function( _UpdateCustomer value)?  updateCustomer,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterCustomer() when registerCustomer != null:
return registerCustomer(_that);case _LoadCustomers() when loadCustomers != null:
return loadCustomers(_that);case _DeleteCustomer() when deleteCustomer != null:
return deleteCustomer(_that);case _FindCustomerByCpf() when findCustomerByCpf != null:
return findCustomerByCpf(_that);case _UpdateCustomer() when updateCustomer != null:
return updateCustomer(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _RegisterCustomer value)  registerCustomer,required TResult Function( _LoadCustomers value)  loadCustomers,required TResult Function( _DeleteCustomer value)  deleteCustomer,required TResult Function( _FindCustomerByCpf value)  findCustomerByCpf,required TResult Function( _UpdateCustomer value)  updateCustomer,}){
final _that = this;
switch (_that) {
case _RegisterCustomer():
return registerCustomer(_that);case _LoadCustomers():
return loadCustomers(_that);case _DeleteCustomer():
return deleteCustomer(_that);case _FindCustomerByCpf():
return findCustomerByCpf(_that);case _UpdateCustomer():
return updateCustomer(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _RegisterCustomer value)?  registerCustomer,TResult? Function( _LoadCustomers value)?  loadCustomers,TResult? Function( _DeleteCustomer value)?  deleteCustomer,TResult? Function( _FindCustomerByCpf value)?  findCustomerByCpf,TResult? Function( _UpdateCustomer value)?  updateCustomer,}){
final _that = this;
switch (_that) {
case _RegisterCustomer() when registerCustomer != null:
return registerCustomer(_that);case _LoadCustomers() when loadCustomers != null:
return loadCustomers(_that);case _DeleteCustomer() when deleteCustomer != null:
return deleteCustomer(_that);case _FindCustomerByCpf() when findCustomerByCpf != null:
return findCustomerByCpf(_that);case _UpdateCustomer() when updateCustomer != null:
return updateCustomer(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String name,  String cpf,  String email,  String phone,  String address)?  registerCustomer,TResult Function()?  loadCustomers,TResult Function( int id)?  deleteCustomer,TResult Function( String cpf)?  findCustomerByCpf,TResult Function( Customer customer)?  updateCustomer,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterCustomer() when registerCustomer != null:
return registerCustomer(_that.name,_that.cpf,_that.email,_that.phone,_that.address);case _LoadCustomers() when loadCustomers != null:
return loadCustomers();case _DeleteCustomer() when deleteCustomer != null:
return deleteCustomer(_that.id);case _FindCustomerByCpf() when findCustomerByCpf != null:
return findCustomerByCpf(_that.cpf);case _UpdateCustomer() when updateCustomer != null:
return updateCustomer(_that.customer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String name,  String cpf,  String email,  String phone,  String address)  registerCustomer,required TResult Function()  loadCustomers,required TResult Function( int id)  deleteCustomer,required TResult Function( String cpf)  findCustomerByCpf,required TResult Function( Customer customer)  updateCustomer,}) {final _that = this;
switch (_that) {
case _RegisterCustomer():
return registerCustomer(_that.name,_that.cpf,_that.email,_that.phone,_that.address);case _LoadCustomers():
return loadCustomers();case _DeleteCustomer():
return deleteCustomer(_that.id);case _FindCustomerByCpf():
return findCustomerByCpf(_that.cpf);case _UpdateCustomer():
return updateCustomer(_that.customer);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String name,  String cpf,  String email,  String phone,  String address)?  registerCustomer,TResult? Function()?  loadCustomers,TResult? Function( int id)?  deleteCustomer,TResult? Function( String cpf)?  findCustomerByCpf,TResult? Function( Customer customer)?  updateCustomer,}) {final _that = this;
switch (_that) {
case _RegisterCustomer() when registerCustomer != null:
return registerCustomer(_that.name,_that.cpf,_that.email,_that.phone,_that.address);case _LoadCustomers() when loadCustomers != null:
return loadCustomers();case _DeleteCustomer() when deleteCustomer != null:
return deleteCustomer(_that.id);case _FindCustomerByCpf() when findCustomerByCpf != null:
return findCustomerByCpf(_that.cpf);case _UpdateCustomer() when updateCustomer != null:
return updateCustomer(_that.customer);case _:
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


class _DeleteCustomer implements CustomerBlocEvent {
  const _DeleteCustomer({required this.id});
  

 final  int id;

/// Create a copy of CustomerBlocEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteCustomerCopyWith<_DeleteCustomer> get copyWith => __$DeleteCustomerCopyWithImpl<_DeleteCustomer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteCustomer&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'CustomerBlocEvent.deleteCustomer(id: $id)';
}


}

/// @nodoc
abstract mixin class _$DeleteCustomerCopyWith<$Res> implements $CustomerBlocEventCopyWith<$Res> {
  factory _$DeleteCustomerCopyWith(_DeleteCustomer value, $Res Function(_DeleteCustomer) _then) = __$DeleteCustomerCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class __$DeleteCustomerCopyWithImpl<$Res>
    implements _$DeleteCustomerCopyWith<$Res> {
  __$DeleteCustomerCopyWithImpl(this._self, this._then);

  final _DeleteCustomer _self;
  final $Res Function(_DeleteCustomer) _then;

/// Create a copy of CustomerBlocEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_DeleteCustomer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _FindCustomerByCpf implements CustomerBlocEvent {
  const _FindCustomerByCpf({required this.cpf});
  

 final  String cpf;

/// Create a copy of CustomerBlocEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FindCustomerByCpfCopyWith<_FindCustomerByCpf> get copyWith => __$FindCustomerByCpfCopyWithImpl<_FindCustomerByCpf>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FindCustomerByCpf&&(identical(other.cpf, cpf) || other.cpf == cpf));
}


@override
int get hashCode => Object.hash(runtimeType,cpf);

@override
String toString() {
  return 'CustomerBlocEvent.findCustomerByCpf(cpf: $cpf)';
}


}

/// @nodoc
abstract mixin class _$FindCustomerByCpfCopyWith<$Res> implements $CustomerBlocEventCopyWith<$Res> {
  factory _$FindCustomerByCpfCopyWith(_FindCustomerByCpf value, $Res Function(_FindCustomerByCpf) _then) = __$FindCustomerByCpfCopyWithImpl;
@useResult
$Res call({
 String cpf
});




}
/// @nodoc
class __$FindCustomerByCpfCopyWithImpl<$Res>
    implements _$FindCustomerByCpfCopyWith<$Res> {
  __$FindCustomerByCpfCopyWithImpl(this._self, this._then);

  final _FindCustomerByCpf _self;
  final $Res Function(_FindCustomerByCpf) _then;

/// Create a copy of CustomerBlocEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cpf = null,}) {
  return _then(_FindCustomerByCpf(
cpf: null == cpf ? _self.cpf : cpf // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UpdateCustomer implements CustomerBlocEvent {
  const _UpdateCustomer({required this.customer});
  

 final  Customer customer;

/// Create a copy of CustomerBlocEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCustomerCopyWith<_UpdateCustomer> get copyWith => __$UpdateCustomerCopyWithImpl<_UpdateCustomer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateCustomer&&(identical(other.customer, customer) || other.customer == customer));
}


@override
int get hashCode => Object.hash(runtimeType,customer);

@override
String toString() {
  return 'CustomerBlocEvent.updateCustomer(customer: $customer)';
}


}

/// @nodoc
abstract mixin class _$UpdateCustomerCopyWith<$Res> implements $CustomerBlocEventCopyWith<$Res> {
  factory _$UpdateCustomerCopyWith(_UpdateCustomer value, $Res Function(_UpdateCustomer) _then) = __$UpdateCustomerCopyWithImpl;
@useResult
$Res call({
 Customer customer
});




}
/// @nodoc
class __$UpdateCustomerCopyWithImpl<$Res>
    implements _$UpdateCustomerCopyWith<$Res> {
  __$UpdateCustomerCopyWithImpl(this._self, this._then);

  final _UpdateCustomer _self;
  final $Res Function(_UpdateCustomer) _then;

/// Create a copy of CustomerBlocEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customer = null,}) {
  return _then(_UpdateCustomer(
customer: null == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as Customer,
  ));
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _CustomersLoaded value)?  customersLoaded,TResult Function( _CustomerError value)?  customerError,TResult Function( _CustomerFound value)?  customerFound,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _CustomersLoaded() when customersLoaded != null:
return customersLoaded(_that);case _CustomerError() when customerError != null:
return customerError(_that);case _CustomerFound() when customerFound != null:
return customerFound(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _CustomersLoaded value)  customersLoaded,required TResult Function( _CustomerError value)  customerError,required TResult Function( _CustomerFound value)  customerFound,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _CustomersLoaded():
return customersLoaded(_that);case _CustomerError():
return customerError(_that);case _CustomerFound():
return customerFound(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _CustomersLoaded value)?  customersLoaded,TResult? Function( _CustomerError value)?  customerError,TResult? Function( _CustomerFound value)?  customerFound,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _CustomersLoaded() when customersLoaded != null:
return customersLoaded(_that);case _CustomerError() when customerError != null:
return customerError(_that);case _CustomerFound() when customerFound != null:
return customerFound(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( Map<int, Customer> customers)?  customersLoaded,TResult Function( String message)?  customerError,TResult Function( Customer customer)?  customerFound,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _CustomersLoaded() when customersLoaded != null:
return customersLoaded(_that.customers);case _CustomerError() when customerError != null:
return customerError(_that.message);case _CustomerFound() when customerFound != null:
return customerFound(_that.customer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( Map<int, Customer> customers)  customersLoaded,required TResult Function( String message)  customerError,required TResult Function( Customer customer)  customerFound,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _CustomersLoaded():
return customersLoaded(_that.customers);case _CustomerError():
return customerError(_that.message);case _CustomerFound():
return customerFound(_that.customer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( Map<int, Customer> customers)?  customersLoaded,TResult? Function( String message)?  customerError,TResult? Function( Customer customer)?  customerFound,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _CustomersLoaded() when customersLoaded != null:
return customersLoaded(_that.customers);case _CustomerError() when customerError != null:
return customerError(_that.message);case _CustomerFound() when customerFound != null:
return customerFound(_that.customer);case _:
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
  const _CustomersLoaded({required final  Map<int, Customer> customers}): _customers = customers;
  

 final  Map<int, Customer> _customers;
 Map<int, Customer> get customers {
  if (_customers is EqualUnmodifiableMapView) return _customers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_customers);
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
 Map<int, Customer> customers
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
as Map<int, Customer>,
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

/// @nodoc


class _CustomerFound implements CustomerBlocState {
  const _CustomerFound({required this.customer});
  

 final  Customer customer;

/// Create a copy of CustomerBlocState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerFoundCopyWith<_CustomerFound> get copyWith => __$CustomerFoundCopyWithImpl<_CustomerFound>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerFound&&(identical(other.customer, customer) || other.customer == customer));
}


@override
int get hashCode => Object.hash(runtimeType,customer);

@override
String toString() {
  return 'CustomerBlocState.customerFound(customer: $customer)';
}


}

/// @nodoc
abstract mixin class _$CustomerFoundCopyWith<$Res> implements $CustomerBlocStateCopyWith<$Res> {
  factory _$CustomerFoundCopyWith(_CustomerFound value, $Res Function(_CustomerFound) _then) = __$CustomerFoundCopyWithImpl;
@useResult
$Res call({
 Customer customer
});




}
/// @nodoc
class __$CustomerFoundCopyWithImpl<$Res>
    implements _$CustomerFoundCopyWith<$Res> {
  __$CustomerFoundCopyWithImpl(this._self, this._then);

  final _CustomerFound _self;
  final $Res Function(_CustomerFound) _then;

/// Create a copy of CustomerBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customer = null,}) {
  return _then(_CustomerFound(
customer: null == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as Customer,
  ));
}


}

// dart format on
