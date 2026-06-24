// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'usuario_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UsuarioState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsuarioState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsuarioState()';
}


}

/// @nodoc
class $UsuarioStateCopyWith<$Res>  {
$UsuarioStateCopyWith(UsuarioState _, $Res Function(UsuarioState) __);
}


/// Adds pattern-matching-related methods to [UsuarioState].
extension UsuarioStatePatterns on UsuarioState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UsuarioStateInitial value)?  initial,TResult Function( UsuarioStateLoadFailure value)?  loadFailure,TResult Function( UsuarioStateLoading value)?  loading,TResult Function( UsuarioStateLoadSuccess value)?  loadSuccess,TResult Function( UsuarioStateSenhaInvalida value)?  senhaInvalida,TResult Function( UsuarioStateUsuarioRemovido value)?  usuarioRemovido,TResult Function( UsuarioStateUsuarioAdicionado value)?  usuarioAdicionado,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UsuarioStateInitial() when initial != null:
return initial(_that);case UsuarioStateLoadFailure() when loadFailure != null:
return loadFailure(_that);case UsuarioStateLoading() when loading != null:
return loading(_that);case UsuarioStateLoadSuccess() when loadSuccess != null:
return loadSuccess(_that);case UsuarioStateSenhaInvalida() when senhaInvalida != null:
return senhaInvalida(_that);case UsuarioStateUsuarioRemovido() when usuarioRemovido != null:
return usuarioRemovido(_that);case UsuarioStateUsuarioAdicionado() when usuarioAdicionado != null:
return usuarioAdicionado(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UsuarioStateInitial value)  initial,required TResult Function( UsuarioStateLoadFailure value)  loadFailure,required TResult Function( UsuarioStateLoading value)  loading,required TResult Function( UsuarioStateLoadSuccess value)  loadSuccess,required TResult Function( UsuarioStateSenhaInvalida value)  senhaInvalida,required TResult Function( UsuarioStateUsuarioRemovido value)  usuarioRemovido,required TResult Function( UsuarioStateUsuarioAdicionado value)  usuarioAdicionado,}){
final _that = this;
switch (_that) {
case UsuarioStateInitial():
return initial(_that);case UsuarioStateLoadFailure():
return loadFailure(_that);case UsuarioStateLoading():
return loading(_that);case UsuarioStateLoadSuccess():
return loadSuccess(_that);case UsuarioStateSenhaInvalida():
return senhaInvalida(_that);case UsuarioStateUsuarioRemovido():
return usuarioRemovido(_that);case UsuarioStateUsuarioAdicionado():
return usuarioAdicionado(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UsuarioStateInitial value)?  initial,TResult? Function( UsuarioStateLoadFailure value)?  loadFailure,TResult? Function( UsuarioStateLoading value)?  loading,TResult? Function( UsuarioStateLoadSuccess value)?  loadSuccess,TResult? Function( UsuarioStateSenhaInvalida value)?  senhaInvalida,TResult? Function( UsuarioStateUsuarioRemovido value)?  usuarioRemovido,TResult? Function( UsuarioStateUsuarioAdicionado value)?  usuarioAdicionado,}){
final _that = this;
switch (_that) {
case UsuarioStateInitial() when initial != null:
return initial(_that);case UsuarioStateLoadFailure() when loadFailure != null:
return loadFailure(_that);case UsuarioStateLoading() when loading != null:
return loading(_that);case UsuarioStateLoadSuccess() when loadSuccess != null:
return loadSuccess(_that);case UsuarioStateSenhaInvalida() when senhaInvalida != null:
return senhaInvalida(_that);case UsuarioStateUsuarioRemovido() when usuarioRemovido != null:
return usuarioRemovido(_that);case UsuarioStateUsuarioAdicionado() when usuarioAdicionado != null:
return usuarioAdicionado(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String errorMessage)?  loadFailure,TResult Function()?  loading,TResult Function( List<User> usuarios)?  loadSuccess,TResult Function( String mensagem)?  senhaInvalida,TResult Function( int id)?  usuarioRemovido,TResult Function( User usuario,  bool novoUsuario)?  usuarioAdicionado,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UsuarioStateInitial() when initial != null:
return initial();case UsuarioStateLoadFailure() when loadFailure != null:
return loadFailure(_that.errorMessage);case UsuarioStateLoading() when loading != null:
return loading();case UsuarioStateLoadSuccess() when loadSuccess != null:
return loadSuccess(_that.usuarios);case UsuarioStateSenhaInvalida() when senhaInvalida != null:
return senhaInvalida(_that.mensagem);case UsuarioStateUsuarioRemovido() when usuarioRemovido != null:
return usuarioRemovido(_that.id);case UsuarioStateUsuarioAdicionado() when usuarioAdicionado != null:
return usuarioAdicionado(_that.usuario,_that.novoUsuario);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String errorMessage)  loadFailure,required TResult Function()  loading,required TResult Function( List<User> usuarios)  loadSuccess,required TResult Function( String mensagem)  senhaInvalida,required TResult Function( int id)  usuarioRemovido,required TResult Function( User usuario,  bool novoUsuario)  usuarioAdicionado,}) {final _that = this;
switch (_that) {
case UsuarioStateInitial():
return initial();case UsuarioStateLoadFailure():
return loadFailure(_that.errorMessage);case UsuarioStateLoading():
return loading();case UsuarioStateLoadSuccess():
return loadSuccess(_that.usuarios);case UsuarioStateSenhaInvalida():
return senhaInvalida(_that.mensagem);case UsuarioStateUsuarioRemovido():
return usuarioRemovido(_that.id);case UsuarioStateUsuarioAdicionado():
return usuarioAdicionado(_that.usuario,_that.novoUsuario);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String errorMessage)?  loadFailure,TResult? Function()?  loading,TResult? Function( List<User> usuarios)?  loadSuccess,TResult? Function( String mensagem)?  senhaInvalida,TResult? Function( int id)?  usuarioRemovido,TResult? Function( User usuario,  bool novoUsuario)?  usuarioAdicionado,}) {final _that = this;
switch (_that) {
case UsuarioStateInitial() when initial != null:
return initial();case UsuarioStateLoadFailure() when loadFailure != null:
return loadFailure(_that.errorMessage);case UsuarioStateLoading() when loading != null:
return loading();case UsuarioStateLoadSuccess() when loadSuccess != null:
return loadSuccess(_that.usuarios);case UsuarioStateSenhaInvalida() when senhaInvalida != null:
return senhaInvalida(_that.mensagem);case UsuarioStateUsuarioRemovido() when usuarioRemovido != null:
return usuarioRemovido(_that.id);case UsuarioStateUsuarioAdicionado() when usuarioAdicionado != null:
return usuarioAdicionado(_that.usuario,_that.novoUsuario);case _:
  return null;

}
}

}

