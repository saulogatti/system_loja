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

 String get name; String get cpf; String get email; String get phone; String get address;
/// Create a copy of CustomerBlocEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CustomerBlocEventCopyWith<CustomerBlocEvent> get copyWith => _$CustomerBlocEventCopyWithImpl<CustomerBlocEvent>(this as CustomerBlocEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CustomerBlocEvent&&(identical(other.name, name) || other.name == name)&&(identical(other.cpf, cpf) || other.cpf == cpf)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address));
}


@override
int get hashCode => Object.hash(runtimeType,name,cpf,email,phone,address);

@override
String toString() {
  return 'CustomerBlocEvent(name: $name, cpf: $cpf, email: $email, phone: $phone, address: $address)';
}


}

/// @nodoc
abstract mixin class $CustomerBlocEventCopyWith<$Res>  {
  factory $CustomerBlocEventCopyWith(CustomerBlocEvent value, $Res Function(CustomerBlocEvent) _then) = _$CustomerBlocEventCopyWithImpl;
@useResult
$Res call({
 String name, String cpf, String email, String phone, String address
});




}
/// @nodoc
class _$CustomerBlocEventCopyWithImpl<$Res>
    implements $CustomerBlocEventCopyWith<$Res> {
  _$CustomerBlocEventCopyWithImpl(this._self, this._then);

  final CustomerBlocEvent _self;
  final $Res Function(CustomerBlocEvent) _then;

/// Create a copy of CustomerBlocEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? cpf = null,Object? email = null,Object? phone = null,Object? address = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cpf: null == cpf ? _self.cpf : cpf // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _RegisterCustomer value)?  registerCustomer,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterCustomer() when registerCustomer != null:
return registerCustomer(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _RegisterCustomer value)  registerCustomer,}){
final _that = this;
switch (_that) {
case _RegisterCustomer():
return registerCustomer(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _RegisterCustomer value)?  registerCustomer,}){
final _that = this;
switch (_that) {
case _RegisterCustomer() when registerCustomer != null:
return registerCustomer(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String name,  String cpf,  String email,  String phone,  String address)?  registerCustomer,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterCustomer() when registerCustomer != null:
return registerCustomer(_that.name,_that.cpf,_that.email,_that.phone,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String name,  String cpf,  String email,  String phone,  String address)  registerCustomer,}) {final _that = this;
switch (_that) {
case _RegisterCustomer():
return registerCustomer(_that.name,_that.cpf,_that.email,_that.phone,_that.address);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String name,  String cpf,  String email,  String phone,  String address)?  registerCustomer,}) {final _that = this;
switch (_that) {
case _RegisterCustomer() when registerCustomer != null:
return registerCustomer(_that.name,_that.cpf,_that.email,_that.phone,_that.address);case _:
  return null;

}
}

}

/// @nodoc


class _RegisterCustomer implements CustomerBlocEvent {
  const _RegisterCustomer({required this.name, required this.cpf, required this.email, required this.phone, required this.address});
  

@override final  String name;
@override final  String cpf;
@override final  String email;
@override final  String phone;
@override final  String address;

/// Create a copy of CustomerBlocEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
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
@override @useResult
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
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? cpf = null,Object? email = null,Object? phone = null,Object? address = null,}) {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _CustomerAdded value)?  customerAdded,TResult Function( _CustomerError value)?  customerError,TResult Function( _Initial value)?  initial,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CustomerAdded() when customerAdded != null:
return customerAdded(_that);case _CustomerError() when customerError != null:
return customerError(_that);case _Initial() when initial != null:
return initial(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _CustomerAdded value)  customerAdded,required TResult Function( _CustomerError value)  customerError,required TResult Function( _Initial value)  initial,}){
final _that = this;
switch (_that) {
case _CustomerAdded():
return customerAdded(_that);case _CustomerError():
return customerError(_that);case _Initial():
return initial(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _CustomerAdded value)?  customerAdded,TResult? Function( _CustomerError value)?  customerError,TResult? Function( _Initial value)?  initial,}){
final _that = this;
switch (_that) {
case _CustomerAdded() when customerAdded != null:
return customerAdded(_that);case _CustomerError() when customerError != null:
return customerError(_that);case _Initial() when initial != null:
return initial(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( Customer customer)?  customerAdded,TResult Function( String message)?  customerError,TResult Function()?  initial,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CustomerAdded() when customerAdded != null:
return customerAdded(_that.customer);case _CustomerError() when customerError != null:
return customerError(_that.message);case _Initial() when initial != null:
return initial();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( Customer customer)  customerAdded,required TResult Function( String message)  customerError,required TResult Function()  initial,}) {final _that = this;
switch (_that) {
case _CustomerAdded():
return customerAdded(_that.customer);case _CustomerError():
return customerError(_that.message);case _Initial():
return initial();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( Customer customer)?  customerAdded,TResult? Function( String message)?  customerError,TResult? Function()?  initial,}) {final _that = this;
switch (_that) {
case _CustomerAdded() when customerAdded != null:
return customerAdded(_that.customer);case _CustomerError() when customerError != null:
return customerError(_that.message);case _Initial() when initial != null:
return initial();case _:
  return null;

}
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




// dart format on
