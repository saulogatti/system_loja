// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sales_invoice_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SalesInvoiceFormData {

 InvoiceType get invoiceType; PaymentMethodType? get paymentMethod; PersonSelection? get person; Map<int, InvoiceLineEntry> get linesByProductId; List<int> get orderedProductIds; bool get enableCodeGeneration; String get invoiceNumber;
/// Create a copy of SalesInvoiceFormData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesInvoiceFormDataCopyWith<SalesInvoiceFormData> get copyWith => _$SalesInvoiceFormDataCopyWithImpl<SalesInvoiceFormData>(this as SalesInvoiceFormData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesInvoiceFormData&&(identical(other.invoiceType, invoiceType) || other.invoiceType == invoiceType)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.person, person) || other.person == person)&&const DeepCollectionEquality().equals(other.linesByProductId, linesByProductId)&&const DeepCollectionEquality().equals(other.orderedProductIds, orderedProductIds)&&(identical(other.enableCodeGeneration, enableCodeGeneration) || other.enableCodeGeneration == enableCodeGeneration)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber));
}


@override
int get hashCode => Object.hash(runtimeType,invoiceType,paymentMethod,person,const DeepCollectionEquality().hash(linesByProductId),const DeepCollectionEquality().hash(orderedProductIds),enableCodeGeneration,invoiceNumber);

@override
String toString() {
  return 'SalesInvoiceFormData(invoiceType: $invoiceType, paymentMethod: $paymentMethod, person: $person, linesByProductId: $linesByProductId, orderedProductIds: $orderedProductIds, enableCodeGeneration: $enableCodeGeneration, invoiceNumber: $invoiceNumber)';
}


}

/// @nodoc
abstract mixin class $SalesInvoiceFormDataCopyWith<$Res>  {
  factory $SalesInvoiceFormDataCopyWith(SalesInvoiceFormData value, $Res Function(SalesInvoiceFormData) _then) = _$SalesInvoiceFormDataCopyWithImpl;
@useResult
$Res call({
 InvoiceType invoiceType, PaymentMethodType? paymentMethod, PersonSelection? person, Map<int, InvoiceLineEntry> linesByProductId, List<int> orderedProductIds, bool enableCodeGeneration, String invoiceNumber
});




}
/// @nodoc
class _$SalesInvoiceFormDataCopyWithImpl<$Res>
    implements $SalesInvoiceFormDataCopyWith<$Res> {
  _$SalesInvoiceFormDataCopyWithImpl(this._self, this._then);

  final SalesInvoiceFormData _self;
  final $Res Function(SalesInvoiceFormData) _then;

/// Create a copy of SalesInvoiceFormData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? invoiceType = null,Object? paymentMethod = freezed,Object? person = freezed,Object? linesByProductId = null,Object? orderedProductIds = null,Object? enableCodeGeneration = null,Object? invoiceNumber = null,}) {
  return _then(_self.copyWith(
invoiceType: null == invoiceType ? _self.invoiceType : invoiceType // ignore: cast_nullable_to_non_nullable
as InvoiceType,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethodType?,person: freezed == person ? _self.person : person // ignore: cast_nullable_to_non_nullable
as PersonSelection?,linesByProductId: null == linesByProductId ? _self.linesByProductId : linesByProductId // ignore: cast_nullable_to_non_nullable
as Map<int, InvoiceLineEntry>,orderedProductIds: null == orderedProductIds ? _self.orderedProductIds : orderedProductIds // ignore: cast_nullable_to_non_nullable
as List<int>,enableCodeGeneration: null == enableCodeGeneration ? _self.enableCodeGeneration : enableCodeGeneration // ignore: cast_nullable_to_non_nullable
as bool,invoiceNumber: null == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SalesInvoiceFormData].
extension SalesInvoiceFormDataPatterns on SalesInvoiceFormData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SalesInvoiceFormData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SalesInvoiceFormData() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SalesInvoiceFormData value)  $default,){
final _that = this;
switch (_that) {
case _SalesInvoiceFormData():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SalesInvoiceFormData value)?  $default,){
final _that = this;
switch (_that) {
case _SalesInvoiceFormData() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InvoiceType invoiceType,  PaymentMethodType? paymentMethod,  PersonSelection? person,  Map<int, InvoiceLineEntry> linesByProductId,  List<int> orderedProductIds,  bool enableCodeGeneration,  String invoiceNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SalesInvoiceFormData() when $default != null:
return $default(_that.invoiceType,_that.paymentMethod,_that.person,_that.linesByProductId,_that.orderedProductIds,_that.enableCodeGeneration,_that.invoiceNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InvoiceType invoiceType,  PaymentMethodType? paymentMethod,  PersonSelection? person,  Map<int, InvoiceLineEntry> linesByProductId,  List<int> orderedProductIds,  bool enableCodeGeneration,  String invoiceNumber)  $default,) {final _that = this;
switch (_that) {
case _SalesInvoiceFormData():
return $default(_that.invoiceType,_that.paymentMethod,_that.person,_that.linesByProductId,_that.orderedProductIds,_that.enableCodeGeneration,_that.invoiceNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InvoiceType invoiceType,  PaymentMethodType? paymentMethod,  PersonSelection? person,  Map<int, InvoiceLineEntry> linesByProductId,  List<int> orderedProductIds,  bool enableCodeGeneration,  String invoiceNumber)?  $default,) {final _that = this;
switch (_that) {
case _SalesInvoiceFormData() when $default != null:
return $default(_that.invoiceType,_that.paymentMethod,_that.person,_that.linesByProductId,_that.orderedProductIds,_that.enableCodeGeneration,_that.invoiceNumber);case _:
  return null;

}
}

}

/// @nodoc


class _SalesInvoiceFormData implements SalesInvoiceFormData {
  const _SalesInvoiceFormData({this.invoiceType = InvoiceType.exit, this.paymentMethod, this.person, final  Map<int, InvoiceLineEntry> linesByProductId = const {}, final  List<int> orderedProductIds = const [], this.enableCodeGeneration = false, this.invoiceNumber = ''}): _linesByProductId = linesByProductId,_orderedProductIds = orderedProductIds;
  

@override@JsonKey() final  InvoiceType invoiceType;
@override final  PaymentMethodType? paymentMethod;
@override final  PersonSelection? person;
 final  Map<int, InvoiceLineEntry> _linesByProductId;
@override@JsonKey() Map<int, InvoiceLineEntry> get linesByProductId {
  if (_linesByProductId is EqualUnmodifiableMapView) return _linesByProductId;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_linesByProductId);
}

 final  List<int> _orderedProductIds;
@override@JsonKey() List<int> get orderedProductIds {
  if (_orderedProductIds is EqualUnmodifiableListView) return _orderedProductIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orderedProductIds);
}

