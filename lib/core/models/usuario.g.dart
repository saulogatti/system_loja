// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usuario _$UsuarioFromJson(Map<String, dynamic> json) => Usuario.withDados(
      id: (json['id'] as num).toInt(),
      dadosUsuario:
          DadosUsuario.fromJson(json['dadosUsuario'] as Map<String, dynamic>),
      dataCadastro: json['data_cadastro'] == null
          ? null
          : DateTime.parse(json['data_cadastro'] as String),
      dataUltimaAtualizacao: json['data_ultima_atualizacao'] == null
          ? null
          : DateTime.parse(json['data_ultima_atualizacao'] as String),
    );

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
      'id': instance.id,
      'dadosUsuario': instance.dadosUsuario.toJson(),
      'data_cadastro': instance.dataCadastro.toIso8601String(),
      'data_ultima_atualizacao':
          instance.dataUltimaAtualizacao.toIso8601String(),
    };

DadosUsuario _$DadosUsuarioFromJson(Map<String, dynamic> json) => DadosUsuario(
      nome: json['nome'] as String,
      email: json['email'] as String,
      senhaHash: json['senha_hash'] as String,
      nivelPermissao:
          $enumDecode(_$NivelPermissaoEnumMap, json['nivel_permissao']),
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