/// @nodoc


class UsuarioStateInitial implements UsuarioState {
   UsuarioStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsuarioStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsuarioState.initial()';
}


}




/// @nodoc


class UsuarioStateLoadFailure implements UsuarioState {
  const UsuarioStateLoadFailure({required this.errorMessage});
  

 final  String errorMessage;

/// Create a copy of UsuarioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsuarioStateLoadFailureCopyWith<UsuarioStateLoadFailure> get copyWith => _$UsuarioStateLoadFailureCopyWithImpl<UsuarioStateLoadFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsuarioStateLoadFailure&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'UsuarioState.loadFailure(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $UsuarioStateLoadFailureCopyWith<$Res> implements $UsuarioStateCopyWith<$Res> {
  factory $UsuarioStateLoadFailureCopyWith(UsuarioStateLoadFailure value, $Res Function(UsuarioStateLoadFailure) _then) = _$UsuarioStateLoadFailureCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}
/// @nodoc
class _$UsuarioStateLoadFailureCopyWithImpl<$Res>
    implements $UsuarioStateLoadFailureCopyWith<$Res> {
  _$UsuarioStateLoadFailureCopyWithImpl(this._self, this._then);

  final UsuarioStateLoadFailure _self;
  final $Res Function(UsuarioStateLoadFailure) _then;

/// Create a copy of UsuarioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(UsuarioStateLoadFailure(
errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UsuarioStateLoading implements UsuarioState {
  const UsuarioStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsuarioStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UsuarioState.loading()';
}


}




