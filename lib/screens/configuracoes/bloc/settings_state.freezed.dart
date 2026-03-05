// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState()';
}


}

/// @nodoc
class $SettingsStateCopyWith<$Res>  {
$SettingsStateCopyWith(SettingsState _, $Res Function(SettingsState) __);
}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SettingsError value)?  error,TResult Function( SettingsInitialState value)?  initial,TResult Function( SettingsLoadedState value)?  loaded,TResult Function( SettingsLoadingState value)?  loading,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SettingsError() when error != null:
return error(_that);case SettingsInitialState() when initial != null:
return initial(_that);case SettingsLoadedState() when loaded != null:
return loaded(_that);case SettingsLoadingState() when loading != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SettingsError value)  error,required TResult Function( SettingsInitialState value)  initial,required TResult Function( SettingsLoadedState value)  loaded,required TResult Function( SettingsLoadingState value)  loading,}){
final _that = this;
switch (_that) {
case SettingsError():
return error(_that);case SettingsInitialState():
return initial(_that);case SettingsLoadedState():
return loaded(_that);case SettingsLoadingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SettingsError value)?  error,TResult? Function( SettingsInitialState value)?  initial,TResult? Function( SettingsLoadedState value)?  loaded,TResult? Function( SettingsLoadingState value)?  loading,}){
final _that = this;
switch (_that) {
case SettingsError() when error != null:
return error(_that);case SettingsInitialState() when initial != null:
return initial(_that);case SettingsLoadedState() when loaded != null:
return loaded(_that);case SettingsLoadingState() when loading != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String mensagem)?  error,TResult Function()?  initial,TResult Function( AppSettings appSettings,  SettingsSuccessStatus status)?  loaded,TResult Function()?  loading,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SettingsError() when error != null:
return error(_that.mensagem);case SettingsInitialState() when initial != null:
return initial();case SettingsLoadedState() when loaded != null:
return loaded(_that.appSettings,_that.status);case SettingsLoadingState() when loading != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String mensagem)  error,required TResult Function()  initial,required TResult Function( AppSettings appSettings,  SettingsSuccessStatus status)  loaded,required TResult Function()  loading,}) {final _that = this;
switch (_that) {
case SettingsError():
return error(_that.mensagem);case SettingsInitialState():
return initial();case SettingsLoadedState():
return loaded(_that.appSettings,_that.status);case SettingsLoadingState():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String mensagem)?  error,TResult? Function()?  initial,TResult? Function( AppSettings appSettings,  SettingsSuccessStatus status)?  loaded,TResult? Function()?  loading,}) {final _that = this;
switch (_that) {
case SettingsError() when error != null:
return error(_that.mensagem);case SettingsInitialState() when initial != null:
return initial();case SettingsLoadedState() when loaded != null:
return loaded(_that.appSettings,_that.status);case SettingsLoadingState() when loading != null:
return loading();case _:
  return null;

}
}

}

/// @nodoc


class SettingsError implements SettingsState {
  const SettingsError(this.mensagem);
  

 final  String mensagem;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsErrorCopyWith<SettingsError> get copyWith => _$SettingsErrorCopyWithImpl<SettingsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsError&&(identical(other.mensagem, mensagem) || other.mensagem == mensagem));
}


@override
int get hashCode => Object.hash(runtimeType,mensagem);

@override
String toString() {
  return 'SettingsState.error(mensagem: $mensagem)';
}


}

/// @nodoc
abstract mixin class $SettingsErrorCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory $SettingsErrorCopyWith(SettingsError value, $Res Function(SettingsError) _then) = _$SettingsErrorCopyWithImpl;
@useResult
$Res call({
 String mensagem
});




}
/// @nodoc
class _$SettingsErrorCopyWithImpl<$Res>
    implements $SettingsErrorCopyWith<$Res> {
  _$SettingsErrorCopyWithImpl(this._self, this._then);

  final SettingsError _self;
  final $Res Function(SettingsError) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mensagem = null,}) {
  return _then(SettingsError(
null == mensagem ? _self.mensagem : mensagem // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SettingsInitialState implements SettingsState {
  const SettingsInitialState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsInitialState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState.initial()';
}


}




/// @nodoc


class SettingsLoadedState implements SettingsState {
  const SettingsLoadedState(this.appSettings, this.status);
  

 final  AppSettings appSettings;
 final  SettingsSuccessStatus status;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsLoadedStateCopyWith<SettingsLoadedState> get copyWith => _$SettingsLoadedStateCopyWithImpl<SettingsLoadedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsLoadedState&&(identical(other.appSettings, appSettings) || other.appSettings == appSettings)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,appSettings,status);

@override
String toString() {
  return 'SettingsState.loaded(appSettings: $appSettings, status: $status)';
}


}

/// @nodoc
abstract mixin class $SettingsLoadedStateCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory $SettingsLoadedStateCopyWith(SettingsLoadedState value, $Res Function(SettingsLoadedState) _then) = _$SettingsLoadedStateCopyWithImpl;
@useResult
$Res call({
 AppSettings appSettings, SettingsSuccessStatus status
});




}
/// @nodoc
class _$SettingsLoadedStateCopyWithImpl<$Res>
    implements $SettingsLoadedStateCopyWith<$Res> {
  _$SettingsLoadedStateCopyWithImpl(this._self, this._then);

  final SettingsLoadedState _self;
  final $Res Function(SettingsLoadedState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? appSettings = null,Object? status = null,}) {
  return _then(SettingsLoadedState(
null == appSettings ? _self.appSettings : appSettings // ignore: cast_nullable_to_non_nullable
as AppSettings,null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SettingsSuccessStatus,
  ));
}


}

/// @nodoc


class SettingsLoadingState implements SettingsState {
  const SettingsLoadingState();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsLoadingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsState.loading()';
}


}




// dart format on
