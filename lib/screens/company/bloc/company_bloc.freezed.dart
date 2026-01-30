// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompanyBlocEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyBlocEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyBlocEvent()';
}


}

/// @nodoc
class $CompanyBlocEventCopyWith<$Res>  {
$CompanyBlocEventCopyWith(CompanyBlocEvent _, $Res Function(CompanyBlocEvent) __);
}


/// Adds pattern-matching-related methods to [CompanyBlocEvent].
extension CompanyBlocEventPatterns on CompanyBlocEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _RegisterCompany value)?  registerCustomer,TResult Function( _LoadCompanies value)?  loadCustomers,TResult Function( _DeleteCompany value)?  deleteCustomer,TResult Function( _FindCompanyByCnpj value)?  findCustomerByCnpj,TResult Function( _UpdateCompany value)?  updateCustomer,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterCompany() when registerCompany != null:
return registerCustomer(_that);case _LoadCompanies() when loadCustomers != null:
return loadCustomers(_that);case _DeleteCompany() when deleteCompany != null:
return deleteCustomer(_that);case _FindCompanyByCnpj() when findCustomerByCnpj != null:
return findCustomerByCnpj(_that);case _UpdateCompany() when updateCompany != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _RegisterCompany value)  registerCustomer,required TResult Function( _LoadCompanies value)  loadCustomers,required TResult Function( _DeleteCompany value)  deleteCustomer,required TResult Function( _FindCompanyByCnpj value)  findCustomerByCnpj,required TResult Function( _UpdateCompany value)  updateCustomer,}){
final _that = this;
switch (_that) {
case _RegisterCompany():
return registerCustomer(_that);case _LoadCompanies():
return loadCustomers(_that);case _DeleteCompany():
return deleteCustomer(_that);case _FindCompanyByCnpj():
return findCustomerByCnpj(_that);case _UpdateCompany():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _RegisterCompany value)?  registerCustomer,TResult? Function( _LoadCompanies value)?  loadCustomers,TResult? Function( _DeleteCompany value)?  deleteCustomer,TResult? Function( _FindCompanyByCnpj value)?  findCustomerByCnpj,TResult? Function( _UpdateCompany value)?  updateCustomer,}){
final _that = this;
switch (_that) {
case _RegisterCompany() when registerCompany != null:
return registerCustomer(_that);case _LoadCompanies() when loadCustomers != null:
return loadCustomers(_that);case _DeleteCompany() when deleteCompany != null:
return deleteCustomer(_that);case _FindCompanyByCnpj() when findCustomerByCnpj != null:
return findCustomerByCnpj(_that);case _UpdateCompany() when updateCompany != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String corporateName,  String cnpj,  String email,  String street,  String zipCode,  String neighborhood,  String city)?  registerCustomer,TResult Function()?  loadCustomers,TResult Function( int id)?  deleteCustomer,TResult Function( String cnpj)?  findCustomerByCnpj,TResult Function( Company company)?  updateCustomer,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterCompany() when registerCompany != null:
return registerCustomer(_that.corporateName,_that.cnpj,_that.email,_that.street,_that.zipCode);case _LoadCompanies() when loadCustomers != null:
return loadCustomers();case _DeleteCompany() when deleteCompany != null:
return deleteCustomer(_that.id);case _FindCompanyByCnpj() when findCustomerByCnpj != null:
return findCustomerByCnpj(_that.cnpj);case _UpdateCompany() when updateCompany != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String corporateName,  String cnpj,  String email,  String street,  String zipCode,  String neighborhood,  String city)  registerCustomer,required TResult Function()  loadCustomers,required TResult Function( int id)  deleteCustomer,required TResult Function( String cnpj)  findCustomerByCnpj,required TResult Function( Company company)  updateCustomer,}) {final _that = this;
switch (_that) {
case _RegisterCompany():
return registerCustomer(_that.corporateName,_that.cnpj,_that.email,_that.street,_that.zipCode);case _LoadCompanies():
return loadCustomers();case _DeleteCompany():
return deleteCustomer(_that.id);case _FindCompanyByCnpj():
return findCustomerByCnpj(_that.cnpj);case _UpdateCompany():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String corporateName,  String cnpj,  String email,  String street,  String zipCode,  String neighborhood,  String city)?  registerCustomer,TResult? Function()?  loadCustomers,TResult? Function( int id)?  deleteCustomer,TResult? Function( String cnpj)?  findCustomerByCnpj,TResult? Function( Company company)?  updateCustomer,}) {final _that = this;
switch (_that) {
case _RegisterCompany() when registerCompany != null:
return registerCustomer(_that.corporateName,_that.cnpj,_that.email,_that.street,_that.zipCode);case _LoadCompanies() when loadCustomers != null:
return loadCustomers();case _DeleteCompany() when deleteCompany != null:
return deleteCustomer(_that.id);case _FindCompanyByCnpj() when findCustomerByCnpj != null:
return findCustomerByCnpj(_that.cnpj);case _UpdateCompany() when updateCompany != null:
return updateCustomer(_that.customer);case _:
  return null;

}
}

}

