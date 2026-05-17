// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logs_system_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LogsSystemState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogsSystemState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LogsSystemState()';
}


}

/// @nodoc
class $LogsSystemStateCopyWith<$Res>  {
$LogsSystemStateCopyWith(LogsSystemState _, $Res Function(LogsSystemState) __);
}


/// Adds pattern-matching-related methods to [LogsSystemState].
extension LogsSystemStatePatterns on LogsSystemState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LogsSystemInitial value)?  initial,TResult Function( LogsSystemLoading value)?  loading,TResult Function( LogsSystemLoaded value)?  loaded,TResult Function( LogsSystemError value)?  error,TResult Function( LogsSystemDeleted value)?  deleted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LogsSystemInitial() when initial != null:
return initial(_that);case LogsSystemLoading() when loading != null:
return loading(_that);case LogsSystemLoaded() when loaded != null:
return loaded(_that);case LogsSystemError() when error != null:
return error(_that);case LogsSystemDeleted() when deleted != null:
return deleted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LogsSystemInitial value)  initial,required TResult Function( LogsSystemLoading value)  loading,required TResult Function( LogsSystemLoaded value)  loaded,required TResult Function( LogsSystemError value)  error,required TResult Function( LogsSystemDeleted value)  deleted,}){
final _that = this;
switch (_that) {
case LogsSystemInitial():
return initial(_that);case LogsSystemLoading():
return loading(_that);case LogsSystemLoaded():
return loaded(_that);case LogsSystemError():
return error(_that);case LogsSystemDeleted():
return deleted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LogsSystemInitial value)?  initial,TResult? Function( LogsSystemLoading value)?  loading,TResult? Function( LogsSystemLoaded value)?  loaded,TResult? Function( LogsSystemError value)?  error,TResult? Function( LogsSystemDeleted value)?  deleted,}){
final _that = this;
switch (_that) {
case LogsSystemInitial() when initial != null:
return initial(_that);case LogsSystemLoading() when loading != null:
return loading(_that);case LogsSystemLoaded() when loaded != null:
return loaded(_that);case LogsSystemError() when error != null:
return error(_that);case LogsSystemDeleted() when deleted != null:
return deleted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<SystemError> logs)?  loaded,TResult Function( String message)?  error,TResult Function()?  deleted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LogsSystemInitial() when initial != null:
return initial();case LogsSystemLoading() when loading != null:
return loading();case LogsSystemLoaded() when loaded != null:
return loaded(_that.logs);case LogsSystemError() when error != null:
return error(_that.message);case LogsSystemDeleted() when deleted != null:
return deleted();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<SystemError> logs)  loaded,required TResult Function( String message)  error,required TResult Function()  deleted,}) {final _that = this;
switch (_that) {
case LogsSystemInitial():
return initial();case LogsSystemLoading():
return loading();case LogsSystemLoaded():
return loaded(_that.logs);case LogsSystemError():
return error(_that.message);case LogsSystemDeleted():
return deleted();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<SystemError> logs)?  loaded,TResult? Function( String message)?  error,TResult? Function()?  deleted,}) {final _that = this;
switch (_that) {
case LogsSystemInitial() when initial != null:
return initial();case LogsSystemLoading() when loading != null:
return loading();case LogsSystemLoaded() when loaded != null:
return loaded(_that.logs);case LogsSystemError() when error != null:
return error(_that.message);case LogsSystemDeleted() when deleted != null:
return deleted();case _:
  return null;

}
}

}

/// @nodoc


class LogsSystemInitial implements LogsSystemState {
  const LogsSystemInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogsSystemInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LogsSystemState.initial()';
}


}




/// @nodoc


class LogsSystemLoading implements LogsSystemState {
  const LogsSystemLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogsSystemLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LogsSystemState.loading()';
}


}




/// @nodoc


class LogsSystemLoaded implements LogsSystemState {
  const LogsSystemLoaded(final  List<SystemError> logs): _logs = logs;
  

 final  List<SystemError> _logs;
 List<SystemError> get logs {
  if (_logs is EqualUnmodifiableListView) return _logs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_logs);
}


/// Create a copy of LogsSystemState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogsSystemLoadedCopyWith<LogsSystemLoaded> get copyWith => _$LogsSystemLoadedCopyWithImpl<LogsSystemLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogsSystemLoaded&&const DeepCollectionEquality().equals(other._logs, _logs));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_logs));

@override
String toString() {
  return 'LogsSystemState.loaded(logs: $logs)';
}


}

/// @nodoc
abstract mixin class $LogsSystemLoadedCopyWith<$Res> implements $LogsSystemStateCopyWith<$Res> {
  factory $LogsSystemLoadedCopyWith(LogsSystemLoaded value, $Res Function(LogsSystemLoaded) _then) = _$LogsSystemLoadedCopyWithImpl;
@useResult
$Res call({
 List<SystemError> logs
});




}
/// @nodoc
class _$LogsSystemLoadedCopyWithImpl<$Res>
    implements $LogsSystemLoadedCopyWith<$Res> {
  _$LogsSystemLoadedCopyWithImpl(this._self, this._then);

  final LogsSystemLoaded _self;
  final $Res Function(LogsSystemLoaded) _then;

/// Create a copy of LogsSystemState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? logs = null,}) {
  return _then(LogsSystemLoaded(
null == logs ? _self._logs : logs // ignore: cast_nullable_to_non_nullable
as List<SystemError>,
  ));
}


}

/// @nodoc


class LogsSystemError implements LogsSystemState {
  const LogsSystemError(this.message);
  

 final  String message;

/// Create a copy of LogsSystemState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LogsSystemErrorCopyWith<LogsSystemError> get copyWith => _$LogsSystemErrorCopyWithImpl<LogsSystemError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogsSystemError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'LogsSystemState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $LogsSystemErrorCopyWith<$Res> implements $LogsSystemStateCopyWith<$Res> {
  factory $LogsSystemErrorCopyWith(LogsSystemError value, $Res Function(LogsSystemError) _then) = _$LogsSystemErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$LogsSystemErrorCopyWithImpl<$Res>
    implements $LogsSystemErrorCopyWith<$Res> {
  _$LogsSystemErrorCopyWithImpl(this._self, this._then);

  final LogsSystemError _self;
  final $Res Function(LogsSystemError) _then;

/// Create a copy of LogsSystemState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(LogsSystemError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LogsSystemDeleted implements LogsSystemState {
  const LogsSystemDeleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogsSystemDeleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LogsSystemState.deleted()';
}


}




// dart format on
