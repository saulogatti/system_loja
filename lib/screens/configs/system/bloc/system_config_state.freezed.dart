// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'system_config_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SystemConfigState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemConfigState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SystemConfigState()';
}


}

/// @nodoc
class $SystemConfigStateCopyWith<$Res>  {
$SystemConfigStateCopyWith(SystemConfigState _, $Res Function(SystemConfigState) __);
}


/// Adds pattern-matching-related methods to [SystemConfigState].
extension SystemConfigStatePatterns on SystemConfigState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SystemConfigStateError value)?  error,TResult Function( SystemConfigStateInitial value)?  initial,TResult Function( SystemConfigStateLoaded value)?  loaded,TResult Function( SystemConfigStateLoading value)?  loading,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SystemConfigStateError() when error != null:
return error(_that);case SystemConfigStateInitial() when initial != null:
return initial(_that);case SystemConfigStateLoaded() when loaded != null:
return loaded(_that);case SystemConfigStateLoading() when loading != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SystemConfigStateError value)  error,required TResult Function( SystemConfigStateInitial value)  initial,required TResult Function( SystemConfigStateLoaded value)  loaded,required TResult Function( SystemConfigStateLoading value)  loading,}){
final _that = this;
switch (_that) {
case SystemConfigStateError():
return error(_that);case SystemConfigStateInitial():
return initial(_that);case SystemConfigStateLoaded():
return loaded(_that);case SystemConfigStateLoading():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SystemConfigStateError value)?  error,TResult? Function( SystemConfigStateInitial value)?  initial,TResult? Function( SystemConfigStateLoaded value)?  loaded,TResult? Function( SystemConfigStateLoading value)?  loading,}){
final _that = this;
switch (_that) {
case SystemConfigStateError() when error != null:
return error(_that);case SystemConfigStateInitial() when initial != null:
return initial(_that);case SystemConfigStateLoaded() when loaded != null:
return loaded(_that);case SystemConfigStateLoading() when loading != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message)?  error,TResult Function()?  initial,TResult Function( SystemConfiguration data,  String? feedbackMessage,  SystemConfigFeedbackType? feedbackType)?  loaded,TResult Function()?  loading,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SystemConfigStateError() when error != null:
return error(_that.message);case SystemConfigStateInitial() when initial != null:
return initial();case SystemConfigStateLoaded() when loaded != null:
return loaded(_that.data,_that.feedbackMessage,_that.feedbackType);case SystemConfigStateLoading() when loading != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message)  error,required TResult Function()  initial,required TResult Function( SystemConfiguration data,  String? feedbackMessage,  SystemConfigFeedbackType? feedbackType)  loaded,required TResult Function()  loading,}) {final _that = this;
switch (_that) {
case SystemConfigStateError():
return error(_that.message);case SystemConfigStateInitial():
return initial();case SystemConfigStateLoaded():
return loaded(_that.data,_that.feedbackMessage,_that.feedbackType);case SystemConfigStateLoading():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message)?  error,TResult? Function()?  initial,TResult? Function( SystemConfiguration data,  String? feedbackMessage,  SystemConfigFeedbackType? feedbackType)?  loaded,TResult? Function()?  loading,}) {final _that = this;
switch (_that) {
case SystemConfigStateError() when error != null:
return error(_that.message);case SystemConfigStateInitial() when initial != null:
return initial();case SystemConfigStateLoaded() when loaded != null:
return loaded(_that.data,_that.feedbackMessage,_that.feedbackType);case SystemConfigStateLoading() when loading != null:
return loading();case _:
  return null;

}
}

}

/// @nodoc


class SystemConfigStateError implements SystemConfigState {
  const SystemConfigStateError(this.message);
  

 final  String message;

/// Create a copy of SystemConfigState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SystemConfigStateErrorCopyWith<SystemConfigStateError> get copyWith => _$SystemConfigStateErrorCopyWithImpl<SystemConfigStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemConfigStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SystemConfigState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SystemConfigStateErrorCopyWith<$Res> implements $SystemConfigStateCopyWith<$Res> {
  factory $SystemConfigStateErrorCopyWith(SystemConfigStateError value, $Res Function(SystemConfigStateError) _then) = _$SystemConfigStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SystemConfigStateErrorCopyWithImpl<$Res>
    implements $SystemConfigStateErrorCopyWith<$Res> {
  _$SystemConfigStateErrorCopyWithImpl(this._self, this._then);

  final SystemConfigStateError _self;
  final $Res Function(SystemConfigStateError) _then;

/// Create a copy of SystemConfigState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SystemConfigStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SystemConfigStateInitial implements SystemConfigState {
  const SystemConfigStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemConfigStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SystemConfigState.initial()';
}


}




/// @nodoc


class SystemConfigStateLoaded implements SystemConfigState {
  const SystemConfigStateLoaded(this.data, {this.feedbackMessage, this.feedbackType});
  

 final  SystemConfiguration data;
 final  String? feedbackMessage;
 final  SystemConfigFeedbackType? feedbackType;

/// Create a copy of SystemConfigState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SystemConfigStateLoadedCopyWith<SystemConfigStateLoaded> get copyWith => _$SystemConfigStateLoadedCopyWithImpl<SystemConfigStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemConfigStateLoaded&&(identical(other.data, data) || other.data == data)&&(identical(other.feedbackMessage, feedbackMessage) || other.feedbackMessage == feedbackMessage)&&(identical(other.feedbackType, feedbackType) || other.feedbackType == feedbackType));
}


@override
int get hashCode => Object.hash(runtimeType,data,feedbackMessage,feedbackType);

@override
String toString() {
  return 'SystemConfigState.loaded(data: $data, feedbackMessage: $feedbackMessage, feedbackType: $feedbackType)';
}


}

/// @nodoc
abstract mixin class $SystemConfigStateLoadedCopyWith<$Res> implements $SystemConfigStateCopyWith<$Res> {
  factory $SystemConfigStateLoadedCopyWith(SystemConfigStateLoaded value, $Res Function(SystemConfigStateLoaded) _then) = _$SystemConfigStateLoadedCopyWithImpl;
@useResult
$Res call({
 SystemConfiguration data, String? feedbackMessage, SystemConfigFeedbackType? feedbackType
});




}
/// @nodoc
class _$SystemConfigStateLoadedCopyWithImpl<$Res>
    implements $SystemConfigStateLoadedCopyWith<$Res> {
  _$SystemConfigStateLoadedCopyWithImpl(this._self, this._then);

  final SystemConfigStateLoaded _self;
  final $Res Function(SystemConfigStateLoaded) _then;

/// Create a copy of SystemConfigState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,Object? feedbackMessage = freezed,Object? feedbackType = freezed,}) {
  return _then(SystemConfigStateLoaded(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SystemConfiguration,feedbackMessage: freezed == feedbackMessage ? _self.feedbackMessage : feedbackMessage // ignore: cast_nullable_to_non_nullable
as String?,feedbackType: freezed == feedbackType ? _self.feedbackType : feedbackType // ignore: cast_nullable_to_non_nullable
as SystemConfigFeedbackType?,
  ));
}


}

/// @nodoc


class SystemConfigStateLoading implements SystemConfigState {
  const SystemConfigStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SystemConfigStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SystemConfigState.loading()';
}


}




// dart format on