/// @nodoc


class _RegisterCompany implements CompanyBlocEvent {
  const _RegisterCompany({required this.corporateName, required this.cnpj, required this.email, required this.street, required this.zipCode, required this.neighborhood, required this.city});
  

 final  String corporateName;
 final  String cnpj;
 final  String email;
 final  String street;
 final  String zipCode;
 final  String neighborhood;
 final  String city;

/// Create a copy of CompanyBlocEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterCompanyCopyWith<_RegisterCompany> get copyWith => __$RegisterCompanyCopyWithImpl<_RegisterCompany>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterCompany&&(identical(other.corporateName, corporateName) || other.corporateName == corporateName)&&(identical(other.cnpj, cnpj) || other.cnpj == cnpj)&&(identical(other.email, email) || other.email == email)&&(identical(other.street, street) || other.street == street)&&(identical(other.zipCode, zipCode) || other.zipCode == zipCode) && (identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood) && (identical(other.city, city) || other.city == city));
}


@override
int get hashCode => Object.hash(runtimeType,name,cnpj,email,phone,address);

@override
String toString() {
  return 'CompanyBlocEvent.registerCustomer(name: $name, cnpj: $cnpj, email: $email, phone: $phone, address: $address)';
}


}

/// @nodoc
abstract mixin class _$RegisterCompanyCopyWith<$Res> implements $CompanyBlocEventCopyWith<$Res> {
  factory _$RegisterCompanyCopyWith(_RegisterCompany value, $Res Function(_RegisterCompany) _then) = __$RegisterCompanyCopyWithImpl;
@useResult
$Res call({
 String name, String cnpj, String email, String phone, String address
});




}
/// @nodoc
class __$RegisterCompanyCopyWithImpl<$Res>
    implements _$RegisterCompanyCopyWith<$Res> {
  __$RegisterCompanyCopyWithImpl(this._self, this._then);

  final _RegisterCompany _self;
  final $Res Function(_RegisterCompany) _then;

/// Create a copy of CompanyBlocEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? cnpj = null,Object? email = null,Object? phone = null,Object? address = null,}) {
  return _then(_RegisterCompany(
corporateName: null == corporateName ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,cnpj: null == cnpj ? _self.cnpj : cnpj // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,street: null == street ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,zipCode: null == zipCode ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadCompanies implements CompanyBlocEvent {
  const _LoadCompanies();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadCompanies);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyBlocEvent.loadCustomers()';
}


}




/// @nodoc


class _DeleteCompany implements CompanyBlocEvent {
  const _DeleteCompany({required this.id});
  

 final  int id;

/// Create a copy of CompanyBlocEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteCompanyCopyWith<_DeleteCompany> get copyWith => __$DeleteCompanyCopyWithImpl<_DeleteCompany>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteCompany&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'CompanyBlocEvent.deleteCustomer(id: $id)';
}


}

/// @nodoc
abstract mixin class _$DeleteCompanyCopyWith<$Res> implements $CompanyBlocEventCopyWith<$Res> {
  factory _$DeleteCompanyCopyWith(_DeleteCompany value, $Res Function(_DeleteCompany) _then) = __$DeleteCompanyCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class __$DeleteCompanyCopyWithImpl<$Res>
    implements _$DeleteCompanyCopyWith<$Res> {
  __$DeleteCompanyCopyWithImpl(this._self, this._then);

  final _DeleteCompany _self;
  final $Res Function(_DeleteCompany) _then;

/// Create a copy of CompanyBlocEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_DeleteCompany(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _FindCompanyByCnpj implements CompanyBlocEvent {
  const _FindCompanyByCnpj({required this.cnpj});
  

 final  String cnpj;

/// Create a copy of CompanyBlocEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FindCompanyByCnpjCopyWith<_FindCompanyByCnpj> get copyWith => __$FindCompanyByCnpjCopyWithImpl<_FindCompanyByCnpj>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FindCompanyByCnpj&&(identical(other.cnpj, cnpj) || other.cnpj == cnpj));
}


@override
int get hashCode => Object.hash(runtimeType,cnpj);

@override
String toString() {
  return 'CompanyBlocEvent.findCustomerByCnpj(cnpj: $cnpj)';
}


}