@override@JsonKey() final  bool enableCodeGeneration;
@override@JsonKey() final  String invoiceNumber;

/// Create a copy of SalesInvoiceFormData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SalesInvoiceFormDataCopyWith<_SalesInvoiceFormData> get copyWith => __$SalesInvoiceFormDataCopyWithImpl<_SalesInvoiceFormData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SalesInvoiceFormData&&(identical(other.invoiceType, invoiceType) || other.invoiceType == invoiceType)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.person, person) || other.person == person)&&const DeepCollectionEquality().equals(other._linesByProductId, _linesByProductId)&&const DeepCollectionEquality().equals(other._orderedProductIds, _orderedProductIds)&&(identical(other.enableCodeGeneration, enableCodeGeneration) || other.enableCodeGeneration == enableCodeGeneration)&&(identical(other.invoiceNumber, invoiceNumber) || other.invoiceNumber == invoiceNumber));
}


@override
int get hashCode => Object.hash(runtimeType,invoiceType,paymentMethod,person,const DeepCollectionEquality().hash(_linesByProductId),const DeepCollectionEquality().hash(_orderedProductIds),enableCodeGeneration,invoiceNumber);

@override
String toString() {
  return 'SalesInvoiceFormData(invoiceType: $invoiceType, paymentMethod: $paymentMethod, person: $person, linesByProductId: $linesByProductId, orderedProductIds: $orderedProductIds, enableCodeGeneration: $enableCodeGeneration, invoiceNumber: $invoiceNumber)';
}


}

