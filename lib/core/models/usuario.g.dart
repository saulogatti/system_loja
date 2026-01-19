// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DadosUsuario _$DadosUsuarioFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DadosUsuario',
      json,
      ($checkedConvert) {
        final val = DadosUsuario(
          nome: $checkedConvert('nome', (v) => v as String),
          email: $checkedConvert('email', (v) => v as String),
          senhaHash: $checkedConvert('senha_hash', (v) => v as String),
          nivelPermissao: $checkedConvert(
            'nivel_permissao',
            (v) => $enumDecode(_$NivelPermissaoEnumMap, v),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'senhaHash': 'senha_hash',
        'nivelPermissao': 'nivel_permissao',
      },
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

Usuario _$UsuarioFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Usuario',
  json,
  ($checkedConvert) {
    final val = Usuario.withDados(
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      dadosUsuario: $checkedConvert(
        'dadosUsuario',
        (v) => DadosUsuario.fromJson(v as Map<String, dynamic>),
      ),
      lastUpdatedDate: $checkedConvert(
        'last_updated_date',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      registrationDate: $checkedConvert(
        'registration_date',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'lastUpdatedDate': 'last_updated_date',
    'registrationDate': 'registration_date',
  },
);

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
  'id': instance.id,
  'registration_date': instance.registrationDate.toIso8601String(),
  'last_updated_date': instance.lastUpdatedDate.toIso8601String(),
  'dadosUsuario': instance.dadosUsuario.toJson(),
};