/// @nodoc
abstract mixin class _$FindCompanyByCnpjCopyWith<$Res> implements $CompanyBlocEventCopyWith<$Res> {
  factory _$FindCompanyByCnpjCopyWith(_FindCompanyByCnpj value, $Res Function(_FindCompanyByCnpj) _then) = __$FindCompanyByCnpjCopyWithImpl;
@useResult
$Res call({
 String cnpj
});




}
/// @nodoc
class __$FindCompanyByCnpjCopyWithImpl<$Res>
    implements _$FindCompanyByCnpjCopyWith<$Res> {
  __$FindCompanyByCnpjCopyWithImpl(this._self, this._then);

  final _FindCompanyByCnpj _self;
  final $Res Function(_FindCompanyByCnpj) _then;

/// Create a copy of CompanyBlocEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cnpj = null,}) {
  return _then(_FindCompanyByCnpj(
cnpj: null == cnpj ? _self.cnpj : cnpj // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UpdateCompany implements CompanyBlocEvent {
  const _UpdateCompany({required this.customer});
  

 final  Company customer;

/// Create a copy of CompanyBlocEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCompanyCopyWith<_UpdateCompany> get copyWith => __$UpdateCompanyCopyWithImpl<_UpdateCompany>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateCompany&&(identical(other.customer, company) || other.customer == company));
}


@override
int get hashCode => Object.hash(runtimeType,customer);

@override
String toString() {
  return 'CompanyBlocEvent.updateCustomer(customer: $customer)';
}


}

/// @nodoc
abstract mixin class _$UpdateCompanyCopyWith<$Res> implements $CompanyBlocEventCopyWith<$Res> {
  factory _$UpdateCompanyCopyWith(_UpdateCompany value, $Res Function(_UpdateCompany) _then) = __$UpdateCompanyCopyWithImpl;
@useResult
$Res call({
 Company customer
});




}
/// @nodoc
class __$UpdateCompanyCopyWithImpl<$Res>
    implements _$UpdateCompanyCopyWith<$Res> {
  __$UpdateCompanyCopyWithImpl(this._self, this._then);

  final _UpdateCompany _self;
  final $Res Function(_UpdateCompany) _then;

/// Create a copy of CompanyBlocEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customer = null,}) {
  return _then(_UpdateCompany(
customer: null == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as Customer,
  ));
}


}

/// @nodoc
mixin _$CompanyBlocState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyBlocState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyBlocState()';
}


}

/// @nodoc
class $CompanyBlocStateCopyWith<$Res>  {
$CompanyBlocStateCopyWith(CompanyBlocState _, $Res Function(CompanyBlocState) __);
}


/// Adds pattern-matching-related methods to [CompanyBlocState].
extension CompanyBlocStatePatterns on CompanyBlocState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _CompaniesLoaded value)?  companiesLoaded,TResult Function( _CustomerError value)?  customerError,TResult Function( _CustomerFound value)?  customerFound,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _CompaniesLoaded() when companiesLoaded != null:
return companiesLoaded(_that);case _CustomerError() when customerError != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _CompaniesLoaded value)  companiesLoaded,required TResult Function( _CustomerError value)  customerError,required TResult Function( _CustomerFound value)  customerFound,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _CompaniesLoaded():
return companiesLoaded(_that);case _CustomerError():
return customerError(_that);case _CustomerFound():
return customerFound(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _CompaniesLoaded value)?  companiesLoaded,TResult? Function( _CustomerError value)?  customerError,TResult? Function( _CustomerFound value)?  customerFound,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _CompaniesLoaded() when companiesLoaded != null:
return companiesLoaded(_that);case _CustomerError() when customerError != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( Map<int, Customer> companies,  EnumStateCustomerLoaded stateType)?  companiesLoaded,TResult Function( String message)?  customerError,TResult Function( Company company)?  customerFound,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _CompaniesLoaded() when companiesLoaded != null:
return companiesLoaded(_that.companies,_that.stateType);case _CustomerError() when customerError != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( Map<int, Customer> companies,  EnumStateCustomerLoaded stateType)  companiesLoaded,required TResult Function( String message)  customerError,required TResult Function( Company company)  customerFound,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _CompaniesLoaded():
return companiesLoaded(_that.companies,_that.stateType);case _CustomerError():
return customerError(_that.message);case _CustomerFound():
return customerFound(_that.customer);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( Map<int, Customer> companies,  EnumStateCustomerLoaded stateType)?  companiesLoaded,TResult? Function( String message)?  customerError,TResult? Function( Company company)?  customerFound,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _CompaniesLoaded() when companiesLoaded != null:
return companiesLoaded(_that.companies,_that.stateType);case _CustomerError() when customerError != null:
return customerError(_that.message);case _CustomerFound() when customerFound != null:
return customerFound(_that.customer);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CompanyBlocState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyBlocState.initial()';
}


}




