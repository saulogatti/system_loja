// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent()';
}


}

/// @nodoc
class $HomeEventCopyWith<$Res>  {
$HomeEventCopyWith(HomeEvent _, $Res Function(HomeEvent) __);
}


/// Adds pattern-matching-related methods to [HomeEvent].
extension HomeEventPatterns on HomeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadSystemUserData value)?  loadSystemUserData,TResult Function( SaveSystemUserData value)?  saveSystemUserData,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadSystemUserData() when loadSystemUserData != null:
return loadSystemUserData(_that);case SaveSystemUserData() when saveSystemUserData != null:
return saveSystemUserData(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadSystemUserData value)  loadSystemUserData,required TResult Function( SaveSystemUserData value)  saveSystemUserData,}){
final _that = this;
switch (_that) {
case LoadSystemUserData():
return loadSystemUserData(_that);case SaveSystemUserData():
return saveSystemUserData(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadSystemUserData value)?  loadSystemUserData,TResult? Function( SaveSystemUserData value)?  saveSystemUserData,}){
final _that = this;
switch (_that) {
case LoadSystemUserData() when loadSystemUserData != null:
return loadSystemUserData(_that);case SaveSystemUserData() when saveSystemUserData != null:
return saveSystemUserData(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadSystemUserData,TResult Function( SystemUserData systemUserData)?  saveSystemUserData,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadSystemUserData() when loadSystemUserData != null:
return loadSystemUserData();case SaveSystemUserData() when saveSystemUserData != null:
return saveSystemUserData(_that.systemUserData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadSystemUserData,required TResult Function( SystemUserData systemUserData)  saveSystemUserData,}) {final _that = this;
switch (_that) {
case LoadSystemUserData():
return loadSystemUserData();case SaveSystemUserData():
return saveSystemUserData(_that.systemUserData);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadSystemUserData,TResult? Function( SystemUserData systemUserData)?  saveSystemUserData,}) {final _that = this;
switch (_that) {
case LoadSystemUserData() when loadSystemUserData != null:
return loadSystemUserData();case SaveSystemUserData() when saveSystemUserData != null:
return saveSystemUserData(_that.systemUserData);case _:
  return null;

}
}

}

/// @nodoc


class LoadSystemUserData implements HomeEvent {
  const LoadSystemUserData();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadSystemUserData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.loadSystemUserData()';
}


}




/// @nodoc


class SaveSystemUserData implements HomeEvent {
  const SaveSystemUserData(this.systemUserData);
  

 final  SystemUserData systemUserData;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SaveSystemUserDataCopyWith<SaveSystemUserData> get copyWith => _$SaveSystemUserDataCopyWithImpl<SaveSystemUserData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SaveSystemUserData&&(identical(other.systemUserData, systemUserData) || other.systemUserData == systemUserData));
}


@override
int get hashCode => Object.hash(runtimeType,systemUserData);

@override
String toString() {
  return 'HomeEvent.saveSystemUserData(systemUserData: $systemUserData)';
}


}

/// @nodoc
abstract mixin class $SaveSystemUserDataCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory $SaveSystemUserDataCopyWith(SaveSystemUserData value, $Res Function(SaveSystemUserData) _then) = _$SaveSystemUserDataCopyWithImpl;
@useResult
$Res call({
 SystemUserData systemUserData
});




}
/// @nodoc
class _$SaveSystemUserDataCopyWithImpl<$Res>
    implements $SaveSystemUserDataCopyWith<$Res> {
  _$SaveSystemUserDataCopyWithImpl(this._self, this._then);

  final SaveSystemUserData _self;
  final $Res Function(SaveSystemUserData) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? systemUserData = null,}) {
  return _then(SaveSystemUserData(
null == systemUserData ? _self.systemUserData : systemUserData // ignore: cast_nullable_to_non_nullable
as SystemUserData,
  ));
}


}

/// @nodoc
mixin _$HomeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState()';
}


}