/// @nodoc
abstract mixin class _$SalesInvoiceFormDataCopyWith<$Res> implements $SalesInvoiceFormDataCopyWith<$Res> {
  factory _$SalesInvoiceFormDataCopyWith(_SalesInvoiceFormData value, $Res Function(_SalesInvoiceFormData) _then) = __$SalesInvoiceFormDataCopyWithImpl;
@override @useResult
$Res call({
 InvoiceType invoiceType, PaymentMethodType? paymentMethod, PersonSelection? person, Map<int, InvoiceLineEntry> linesByProductId, List<int> orderedProductIds, bool enableCodeGeneration, String invoiceNumber
});




}
/// @nodoc
class __$SalesInvoiceFormDataCopyWithImpl<$Res>
    implements _$SalesInvoiceFormDataCopyWith<$Res> {
  __$SalesInvoiceFormDataCopyWithImpl(this._self, this._then);

  final _SalesInvoiceFormData _self;
  final $Res Function(_SalesInvoiceFormData) _then;

/// Create a copy of SalesInvoiceFormData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? invoiceType = null,Object? paymentMethod = freezed,Object? person = freezed,Object? linesByProductId = null,Object? orderedProductIds = null,Object? enableCodeGeneration = null,Object? invoiceNumber = null,}) {
  return _then(_SalesInvoiceFormData(
invoiceType: null == invoiceType ? _self.invoiceType : invoiceType // ignore: cast_nullable_to_non_nullable
as InvoiceType,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethodType?,person: freezed == person ? _self.person : person // ignore: cast_nullable_to_non_nullable
as PersonSelection?,linesByProductId: null == linesByProductId ? _self._linesByProductId : linesByProductId // ignore: cast_nullable_to_non_nullable
as Map<int, InvoiceLineEntry>,orderedProductIds: null == orderedProductIds ? _self._orderedProductIds : orderedProductIds // ignore: cast_nullable_to_non_nullable
as List<int>,enableCodeGeneration: null == enableCodeGeneration ? _self.enableCodeGeneration : enableCodeGeneration // ignore: cast_nullable_to_non_nullable
as bool,invoiceNumber: null == invoiceNumber ? _self.invoiceNumber : invoiceNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$SalesInvoiceState {

 SalesInvoiceFormData get form;
/// Create a copy of SalesInvoiceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesInvoiceStateCopyWith<SalesInvoiceState> get copyWith => _$SalesInvoiceStateCopyWithImpl<SalesInvoiceState>(this as SalesInvoiceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesInvoiceState&&(identical(other.form, form) || other.form == form));
}


@override
int get hashCode => Object.hash(runtimeType,form);

@override
String toString() {
  return 'SalesInvoiceState(form: $form)';
}


}

/// @nodoc
abstract mixin class $SalesInvoiceStateCopyWith<$Res>  {
  factory $SalesInvoiceStateCopyWith(SalesInvoiceState value, $Res Function(SalesInvoiceState) _then) = _$SalesInvoiceStateCopyWithImpl;
@useResult
$Res call({
 SalesInvoiceFormData form
});


$SalesInvoiceFormDataCopyWith<$Res> get form;

}
/// @nodoc
class _$SalesInvoiceStateCopyWithImpl<$Res>
    implements $SalesInvoiceStateCopyWith<$Res> {
  _$SalesInvoiceStateCopyWithImpl(this._self, this._then);

  final SalesInvoiceState _self;
  final $Res Function(SalesInvoiceState) _then;

/// Create a copy of SalesInvoiceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? form = null,}) {
  return _then(_self.copyWith(
form: null == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as SalesInvoiceFormData,
  ));
}
/// Create a copy of SalesInvoiceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalesInvoiceFormDataCopyWith<$Res> get form {
  
  return $SalesInvoiceFormDataCopyWith<$Res>(_self.form, (value) {
    return _then(_self.copyWith(form: value));
  });
}
}