/// @nodoc


class UsuarioStateLoadSuccess implements UsuarioState {
  const UsuarioStateLoadSuccess({required  List<User> usuarios}): _usuarios = usuarios;
  

 final  List<User> _usuarios;
 List<User> get usuarios {
  if (_usuarios is EqualUnmodifiableListView) return _usuarios;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_usuarios);
}


/// Create a copy of UsuarioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsuarioStateLoadSuccessCopyWith<UsuarioStateLoadSuccess> get copyWith => _$UsuarioStateLoadSuccessCopyWithImpl<UsuarioStateLoadSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsuarioStateLoadSuccess&&const DeepCollectionEquality().equals(other._usuarios, _usuarios));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_usuarios));

@override
String toString() {
  return 'UsuarioState.loadSuccess(usuarios: $usuarios)';
}


}

/// @nodoc
abstract mixin class $UsuarioStateLoadSuccessCopyWith<$Res> implements $UsuarioStateCopyWith<$Res> {
  factory $UsuarioStateLoadSuccessCopyWith(UsuarioStateLoadSuccess value, $Res Function(UsuarioStateLoadSuccess) _then) = _$UsuarioStateLoadSuccessCopyWithImpl;
@useResult
$Res call({
 List<User> usuarios
});




}
/// @nodoc
class _$UsuarioStateLoadSuccessCopyWithImpl<$Res>
    implements $UsuarioStateLoadSuccessCopyWith<$Res> {
  _$UsuarioStateLoadSuccessCopyWithImpl(this._self, this._then);

  final UsuarioStateLoadSuccess _self;
  final $Res Function(UsuarioStateLoadSuccess) _then;

/// Create a copy of UsuarioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? usuarios = null,}) {
  return _then(UsuarioStateLoadSuccess(
usuarios: null == usuarios ? _self._usuarios : usuarios // ignore: cast_nullable_to_non_nullable
as List<User>,
  ));
}


}

/// @nodoc


class UsuarioStateSenhaInvalida implements UsuarioState {
  const UsuarioStateSenhaInvalida(this.mensagem);
  

 final  String mensagem;

/// Create a copy of UsuarioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsuarioStateSenhaInvalidaCopyWith<UsuarioStateSenhaInvalida> get copyWith => _$UsuarioStateSenhaInvalidaCopyWithImpl<UsuarioStateSenhaInvalida>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsuarioStateSenhaInvalida&&(identical(other.mensagem, mensagem) || other.mensagem == mensagem));
}


@override
int get hashCode => Object.hash(runtimeType,mensagem);

@override
String toString() {
  return 'UsuarioState.senhaInvalida(mensagem: $mensagem)';
}


}