/// @nodoc
class $HomeStateCopyWith<$Res>  {
$HomeStateCopyWith(HomeState _, $Res Function(HomeState) __);
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeError value)?  error,TResult Function( HomeInitial value)?  initial,TResult Function( HomeLoaded value)?  loaded,TResult Function( HomeLoading value)?  loading,TResult Function( HomeSaved value)?  saved,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeError() when error != null:
return error(_that);case HomeInitial() when initial != null:
return initial(_that);case HomeLoaded() when loaded != null:
return loaded(_that);case HomeLoading() when loading != null:
return loading(_that);case HomeSaved() when saved != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeError value)  error,required TResult Function( HomeInitial value)  initial,required TResult Function( HomeLoaded value)  loaded,required TResult Function( HomeLoading value)  loading,required TResult Function( HomeSaved value)  saved,}){
final _that = this;
switch (_that) {
case HomeError():
return error(_that);case HomeInitial():
return initial(_that);case HomeLoaded():
return loaded(_that);case HomeLoading():
return loading(_that);case HomeSaved():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeError value)?  error,TResult? Function( HomeInitial value)?  initial,TResult? Function( HomeLoaded value)?  loaded,TResult? Function( HomeLoading value)?  loading,TResult? Function( HomeSaved value)?  saved,}){
final _that = this;
switch (_that) {
case HomeError() when error != null:
return error(_that);case HomeInitial() when initial != null:
return initial(_that);case HomeLoaded() when loaded != null:
return loaded(_that);case HomeLoading() when loading != null:
return loading(_that);case HomeSaved() when saved != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  error,TResult Function()?  initial,TResult Function( SystemUserData systemUserData)?  loaded,TResult Function()?  loading,TResult Function( SystemUserData systemUserData)?  saved,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeError() when error != null:
return error(_that.message);case HomeInitial() when initial != null:
return initial();case HomeLoaded() when loaded != null:
return loaded(_that.systemUserData);case HomeLoading() when loading != null:
return loading();case HomeSaved() when saved != null:
return saved(_that.systemUserData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  error,required TResult Function()  initial,required TResult Function( SystemUserData systemUserData)  loaded,required TResult Function()  loading,required TResult Function( SystemUserData systemUserData)  saved,}) {final _that = this;
switch (_that) {
case HomeError():
return error(_that.message);case HomeInitial():
return initial();case HomeLoaded():
return loaded(_that.systemUserData);case HomeLoading():
return loading();case HomeSaved():
return saved(_that.systemUserData);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  error,TResult? Function()?  initial,TResult? Function( SystemUserData systemUserData)?  loaded,TResult? Function()?  loading,TResult? Function( SystemUserData systemUserData)?  saved,}) {final _that = this;
switch (_that) {
case HomeError() when error != null:
return error(_that.message);case HomeInitial() when initial != null:
return initial();case HomeLoaded() when loaded != null:
return loaded(_that.systemUserData);case HomeLoading() when loading != null:
return loading();case HomeSaved() when saved != null:
return saved(_that.systemUserData);case _:
  return null;

}
}

}

/// @nodoc


class HomeError implements HomeState {
  const HomeError(this.message);
  

 final  String message;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeErrorCopyWith<HomeError> get copyWith => _$HomeErrorCopyWithImpl<HomeError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'HomeState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $HomeErrorCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeErrorCopyWith(HomeError value, $Res Function(HomeError) _then) = _$HomeErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$HomeErrorCopyWithImpl<$Res>
    implements $HomeErrorCopyWith<$Res> {
  _$HomeErrorCopyWithImpl(this._self, this._then);

  final HomeError _self;
  final $Res Function(HomeError) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(HomeError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class HomeInitial implements HomeState {
  const HomeInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.initial()';
}


}




/// @nodoc


class HomeLoaded implements HomeState {
  const HomeLoaded(this.systemUserData);
  

 final  SystemUserData systemUserData;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeLoadedCopyWith<HomeLoaded> get copyWith => _$HomeLoadedCopyWithImpl<HomeLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeLoaded&&(identical(other.systemUserData, systemUserData) || other.systemUserData == systemUserData));
}


@override
int get hashCode => Object.hash(runtimeType,systemUserData);

@override
String toString() {
  return 'HomeState.loaded(systemUserData: $systemUserData)';
}


}

/// @nodoc
abstract mixin class $HomeLoadedCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeLoadedCopyWith(HomeLoaded value, $Res Function(HomeLoaded) _then) = _$HomeLoadedCopyWithImpl;
@useResult
$Res call({
 SystemUserData systemUserData
});




}
/// @nodoc
class _$HomeLoadedCopyWithImpl<$Res>
    implements $HomeLoadedCopyWith<$Res> {
  _$HomeLoadedCopyWithImpl(this._self, this._then);

  final HomeLoaded _self;
  final $Res Function(HomeLoaded) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? systemUserData = null,}) {
  return _then(HomeLoaded(
null == systemUserData ? _self.systemUserData : systemUserData // ignore: cast_nullable_to_non_nullable
as SystemUserData,
  ));
}


}

/// @nodoc


class HomeLoading implements HomeState {
  const HomeLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.loading()';
}


}




/// @nodoc


class HomeSaved implements HomeState {
  const HomeSaved(this.systemUserData);
  

 final  SystemUserData systemUserData;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeSavedCopyWith<HomeSaved> get copyWith => _$HomeSavedCopyWithImpl<HomeSaved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSaved&&(identical(other.systemUserData, systemUserData) || other.systemUserData == systemUserData));
}


@override
int get hashCode => Object.hash(runtimeType,systemUserData);

@override
String toString() {
  return 'HomeState.saved(systemUserData: $systemUserData)';
}


}

/// @nodoc
abstract mixin class $HomeSavedCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $HomeSavedCopyWith(HomeSaved value, $Res Function(HomeSaved) _then) = _$HomeSavedCopyWithImpl;
@useResult
$Res call({
 SystemUserData systemUserData
});




}
/// @nodoc
class _$HomeSavedCopyWithImpl<$Res>
    implements $HomeSavedCopyWith<$Res> {
  _$HomeSavedCopyWithImpl(this._self, this._then);

  final HomeSaved _self;
  final $Res Function(HomeSaved) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? systemUserData = null,}) {
  return _then(HomeSaved(
null == systemUserData ? _self.systemUserData : systemUserData // ignore: cast_nullable_to_non_nullable
as SystemUserData,
  ));
}


}

// dart format on
