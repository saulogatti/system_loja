// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'person_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PersonState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PersonState()';
}


}

/// @nodoc
class $PersonStateCopyWith<$Res>  {
$PersonStateCopyWith(PersonState _, $Res Function(PersonState) __);
}


/// Adds pattern-matching-related methods to [PersonState].
extension PersonStatePatterns on PersonState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PersonInitial value)?  initial,TResult Function( PersonLoading value)?  loading,TResult Function( PersonSuccess value)?  success,TResult Function( PersonFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PersonInitial() when initial != null:
return initial(_that);case PersonLoading() when loading != null:
return loading(_that);case PersonSuccess() when success != null:
return success(_that);case PersonFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PersonInitial value)  initial,required TResult Function( PersonLoading value)  loading,required TResult Function( PersonSuccess value)  success,required TResult Function( PersonFailure value)  failure,}){
final _that = this;
switch (_that) {
case PersonInitial():
return initial(_that);case PersonLoading():
return loading(_that);case PersonSuccess():
return success(_that);case PersonFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PersonInitial value)?  initial,TResult? Function( PersonLoading value)?  loading,TResult? Function( PersonSuccess value)?  success,TResult? Function( PersonFailure value)?  failure,}){
final _that = this;
switch (_that) {
case PersonInitial() when initial != null:
return initial(_that);case PersonLoading() when loading != null:
return loading(_that);case PersonSuccess() when success != null:
return success(_that);case PersonFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  success,TResult Function( String error)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PersonInitial() when initial != null:
return initial();case PersonLoading() when loading != null:
return loading();case PersonSuccess() when success != null:
return success();case PersonFailure() when failure != null:
return failure(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  success,required TResult Function( String error)  failure,}) {final _that = this;
switch (_that) {
case PersonInitial():
return initial();case PersonLoading():
return loading();case PersonSuccess():
return success();case PersonFailure():
return failure(_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  success,TResult? Function( String error)?  failure,}) {final _that = this;
switch (_that) {
case PersonInitial() when initial != null:
return initial();case PersonLoading() when loading != null:
return loading();case PersonSuccess() when success != null:
return success();case PersonFailure() when failure != null:
return failure(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class PersonInitial implements PersonState {
  const PersonInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PersonState.initial()';
}


}




/// @nodoc


class PersonLoading implements PersonState {
  const PersonLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PersonState.loading()';
}


}




/// @nodoc


class PersonSuccess implements PersonState {
  const PersonSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PersonState.success()';
}


}




/// @nodoc


class PersonFailure implements PersonState {
  const PersonFailure(this.error);
  

 final  String error;

/// Create a copy of PersonState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonFailureCopyWith<PersonFailure> get copyWith => _$PersonFailureCopyWithImpl<PersonFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonFailure&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'PersonState.failure(error: $error)';
}


}

/// @nodoc
abstract mixin class $PersonFailureCopyWith<$Res> implements $PersonStateCopyWith<$Res> {
  factory $PersonFailureCopyWith(PersonFailure value, $Res Function(PersonFailure) _then) = _$PersonFailureCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$PersonFailureCopyWithImpl<$Res>
    implements $PersonFailureCopyWith<$Res> {
  _$PersonFailureCopyWithImpl(this._self, this._then);

  final PersonFailure _self;
  final $Res Function(PersonFailure) _then;

/// Create a copy of PersonState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(PersonFailure(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