/// Adds pattern-matching-related methods to [SalesInvoiceState].
extension SalesInvoiceStatePatterns on SalesInvoiceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SalesInvoiceEditing value)?  editing,TResult Function( SalesInvoiceFeedback value)?  feedback,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SalesInvoiceEditing() when editing != null:
return editing(_that);case SalesInvoiceFeedback() when feedback != null:
return feedback(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SalesInvoiceEditing value)  editing,required TResult Function( SalesInvoiceFeedback value)  feedback,}){
final _that = this;
switch (_that) {
case SalesInvoiceEditing():
return editing(_that);case SalesInvoiceFeedback():
return feedback(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SalesInvoiceEditing value)?  editing,TResult? Function( SalesInvoiceFeedback value)?  feedback,}){
final _that = this;
switch (_that) {
case SalesInvoiceEditing() when editing != null:
return editing(_that);case SalesInvoiceFeedback() when feedback != null:
return feedback(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( SalesInvoiceFormData form)?  editing,TResult Function( SalesInvoiceFormData form,  String message)?  feedback,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SalesInvoiceEditing() when editing != null:
return editing(_that.form);case SalesInvoiceFeedback() when feedback != null:
return feedback(_that.form,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( SalesInvoiceFormData form)  editing,required TResult Function( SalesInvoiceFormData form,  String message)  feedback,}) {final _that = this;
switch (_that) {
case SalesInvoiceEditing():
return editing(_that.form);case SalesInvoiceFeedback():
return feedback(_that.form,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( SalesInvoiceFormData form)?  editing,TResult? Function( SalesInvoiceFormData form,  String message)?  feedback,}) {final _that = this;
switch (_that) {
case SalesInvoiceEditing() when editing != null:
return editing(_that.form);case SalesInvoiceFeedback() when feedback != null:
return feedback(_that.form,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SalesInvoiceEditing implements SalesInvoiceState {
  const SalesInvoiceEditing({required this.form});
  

@override final  SalesInvoiceFormData form;

/// Create a copy of SalesInvoiceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesInvoiceEditingCopyWith<SalesInvoiceEditing> get copyWith => _$SalesInvoiceEditingCopyWithImpl<SalesInvoiceEditing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesInvoiceEditing&&(identical(other.form, form) || other.form == form));
}


@override
int get hashCode => Object.hash(runtimeType,form);

@override
String toString() {
  return 'SalesInvoiceState.editing(form: $form)';
}


}

/// @nodoc
abstract mixin class $SalesInvoiceEditingCopyWith<$Res> implements $SalesInvoiceStateCopyWith<$Res> {
  factory $SalesInvoiceEditingCopyWith(SalesInvoiceEditing value, $Res Function(SalesInvoiceEditing) _then) = _$SalesInvoiceEditingCopyWithImpl;
@override @useResult
$Res call({
 SalesInvoiceFormData form
});


@override $SalesInvoiceFormDataCopyWith<$Res> get form;

}
/// @nodoc
class _$SalesInvoiceEditingCopyWithImpl<$Res>
    implements $SalesInvoiceEditingCopyWith<$Res> {
  _$SalesInvoiceEditingCopyWithImpl(this._self, this._then);

  final SalesInvoiceEditing _self;
  final $Res Function(SalesInvoiceEditing) _then;

/// Create a copy of SalesInvoiceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? form = null,}) {
  return _then(SalesInvoiceEditing(
form: null == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as SalesInvoiceFormData,
  ));
}

/// Create a copy of SalesInvoiceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalesInvoiceFormDataCopyWith<$Res> get form {
  
  return $SalesInvoiceFormDataCopyWith<$Res>(_self.form, (value) {
    return _then(_self.copyWith(form: value));
  });
}
}

/// @nodoc


class SalesInvoiceFeedback implements SalesInvoiceState {
  const SalesInvoiceFeedback({required this.form, required this.message});
  

@override final  SalesInvoiceFormData form;
 final  String message;

/// Create a copy of SalesInvoiceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SalesInvoiceFeedbackCopyWith<SalesInvoiceFeedback> get copyWith => _$SalesInvoiceFeedbackCopyWithImpl<SalesInvoiceFeedback>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SalesInvoiceFeedback&&(identical(other.form, form) || other.form == form)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,form,message);

@override
String toString() {
  return 'SalesInvoiceState.feedback(form: $form, message: $message)';
}


}

/// @nodoc
abstract mixin class $SalesInvoiceFeedbackCopyWith<$Res> implements $SalesInvoiceStateCopyWith<$Res> {
  factory $SalesInvoiceFeedbackCopyWith(SalesInvoiceFeedback value, $Res Function(SalesInvoiceFeedback) _then) = _$SalesInvoiceFeedbackCopyWithImpl;
@override @useResult
$Res call({
 SalesInvoiceFormData form, String message
});


@override $SalesInvoiceFormDataCopyWith<$Res> get form;

}
/// @nodoc
class _$SalesInvoiceFeedbackCopyWithImpl<$Res>
    implements $SalesInvoiceFeedbackCopyWith<$Res> {
  _$SalesInvoiceFeedbackCopyWithImpl(this._self, this._then);

  final SalesInvoiceFeedback _self;
  final $Res Function(SalesInvoiceFeedback) _then;

/// Create a copy of SalesInvoiceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? form = null,Object? message = null,}) {
  return _then(SalesInvoiceFeedback(
form: null == form ? _self.form : form // ignore: cast_nullable_to_non_nullable
as SalesInvoiceFormData,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of SalesInvoiceState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SalesInvoiceFormDataCopyWith<$Res> get form {
  
  return $SalesInvoiceFormDataCopyWith<$Res>(_self.form, (value) {
    return _then(_self.copyWith(form: value));
  });
}
}

// dart format on
