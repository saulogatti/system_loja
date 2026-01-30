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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadCompanies value)?  loadCompanies,TResult Function( _RegisterCompany value)?  registerCompany,TResult Function( _DeleteCompany value)?  deleteCompany,TResult Function( _FindCompanyByCnpj value)?  findCompanyByCnpj,TResult Function( _UpdateCompany value)?  updateCompany,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadCompanies() when loadCompanies != null:
return loadCompanies(_that);case _RegisterCompany() when registerCompany != null:
return registerCompany(_that);case _DeleteCompany() when deleteCompany != null:
return deleteCompany(_that);case _FindCompanyByCnpj() when findCompanyByCnpj != null:
return findCompanyByCnpj(_that);case _UpdateCompany() when updateCompany != null:
return updateCompany(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadCompanies value)  loadCompanies,required TResult Function( _RegisterCompany value)  registerCompany,required TResult Function( _DeleteCompany value)  deleteCompany,required TResult Function( _FindCompanyByCnpj value)  findCompanyByCnpj,required TResult Function( _UpdateCompany value)  updateCompany,}){
final _that = this;
switch (_that) {
case _LoadCompanies():
return loadCompanies(_that);case _RegisterCompany():
return registerCompany(_that);case _DeleteCompany():
return deleteCompany(_that);case _FindCompanyByCnpj():
return findCompanyByCnpj(_that);case _UpdateCompany():
return updateCompany(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadCompanies value)?  loadCompanies,TResult? Function( _RegisterCompany value)?  registerCompany,TResult? Function( _DeleteCompany value)?  deleteCompany,TResult? Function( _FindCompanyByCnpj value)?  findCompanyByCnpj,TResult? Function( _UpdateCompany value)?  updateCompany,}){
final _that = this;
switch (_that) {
case _LoadCompanies() when loadCompanies != null:
return loadCompanies(_that);case _RegisterCompany() when registerCompany != null:
return registerCompany(_that);case _DeleteCompany() when deleteCompany != null:
return deleteCompany(_that);case _FindCompanyByCnpj() when findCompanyByCnpj != null:
return findCompanyByCnpj(_that);case _UpdateCompany() when updateCompany != null:
return updateCompany(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadCompanies,TResult Function( String corporateName,  String cnpj,  String email,  String street,  String zipCode,  String neighborhood,  String city)?  registerCompany,TResult Function( int id)?  deleteCompany,TResult Function( String cnpj)?  findCompanyByCnpj,TResult Function( Company company)?  updateCompany,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadCompanies() when loadCompanies != null:
return loadCompanies();case _RegisterCompany() when registerCompany != null:
return registerCompany(_that.corporateName,_that.cnpj,_that.email,_that.street,_that.zipCode,_that.neighborhood,_that.city);case _DeleteCompany() when deleteCompany != null:
return deleteCompany(_that.id);case _FindCompanyByCnpj() when findCompanyByCnpj != null:
return findCompanyByCnpj(_that.cnpj);case _UpdateCompany() when updateCompany != null:
return updateCompany(_that.company);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadCompanies,required TResult Function( String corporateName,  String cnpj,  String email,  String street,  String zipCode,  String neighborhood,  String city)  registerCompany,required TResult Function( int id)  deleteCompany,required TResult Function( String cnpj)  findCompanyByCnpj,required TResult Function( Company company)  updateCompany,}) {final _that = this;
switch (_that) {
case _LoadCompanies():
return loadCompanies();case _RegisterCompany():
return registerCompany(_that.corporateName,_that.cnpj,_that.email,_that.street,_that.zipCode,_that.neighborhood,_that.city);case _DeleteCompany():
return deleteCompany(_that.id);case _FindCompanyByCnpj():
return findCompanyByCnpj(_that.cnpj);case _UpdateCompany():
return updateCompany(_that.company);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadCompanies,TResult? Function( String corporateName,  String cnpj,  String email,  String street,  String zipCode,  String neighborhood,  String city)?  registerCompany,TResult? Function( int id)?  deleteCompany,TResult? Function( String cnpj)?  findCompanyByCnpj,TResult? Function( Company company)?  updateCompany,}) {final _that = this;
switch (_that) {
case _LoadCompanies() when loadCompanies != null:
return loadCompanies();case _RegisterCompany() when registerCompany != null:
return registerCompany(_that.corporateName,_that.cnpj,_that.email,_that.street,_that.zipCode,_that.neighborhood,_that.city);case _DeleteCompany() when deleteCompany != null:
return deleteCompany(_that.id);case _FindCompanyByCnpj() when findCompanyByCnpj != null:
return findCompanyByCnpj(_that.cnpj);case _UpdateCompany() when updateCompany != null:
return updateCompany(_that.company);case _:
  return null;

}
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
  return 'CompanyBlocEvent.loadCompanies()';
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterCompany&&(identical(other.corporateName, corporateName) || other.corporateName == corporateName)&&(identical(other.cnpj, cnpj) || other.cnpj == cnpj)&&(identical(other.email, email) || other.email == email)&&(identical(other.street, street) || other.street == street)&&(identical(other.zipCode, zipCode) || other.zipCode == zipCode)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.city, city) || other.city == city));
}