/// @nodoc


class _Loading implements CompanyBlocState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompanyBlocState.loading()';
}


}




/// @nodoc


class _CompaniesLoaded implements CompanyBlocState {
  const _CompaniesLoaded({required final  Map<int, Customer> companies, required this.stateType}): _companies = companies;
  

 final  Map<int, Customer> _companies;
 Map<int, Customer> get companies {
  if (_companies is EqualUnmodifiableMapView) return _companies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_companies);
}

 final  EnumStateCustomerLoaded stateType;

/// Create a copy of CompanyBlocState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompaniesLoadedCopyWith<_CompaniesLoaded> get copyWith => __$CompaniesLoadedCopyWithImpl<_CompaniesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompaniesLoaded&&const DeepCollectionEquality().equals(other._companies, _companies)&&(identical(other.stateType, stateType) || other.stateType == stateType));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_companies),stateType);

@override
String toString() {
  return 'CompanyBlocState.companiesLoaded(companies: $companies, stateType: $stateType)';
}


}

/// @nodoc
abstract mixin class _$CompaniesLoadedCopyWith<$Res> implements $CompanyBlocStateCopyWith<$Res> {
  factory _$CompaniesLoadedCopyWith(_CompaniesLoaded value, $Res Function(_CompaniesLoaded) _then) = __$CompaniesLoadedCopyWithImpl;
@useResult
$Res call({
 Map<int, Customer> companies, EnumStateCustomerLoaded stateType
});




}
/// @nodoc
class __$CompaniesLoadedCopyWithImpl<$Res>
    implements _$CompaniesLoadedCopyWith<$Res> {
  __$CompaniesLoadedCopyWithImpl(this._self, this._then);

  final _CompaniesLoaded _self;
  final $Res Function(_CompaniesLoaded) _then;

/// Create a copy of CompanyBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? companies = null,Object? stateType = null,}) {
  return _then(_CompaniesLoaded(
companies: null == companies ? _self._companies : companies // ignore: cast_nullable_to_non_nullable
as Map<int, Customer>,stateType: null == stateType ? _self.stateType : stateType // ignore: cast_nullable_to_non_nullable
as EnumStateCustomerLoaded,
  ));
}


}

/// @nodoc


class _CustomerError implements CompanyBlocState {
  const _CustomerError({required this.message});
  

 final  String message;

/// Create a copy of CompanyBlocState
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
  return 'CompanyBlocState.customerError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$CustomerErrorCopyWith<$Res> implements $CompanyBlocStateCopyWith<$Res> {
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

/// Create a copy of CompanyBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_CustomerError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CustomerFound implements CompanyBlocState {
  const _CustomerFound({required this.customer});
  

 final  Company customer;

/// Create a copy of CompanyBlocState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CustomerFoundCopyWith<_CustomerFound> get copyWith => __$CustomerFoundCopyWithImpl<_CustomerFound>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CustomerFound&&(identical(other.customer, company) || other.customer == company));
}


@override
int get hashCode => Object.hash(runtimeType,customer);

@override
String toString() {
  return 'CompanyBlocState.customerFound(customer: $customer)';
}


}

/// @nodoc
abstract mixin class _$CustomerFoundCopyWith<$Res> implements $CompanyBlocStateCopyWith<$Res> {
  factory _$CustomerFoundCopyWith(_CustomerFound value, $Res Function(_CustomerFound) _then) = __$CustomerFoundCopyWithImpl;
@useResult
$Res call({
 Company customer
});




}
/// @nodoc
class __$CustomerFoundCopyWithImpl<$Res>
    implements _$CustomerFoundCopyWith<$Res> {
  __$CustomerFoundCopyWithImpl(this._self, this._then);

  final _CustomerFound _self;
  final $Res Function(_CustomerFound) _then;

/// Create a copy of CompanyBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? customer = null,}) {
  return _then(_CustomerFound(
customer: null == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as Customer,
  ));
}


}

// dart format on
