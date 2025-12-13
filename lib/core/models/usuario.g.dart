// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DadosUsuario _$DadosUsuarioFromJson(Map<String, dynamic> json) => DadosUsuario(
  nome: json['nome'] as String,
  email: json['email'] as String,
  senhaHash: json['senha_hash'] as String,
  nivelPermissao: $enumDecode(_$NivelPermissaoEnumMap, json['nivel_permissao']),
);

Map<String, dynamic> _$DadosUsuarioToJson(DadosUsuario instance) =>
    <String, dynamic>{
      'nome': instance.nome,
      'email': instance.email,
      'senha_hash': instance.senhaHash,
      'nivel_permissao': _$NivelPermissaoEnumMap[instance.nivelPermissao]!,
    };

const _$NivelPermissaoEnumMap = {
  NivelPermissao.administrador: 'ADMINISTRADOR',
  NivelPermissao.usuarioComum: 'USUARIO_COMUM',
};

Usuario _$UsuarioFromJson(Map<String, dynamic> json) => Usuario.withDados(
  id: (json['id'] as num).toInt(),
  dadosUsuario: DadosUsuario.fromJson(
    json['dadosUsuario'] as Map<String, dynamic>,
  ),
  lastUpdatedDate: json['last_updated_date'] == null
      ? null
      : DateTime.parse(json['last_updated_date'] as String),
  registrationDate: json['registration_date'] == null
      ? null
      : DateTime.parse(json['registration_date'] as String),
);

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
  'id': instance.id,
  'registration_date': instance.registrationDate.toIso8601String(),
  'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
  'dadosUsuario': instance.dadosUsuario.toJson(),
};