@override
int get hashCode => Object.hash(runtimeType,corporateName,cnpj,email,street,zipCode,neighborhood,city);

@override
String toString() {
  return 'CompanyBlocEvent.registerCompany(corporateName: $corporateName, cnpj: $cnpj, email: $email, street: $street, zipCode: $zipCode, neighborhood: $neighborhood, city: $city)';
}


}

/// @nodoc
abstract mixin class _$RegisterCompanyCopyWith<$Res> implements $CompanyBlocEventCopyWith<$Res> {
  factory _$RegisterCompanyCopyWith(_RegisterCompany value, $Res Function(_RegisterCompany) _then) = __$RegisterCompanyCopyWithImpl;
@useResult
$Res call({
 String corporateName, String cnpj, String email, String street, String zipCode, String neighborhood, String city
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
@pragma('vm:prefer-inline') $Res call({Object? corporateName = null,Object? cnpj = null,Object? email = null,Object? street = null,Object? zipCode = null,Object? neighborhood = null,Object? city = null,}) {
  return _then(_RegisterCompany(
corporateName: null == corporateName ? _self.corporateName : corporateName // ignore: cast_nullable_to_non_nullable
as String,cnpj: null == cnpj ? _self.cnpj : cnpj // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,zipCode: null == zipCode ? _self.zipCode : zipCode // ignore: cast_nullable_to_non_nullable
as String,neighborhood: null == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,
  ));
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
  return 'CompanyBlocEvent.deleteCompany(id: $id)';
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
  return 'CompanyBlocEvent.findCompanyByCnpj(cnpj: $cnpj)';
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
  const _UpdateCompany({required this.company});
  

 final  Company company;

/// Create a copy of CompanyBlocEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateCompanyCopyWith<_UpdateCompany> get copyWith => __$UpdateCompanyCopyWithImpl<_UpdateCompany>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateCompany&&(identical(other.company, company) || other.company == company));
}


@override
int get hashCode => Object.hash(runtimeType,company);

@override
String toString() {
  return 'CompanyBlocEvent.updateCompany(company: $company)';
}


}

/// @nodoc
abstract mixin class _$UpdateCompanyCopyWith<$Res> implements $CompanyBlocEventCopyWith<$Res> {
  factory _$UpdateCompanyCopyWith(_UpdateCompany value, $Res Function(_UpdateCompany) _then) = __$UpdateCompanyCopyWithImpl;
@useResult
$Res call({
 Company company
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
@pragma('vm:prefer-inline') $Res call({Object? company = null,}) {
  return _then(_UpdateCompany(
company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as Company,
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _CompaniesLoaded value)?  companiesLoaded,TResult Function( _CompanyFound value)?  companyFound,TResult Function( _CompanyError value)?  companyError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _CompaniesLoaded() when companiesLoaded != null:
return companiesLoaded(_that);case _CompanyFound() when companyFound != null:
return companyFound(_that);case _CompanyError() when companyError != null:
return companyError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _CompaniesLoaded value)  companiesLoaded,required TResult Function( _CompanyFound value)  companyFound,required TResult Function( _CompanyError value)  companyError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _CompaniesLoaded():
return companiesLoaded(_that);case _CompanyFound():
return companyFound(_that);case _CompanyError():
return companyError(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _CompaniesLoaded value)?  companiesLoaded,TResult? Function( _CompanyFound value)?  companyFound,TResult? Function( _CompanyError value)?  companyError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _CompaniesLoaded() when companiesLoaded != null:
return companiesLoaded(_that);case _CompanyFound() when companyFound != null:
return companyFound(_that);case _CompanyError() when companyError != null:
return companyError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( Map<int, Company> companies,  EnumStateCompanyLoaded stateType)?  companiesLoaded,TResult Function( Company company)?  companyFound,TResult Function( String message)?  companyError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _CompaniesLoaded() when companiesLoaded != null:
return companiesLoaded(_that.companies,_that.stateType);case _CompanyFound() when companyFound != null:
return companyFound(_that.company);case _CompanyError() when companyError != null:
return companyError(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( Map<int, Company> companies,  EnumStateCompanyLoaded stateType)  companiesLoaded,required TResult Function( Company company)  companyFound,required TResult Function( String message)  companyError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _CompaniesLoaded():
return companiesLoaded(_that.companies,_that.stateType);case _CompanyFound():
return companyFound(_that.company);case _CompanyError():
return companyError(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( Map<int, Company> companies,  EnumStateCompanyLoaded stateType)?  companiesLoaded,TResult? Function( Company company)?  companyFound,TResult? Function( String message)?  companyError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _CompaniesLoaded() when companiesLoaded != null:
return companiesLoaded(_that.companies,_that.stateType);case _CompanyFound() when companyFound != null:
return companyFound(_that.company);case _CompanyError() when companyError != null:
return companyError(_that.message);case _:
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
  const _CompaniesLoaded({required final  Map<int, Company> companies, required this.stateType}): _companies = companies;
  

 final  Map<int, Company> _companies;
 Map<int, Company> get companies {
  if (_companies is EqualUnmodifiableMapView) return _companies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_companies);
}

 final  EnumStateCompanyLoaded stateType;

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
 Map<int, Company> companies, EnumStateCompanyLoaded stateType
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
as Map<int, Company>,stateType: null == stateType ? _self.stateType : stateType // ignore: cast_nullable_to_non_nullable
as EnumStateCompanyLoaded,
  ));
}


}

/// @nodoc


class _CompanyFound implements CompanyBlocState {
  const _CompanyFound({required this.company});
  

 final  Company company;

/// Create a copy of CompanyBlocState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyFoundCopyWith<_CompanyFound> get copyWith => __$CompanyFoundCopyWithImpl<_CompanyFound>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyFound&&(identical(other.company, company) || other.company == company));
}


@override
int get hashCode => Object.hash(runtimeType,company);

@override
String toString() {
  return 'CompanyBlocState.companyFound(company: $company)';
}


}

/// @nodoc
abstract mixin class _$CompanyFoundCopyWith<$Res> implements $CompanyBlocStateCopyWith<$Res> {
  factory _$CompanyFoundCopyWith(_CompanyFound value, $Res Function(_CompanyFound) _then) = __$CompanyFoundCopyWithImpl;
@useResult
$Res call({
 Company company
});




}
/// @nodoc
class __$CompanyFoundCopyWithImpl<$Res>
    implements _$CompanyFoundCopyWith<$Res> {
  __$CompanyFoundCopyWithImpl(this._self, this._then);

  final _CompanyFound _self;
  final $Res Function(_CompanyFound) _then;

/// Create a copy of CompanyBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? company = null,}) {
  return _then(_CompanyFound(
company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as Company,
  ));
}


}

/// @nodoc


class _CompanyError implements CompanyBlocState {
  const _CompanyError({required this.message});
  

 final  String message;

/// Create a copy of CompanyBlocState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyErrorCopyWith<_CompanyError> get copyWith => __$CompanyErrorCopyWithImpl<_CompanyError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CompanyBlocState.companyError(message: $message)';
}


}

/// @nodoc
abstract mixin class _$CompanyErrorCopyWith<$Res> implements $CompanyBlocStateCopyWith<$Res> {
  factory _$CompanyErrorCopyWith(_CompanyError value, $Res Function(_CompanyError) _then) = __$CompanyErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$CompanyErrorCopyWithImpl<$Res>
    implements _$CompanyErrorCopyWith<$Res> {
  __$CompanyErrorCopyWithImpl(this._self, this._then);

  final _CompanyError _self;
  final $Res Function(_CompanyError) _then;

/// Create a copy of CompanyBlocState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_CompanyError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