/// @nodoc
abstract mixin class $UsuarioStateSenhaInvalidaCopyWith<$Res> implements $UsuarioStateCopyWith<$Res> {
  factory $UsuarioStateSenhaInvalidaCopyWith(UsuarioStateSenhaInvalida value, $Res Function(UsuarioStateSenhaInvalida) _then) = _$UsuarioStateSenhaInvalidaCopyWithImpl;
@useResult
$Res call({
 String mensagem
});




}
/// @nodoc
class _$UsuarioStateSenhaInvalidaCopyWithImpl<$Res>
    implements $UsuarioStateSenhaInvalidaCopyWith<$Res> {
  _$UsuarioStateSenhaInvalidaCopyWithImpl(this._self, this._then);

  final UsuarioStateSenhaInvalida _self;
  final $Res Function(UsuarioStateSenhaInvalida) _then;

/// Create a copy of UsuarioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mensagem = null,}) {
  return _then(UsuarioStateSenhaInvalida(
null == mensagem ? _self.mensagem : mensagem // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class UsuarioStateUsuarioRemovido implements UsuarioState {
  const UsuarioStateUsuarioRemovido(this.id);
  

 final  int id;

/// Create a copy of UsuarioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsuarioStateUsuarioRemovidoCopyWith<UsuarioStateUsuarioRemovido> get copyWith => _$UsuarioStateUsuarioRemovidoCopyWithImpl<UsuarioStateUsuarioRemovido>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsuarioStateUsuarioRemovido&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'UsuarioState.usuarioRemovido(id: $id)';
}


}

/// @nodoc
abstract mixin class $UsuarioStateUsuarioRemovidoCopyWith<$Res> implements $UsuarioStateCopyWith<$Res> {
  factory $UsuarioStateUsuarioRemovidoCopyWith(UsuarioStateUsuarioRemovido value, $Res Function(UsuarioStateUsuarioRemovido) _then) = _$UsuarioStateUsuarioRemovidoCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class _$UsuarioStateUsuarioRemovidoCopyWithImpl<$Res>
    implements $UsuarioStateUsuarioRemovidoCopyWith<$Res> {
  _$UsuarioStateUsuarioRemovidoCopyWithImpl(this._self, this._then);

  final UsuarioStateUsuarioRemovido _self;
  final $Res Function(UsuarioStateUsuarioRemovido) _then;

/// Create a copy of UsuarioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(UsuarioStateUsuarioRemovido(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class UsuarioStateUsuarioAdicionado implements UsuarioState {
  const UsuarioStateUsuarioAdicionado(this.usuario, this.novoUsuario);
  

 final  User usuario;
 final  bool novoUsuario;

/// Create a copy of UsuarioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UsuarioStateUsuarioAdicionadoCopyWith<UsuarioStateUsuarioAdicionado> get copyWith => _$UsuarioStateUsuarioAdicionadoCopyWithImpl<UsuarioStateUsuarioAdicionado>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UsuarioStateUsuarioAdicionado&&(identical(other.usuario, usuario) || other.usuario == usuario)&&(identical(other.novoUsuario, novoUsuario) || other.novoUsuario == novoUsuario));
}


@override
int get hashCode => Object.hash(runtimeType,usuario,novoUsuario);

@override
String toString() {
  return 'UsuarioState.usuarioAdicionado(usuario: $usuario, novoUsuario: $novoUsuario)';
}


}

/// @nodoc
abstract mixin class $UsuarioStateUsuarioAdicionadoCopyWith<$Res> implements $UsuarioStateCopyWith<$Res> {
  factory $UsuarioStateUsuarioAdicionadoCopyWith(UsuarioStateUsuarioAdicionado value, $Res Function(UsuarioStateUsuarioAdicionado) _then) = _$UsuarioStateUsuarioAdicionadoCopyWithImpl;
@useResult
$Res call({
 User usuario, bool novoUsuario
});




}
/// @nodoc
class _$UsuarioStateUsuarioAdicionadoCopyWithImpl<$Res>
    implements $UsuarioStateUsuarioAdicionadoCopyWith<$Res> {
  _$UsuarioStateUsuarioAdicionadoCopyWithImpl(this._self, this._then);

  final UsuarioStateUsuarioAdicionado _self;
  final $Res Function(UsuarioStateUsuarioAdicionado) _then;

/// Create a copy of UsuarioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? usuario = null,Object? novoUsuario = null,}) {
  return _then(UsuarioStateUsuarioAdicionado(
null == usuario ? _self.usuario : usuario // ignore: cast_nullable_to_non_nullable
as User,null == novoUsuario ? _self.novoUsuario : novoUsuario // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
