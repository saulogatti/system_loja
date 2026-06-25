// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'person_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PersonEvent {

 PersonRegistrationFormData get formData;
/// Create a copy of PersonEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonEventCopyWith<PersonEvent> get copyWith => _$PersonEventCopyWithImpl<PersonEvent>(this as PersonEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonEvent&&(identical(other.formData, formData) || other.formData == formData));
}


@override
int get hashCode => Object.hash(runtimeType,formData);

@override
String toString() {
  return 'PersonEvent(formData: $formData)';
}


}

/// @nodoc
abstract mixin class $PersonEventCopyWith<$Res>  {
  factory $PersonEventCopyWith(PersonEvent value, $Res Function(PersonEvent) _then) = _$PersonEventCopyWithImpl;
@useResult
$Res call({
 PersonRegistrationFormData formData
});




}
/// @nodoc
class _$PersonEventCopyWithImpl<$Res>
    implements $PersonEventCopyWith<$Res> {
  _$PersonEventCopyWithImpl(this._self, this._then);

  final PersonEvent _self;
  final $Res Function(PersonEvent) _then;

/// Create a copy of PersonEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? formData = null,}) {
  return _then(PersonEvent.submit(
null == formData ? _self.formData : formData // ignore: cast_nullable_to_non_nullable
as PersonRegistrationFormData,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonEvent].
extension PersonEventPatterns on PersonEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PersonSubmit value)?  submit,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PersonSubmit() when submit != null:
return submit(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PersonSubmit value)  submit,}){
final _that = this;
switch (_that) {
case PersonSubmit():
return submit(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PersonSubmit value)?  submit,}){
final _that = this;
switch (_that) {
case PersonSubmit() when submit != null:
return submit(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( PersonRegistrationFormData formData)?  submit,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PersonSubmit() when submit != null:
return submit(_that.formData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( PersonRegistrationFormData formData)  submit,}) {final _that = this;
switch (_that) {
case PersonSubmit():
return submit(_that.formData);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( PersonRegistrationFormData formData)?  submit,}) {final _that = this;
switch (_that) {
case PersonSubmit() when submit != null:
return submit(_that.formData);case _:
  return null;

}
}

}

/// @nodoc


class PersonSubmit implements PersonEvent {
  const PersonSubmit(this.formData);
  

@override final  PersonRegistrationFormData formData;

/// Create a copy of PersonEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonSubmitCopyWith<PersonSubmit> get copyWith => _$PersonSubmitCopyWithImpl<PersonSubmit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonSubmit&&(identical(other.formData, formData) || other.formData == formData));
}


@override
int get hashCode => Object.hash(runtimeType,formData);

@override
String toString() {
  return 'PersonEvent.submit(formData: $formData)';
}


}

/// @nodoc
abstract mixin class $PersonSubmitCopyWith<$Res> implements $PersonEventCopyWith<$Res> {
  factory $PersonSubmitCopyWith(PersonSubmit value, $Res Function(PersonSubmit) _then) = _$PersonSubmitCopyWithImpl;
@override @useResult
$Res call({
 PersonRegistrationFormData formData
});




}
/// @nodoc
class _$PersonSubmitCopyWithImpl<$Res>
    implements $PersonSubmitCopyWith<$Res> {
  _$PersonSubmitCopyWithImpl(this._self, this._then);

  final PersonSubmit _self;
  final $Res Function(PersonSubmit) _then;

/// Create a copy of PersonEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? formData = null,}) {
  return _then(PersonSubmit(
null == formData ? _self.formData : formData // ignore: cast_nullable_to_non_nullable
as PersonRegistrationFormData,
  ));
}


}

// dart format on
