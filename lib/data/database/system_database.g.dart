// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_database.dart';

// ignore_for_file: type=lint
class $UsersRecordsTable extends UsersRecords
    with TableInfo<$UsersRecordsTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _lastUpdatedDateMeta = const VerificationMeta(
    'lastUpdatedDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedDate =
      GeneratedColumn<DateTime>(
        'last_updated_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _permissionMeta = const VerificationMeta(
    'permission',
  );
  @override
  late final GeneratedColumn<int> permission = GeneratedColumn<int>(
    'permission',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _registrationDateMeta = const VerificationMeta(
    'registrationDate',
  );
  @override
  late final GeneratedColumn<DateTime> registrationDate =
      GeneratedColumn<DateTime>(
        'registration_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  @override
  List<GeneratedColumn> get $columns => [
    email,
    id,
    lastUpdatedDate,
    name,
    passwordHash,
    permission,
    registrationDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('last_updated_date')) {
      context.handle(
        _lastUpdatedDateMeta,
        lastUpdatedDate.isAcceptableOrUnknown(
          data['last_updated_date']!,
          _lastUpdatedDateMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('permission')) {
      context.handle(
        _permissionMeta,
        permission.isAcceptableOrUnknown(data['permission']!, _permissionMeta),
      );
    } else if (isInserting) {
      context.missing(_permissionMeta);
    }
    if (data.containsKey('registration_date')) {
      context.handle(
        _registrationDateMeta,
        registrationDate.isAcceptableOrUnknown(
          data['registration_date']!,
          _registrationDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      )!,
      permission: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}permission'],
      )!,
      registrationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}registration_date'],
      )!,
      lastUpdatedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_date'],
      ),
    );
  }

  @override
  $UsersRecordsTable createAlias(String alias) {
    return $UsersRecordsTable(attachedDatabase, alias);
  }
}

class UsersRecordsCompanion extends UpdateCompanion<User> {
  final Value<String> email;
  final Value<int> id;
  final Value<DateTime?> lastUpdatedDate;
  final Value<String> name;
  final Value<String> passwordHash;
  final Value<int> permission;
  final Value<DateTime> registrationDate;
  const UsersRecordsCompanion({
    this.email = const Value.absent(),
    this.id = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    this.name = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.permission = const Value.absent(),
    this.registrationDate = const Value.absent(),
  });
  UsersRecordsCompanion.insert({
    required String email,
    this.id = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    required String name,
    required String passwordHash,
    required int permission,
    this.registrationDate = const Value.absent(),
  }) : email = Value(email),
       name = Value(name),
       passwordHash = Value(passwordHash),
       permission = Value(permission);
  static Insertable<User> custom({
    Expression<String>? email,
    Expression<int>? id,
    Expression<DateTime>? lastUpdatedDate,
    Expression<String>? name,
    Expression<String>? passwordHash,
    Expression<int>? permission,
    Expression<DateTime>? registrationDate,
  }) {
    return RawValuesInsertable({
      if (email != null) 'email': email,
      if (id != null) 'id': id,
      if (lastUpdatedDate != null) 'last_updated_date': lastUpdatedDate,
      if (name != null) 'name': name,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (permission != null) 'permission': permission,
      if (registrationDate != null) 'registration_date': registrationDate,
    });
  }

  UsersRecordsCompanion copyWith({
    Value<String>? email,
    Value<int>? id,
    Value<DateTime?>? lastUpdatedDate,
    Value<String>? name,
    Value<String>? passwordHash,
    Value<int>? permission,
    Value<DateTime>? registrationDate,
  }) {
    return UsersRecordsCompanion(
      email: email ?? this.email,
      id: id ?? this.id,
      lastUpdatedDate: lastUpdatedDate ?? this.lastUpdatedDate,
      name: name ?? this.name,
      passwordHash: passwordHash ?? this.passwordHash,
      permission: permission ?? this.permission,
      registrationDate: registrationDate ?? this.registrationDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lastUpdatedDate.present) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (permission.present) {
      map['permission'] = Variable<int>(permission.value);
    }
    if (registrationDate.present) {
      map['registration_date'] = Variable<DateTime>(registrationDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersRecordsCompanion(')
          ..write('email: $email, ')
          ..write('id: $id, ')
          ..write('lastUpdatedDate: $lastUpdatedDate, ')
          ..write('name: $name, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('permission: $permission, ')
          ..write('registrationDate: $registrationDate')
          ..write(')'))
        .toString();
  }
}

class _$UserInsertable implements Insertable<User> {
  User _object;
  _$UserInsertable(this._object);
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return UsersRecordsCompanion(
      email: Value(_object.email),
      id: Value(_object.id),
      lastUpdatedDate: Value(_object.lastUpdatedDate),
      name: Value(_object.name),
      passwordHash: Value(_object.passwordHash),
      permission: Value(_object.permission),
      registrationDate: Value(_object.registrationDate),
    ).toColumns(false);
  }
}

extension UserToInsertable on User {
  _$UserInsertable toInsertable() {
    return _$UserInsertable(this);
  }
}

class $LogsRecordsTable extends LogsRecords
    with TableInfo<$LogsRecordsTable, LogAtividade> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogsRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('LER'),
  );
  static const VerificationMeta _dataHoraMeta = const VerificationMeta(
    'dataHora',
  );
  @override
  late final GeneratedColumn<DateTime> dataHora = GeneratedColumn<DateTime>(
    'data_hora',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _detalhesMeta = const VerificationMeta(
    'detalhes',
  );
  @override
  late final GeneratedColumn<String> detalhes = GeneratedColumn<String>(
    'detalhes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _entidadeMeta = const VerificationMeta(
    'entidade',
  );
  @override
  late final GeneratedColumn<String> entidade = GeneratedColumn<String>(
    'entidade',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _lastUpdatedDateMeta = const VerificationMeta(
    'lastUpdatedDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdatedDate =
      GeneratedColumn<DateTime>(
        'last_updated_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  static const VerificationMeta _registrationDateMeta = const VerificationMeta(
    'registrationDate',
  );
  @override
  late final GeneratedColumn<DateTime> registrationDate =
      GeneratedColumn<DateTime>(
        'registration_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usuarioNomeMeta = const VerificationMeta(
    'usuarioNome',
  );
  @override
  late final GeneratedColumn<String> usuarioNome = GeneratedColumn<String>(
    'usuario_nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    action,
    dataHora,
    detalhes,
    entidade,
    id,
    lastUpdatedDate,
    registrationDate,
    usuarioId,
    usuarioNome,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'logs_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<LogAtividade> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    }
    if (data.containsKey('data_hora')) {
      context.handle(
        _dataHoraMeta,
        dataHora.isAcceptableOrUnknown(data['data_hora']!, _dataHoraMeta),
      );
    }
    if (data.containsKey('detalhes')) {
      context.handle(
        _detalhesMeta,
        detalhes.isAcceptableOrUnknown(data['detalhes']!, _detalhesMeta),
      );
    }
    if (data.containsKey('entidade')) {
      context.handle(
        _entidadeMeta,
        entidade.isAcceptableOrUnknown(data['entidade']!, _entidadeMeta),
      );
    } else if (isInserting) {
      context.missing(_entidadeMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('last_updated_date')) {
      context.handle(
        _lastUpdatedDateMeta,
        lastUpdatedDate.isAcceptableOrUnknown(
          data['last_updated_date']!,
          _lastUpdatedDateMeta,
        ),
      );
    }
    if (data.containsKey('registration_date')) {
      context.handle(
        _registrationDateMeta,
        registrationDate.isAcceptableOrUnknown(
          data['registration_date']!,
          _registrationDateMeta,
        ),
      );
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('usuario_nome')) {
      context.handle(
        _usuarioNomeMeta,
        usuarioNome.isAcceptableOrUnknown(
          data['usuario_nome']!,
          _usuarioNomeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_usuarioNomeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogAtividade map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogAtividade(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entidade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entidade'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      )!,
      usuarioNome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usuario_nome'],
      )!,
      dataHora: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}data_hora'],
      )!,
      detalhes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detalhes'],
      )!,
      lastUpdatedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_date'],
      )!,
      registrationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}registration_date'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
    );
  }

  @override
  $LogsRecordsTable createAlias(String alias) {
    return $LogsRecordsTable(attachedDatabase, alias);
  }
}

class LogsRecordsCompanion extends UpdateCompanion<LogAtividade> {
  final Value<String> action;
  final Value<DateTime> dataHora;
  final Value<String> detalhes;
  final Value<String> entidade;
  final Value<int> id;
  final Value<DateTime> lastUpdatedDate;
  final Value<DateTime> registrationDate;
  final Value<int> usuarioId;
  final Value<String> usuarioNome;
  const LogsRecordsCompanion({
    this.action = const Value.absent(),
    this.dataHora = const Value.absent(),
    this.detalhes = const Value.absent(),
    this.entidade = const Value.absent(),
    this.id = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    this.registrationDate = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.usuarioNome = const Value.absent(),
  });
  LogsRecordsCompanion.insert({
    this.action = const Value.absent(),
    this.dataHora = const Value.absent(),
    this.detalhes = const Value.absent(),
    required String entidade,
    this.id = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    this.registrationDate = const Value.absent(),
    required int usuarioId,
    required String usuarioNome,
  }) : entidade = Value(entidade),
       usuarioId = Value(usuarioId),
       usuarioNome = Value(usuarioNome);
  static Insertable<LogAtividade> custom({
    Expression<String>? action,
    Expression<DateTime>? dataHora,
    Expression<String>? detalhes,
    Expression<String>? entidade,
    Expression<int>? id,
    Expression<DateTime>? lastUpdatedDate,
    Expression<DateTime>? registrationDate,
    Expression<int>? usuarioId,
    Expression<String>? usuarioNome,
  }) {
    return RawValuesInsertable({
      if (action != null) 'action': action,
      if (dataHora != null) 'data_hora': dataHora,
      if (detalhes != null) 'detalhes': detalhes,
      if (entidade != null) 'entidade': entidade,
      if (id != null) 'id': id,
      if (lastUpdatedDate != null) 'last_updated_date': lastUpdatedDate,
      if (registrationDate != null) 'registration_date': registrationDate,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (usuarioNome != null) 'usuario_nome': usuarioNome,
    });
  }

  LogsRecordsCompanion copyWith({
    Value<String>? action,
    Value<DateTime>? dataHora,
    Value<String>? detalhes,
    Value<String>? entidade,
    Value<int>? id,
    Value<DateTime>? lastUpdatedDate,
    Value<DateTime>? registrationDate,
    Value<int>? usuarioId,
    Value<String>? usuarioNome,
  }) {
    return LogsRecordsCompanion(
      action: action ?? this.action,
      dataHora: dataHora ?? this.dataHora,
      detalhes: detalhes ?? this.detalhes,
      entidade: entidade ?? this.entidade,
      id: id ?? this.id,
      lastUpdatedDate: lastUpdatedDate ?? this.lastUpdatedDate,
      registrationDate: registrationDate ?? this.registrationDate,
      usuarioId: usuarioId ?? this.usuarioId,
      usuarioNome: usuarioNome ?? this.usuarioNome,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (dataHora.present) {
      map['data_hora'] = Variable<DateTime>(dataHora.value);
    }
    if (detalhes.present) {
      map['detalhes'] = Variable<String>(detalhes.value);
    }
    if (entidade.present) {
      map['entidade'] = Variable<String>(entidade.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lastUpdatedDate.present) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate.value);
    }
    if (registrationDate.present) {
      map['registration_date'] = Variable<DateTime>(registrationDate.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    if (usuarioNome.present) {
      map['usuario_nome'] = Variable<String>(usuarioNome.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogsRecordsCompanion(')
          ..write('action: $action, ')
          ..write('dataHora: $dataHora, ')
          ..write('detalhes: $detalhes, ')
          ..write('entidade: $entidade, ')
          ..write('id: $id, ')
          ..write('lastUpdatedDate: $lastUpdatedDate, ')
          ..write('registrationDate: $registrationDate, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('usuarioNome: $usuarioNome')
          ..write(')'))
        .toString();
  }
}

class _$LogAtividadeInsertable implements Insertable<LogAtividade> {
  LogAtividade _object;
  _$LogAtividadeInsertable(this._object);
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return LogsRecordsCompanion(
      action: Value(_object.action),
      dataHora: Value(_object.dataHora),
      detalhes: Value(_object.detalhes),
      entidade: Value(_object.entidade),
      id: Value(_object.id),
      lastUpdatedDate: Value(_object.lastUpdatedDate),
      registrationDate: Value(_object.registrationDate),
      usuarioId: Value(_object.usuarioId),
      usuarioNome: Value(_object.usuarioNome),
    ).toColumns(false);
  }
}

extension LogAtividadeToInsertable on LogAtividade {
  _$LogAtividadeInsertable toInsertable() {
    return _$LogAtividadeInsertable(this);
  }
}

abstract class _$SystemDatabase extends GeneratedDatabase {
  _$SystemDatabase(QueryExecutor e) : super(e);
  $SystemDatabaseManager get managers => $SystemDatabaseManager(this);
  late final $UsersRecordsTable usersRecords = $UsersRecordsTable(this);
  late final $LogsRecordsTable logsRecords = $LogsRecordsTable(this);
  late final UsersDao usersDao = UsersDao(this as SystemDatabase);
  late final LogDao logDao = LogDao(this as SystemDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    usersRecords,
    logsRecords,
  ];
}

typedef $$UsersRecordsTableCreateCompanionBuilder =
    UsersRecordsCompanion Function({
      required String email,
      Value<int> id,
      Value<DateTime?> lastUpdatedDate,
      required String name,
      required String passwordHash,
      required int permission,
      Value<DateTime> registrationDate,
    });
typedef $$UsersRecordsTableUpdateCompanionBuilder =
    UsersRecordsCompanion Function({
      Value<String> email,
      Value<int> id,
      Value<DateTime?> lastUpdatedDate,
      Value<String> name,
      Value<String> passwordHash,
      Value<int> permission,
      Value<DateTime> registrationDate,
    });

class $$UsersRecordsTableFilterComposer
    extends Composer<_$SystemDatabase, $UsersRecordsTable> {
  $$UsersRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get permission => $composableBuilder(
    column: $table.permission,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersRecordsTableOrderingComposer
    extends Composer<_$SystemDatabase, $UsersRecordsTable> {
  $$UsersRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get permission => $composableBuilder(
    column: $table.permission,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersRecordsTableAnnotationComposer
    extends Composer<_$SystemDatabase, $UsersRecordsTable> {
  $$UsersRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<int> get permission => $composableBuilder(
    column: $table.permission,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => column,
  );
}

class $$UsersRecordsTableTableManager
    extends
        RootTableManager<
          _$SystemDatabase,
          $UsersRecordsTable,
          User,
          $$UsersRecordsTableFilterComposer,
          $$UsersRecordsTableOrderingComposer,
          $$UsersRecordsTableAnnotationComposer,
          $$UsersRecordsTableCreateCompanionBuilder,
          $$UsersRecordsTableUpdateCompanionBuilder,
          (User, BaseReferences<_$SystemDatabase, $UsersRecordsTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersRecordsTableTableManager(_$SystemDatabase db, $UsersRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> email = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<int> permission = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
              }) => UsersRecordsCompanion(
                email: email,
                id: id,
                lastUpdatedDate: lastUpdatedDate,
                name: name,
                passwordHash: passwordHash,
                permission: permission,
                registrationDate: registrationDate,
              ),
          createCompanionCallback:
              ({
                required String email,
                Value<int> id = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                required String name,
                required String passwordHash,
                required int permission,
                Value<DateTime> registrationDate = const Value.absent(),
              }) => UsersRecordsCompanion.insert(
                email: email,
                id: id,
                lastUpdatedDate: lastUpdatedDate,
                name: name,
                passwordHash: passwordHash,
                permission: permission,
                registrationDate: registrationDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$SystemDatabase,
      $UsersRecordsTable,
      User,
      $$UsersRecordsTableFilterComposer,
      $$UsersRecordsTableOrderingComposer,
      $$UsersRecordsTableAnnotationComposer,
      $$UsersRecordsTableCreateCompanionBuilder,
      $$UsersRecordsTableUpdateCompanionBuilder,
      (User, BaseReferences<_$SystemDatabase, $UsersRecordsTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$LogsRecordsTableCreateCompanionBuilder =
    LogsRecordsCompanion Function({
      Value<String> action,
      Value<DateTime> dataHora,
      Value<String> detalhes,
      required String entidade,
      Value<int> id,
      Value<DateTime> lastUpdatedDate,
      Value<DateTime> registrationDate,
      required int usuarioId,
      required String usuarioNome,
    });
typedef $$LogsRecordsTableUpdateCompanionBuilder =
    LogsRecordsCompanion Function({
      Value<String> action,
      Value<DateTime> dataHora,
      Value<String> detalhes,
      Value<String> entidade,
      Value<int> id,
      Value<DateTime> lastUpdatedDate,
      Value<DateTime> registrationDate,
      Value<int> usuarioId,
      Value<String> usuarioNome,
    });

class $$LogsRecordsTableFilterComposer
    extends Composer<_$SystemDatabase, $LogsRecordsTable> {
  $$LogsRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dataHora => $composableBuilder(
    column: $table.dataHora,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detalhes => $composableBuilder(
    column: $table.detalhes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entidade => $composableBuilder(
    column: $table.entidade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usuarioNome => $composableBuilder(
    column: $table.usuarioNome,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LogsRecordsTableOrderingComposer
    extends Composer<_$SystemDatabase, $LogsRecordsTable> {
  $$LogsRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dataHora => $composableBuilder(
    column: $table.dataHora,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detalhes => $composableBuilder(
    column: $table.detalhes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entidade => $composableBuilder(
    column: $table.entidade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usuarioNome => $composableBuilder(
    column: $table.usuarioNome,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LogsRecordsTableAnnotationComposer
    extends Composer<_$SystemDatabase, $LogsRecordsTable> {
  $$LogsRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<DateTime> get dataHora =>
      $composableBuilder(column: $table.dataHora, builder: (column) => column);

  GeneratedColumn<String> get detalhes =>
      $composableBuilder(column: $table.detalhes, builder: (column) => column);

  GeneratedColumn<String> get entidade =>
      $composableBuilder(column: $table.entidade, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usuarioId =>
      $composableBuilder(column: $table.usuarioId, builder: (column) => column);

  GeneratedColumn<String> get usuarioNome => $composableBuilder(
    column: $table.usuarioNome,
    builder: (column) => column,
  );
}

class $$LogsRecordsTableTableManager
    extends
        RootTableManager<
          _$SystemDatabase,
          $LogsRecordsTable,
          LogAtividade,
          $$LogsRecordsTableFilterComposer,
          $$LogsRecordsTableOrderingComposer,
          $$LogsRecordsTableAnnotationComposer,
          $$LogsRecordsTableCreateCompanionBuilder,
          $$LogsRecordsTableUpdateCompanionBuilder,
          (
            LogAtividade,
            BaseReferences<_$SystemDatabase, $LogsRecordsTable, LogAtividade>,
          ),
          LogAtividade,
          PrefetchHooks Function()
        > {
  $$LogsRecordsTableTableManager(_$SystemDatabase db, $LogsRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogsRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogsRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogsRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> action = const Value.absent(),
                Value<DateTime> dataHora = const Value.absent(),
                Value<String> detalhes = const Value.absent(),
                Value<String> entidade = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<DateTime> lastUpdatedDate = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
                Value<int> usuarioId = const Value.absent(),
                Value<String> usuarioNome = const Value.absent(),
              }) => LogsRecordsCompanion(
                action: action,
                dataHora: dataHora,
                detalhes: detalhes,
                entidade: entidade,
                id: id,
                lastUpdatedDate: lastUpdatedDate,
                registrationDate: registrationDate,
                usuarioId: usuarioId,
                usuarioNome: usuarioNome,
              ),
          createCompanionCallback:
              ({
                Value<String> action = const Value.absent(),
                Value<DateTime> dataHora = const Value.absent(),
                Value<String> detalhes = const Value.absent(),
                required String entidade,
                Value<int> id = const Value.absent(),
                Value<DateTime> lastUpdatedDate = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
                required int usuarioId,
                required String usuarioNome,
              }) => LogsRecordsCompanion.insert(
                action: action,
                dataHora: dataHora,
                detalhes: detalhes,
                entidade: entidade,
                id: id,
                lastUpdatedDate: lastUpdatedDate,
                registrationDate: registrationDate,
                usuarioId: usuarioId,
                usuarioNome: usuarioNome,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LogsRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$SystemDatabase,
      $LogsRecordsTable,
      LogAtividade,
      $$LogsRecordsTableFilterComposer,
      $$LogsRecordsTableOrderingComposer,
      $$LogsRecordsTableAnnotationComposer,
      $$LogsRecordsTableCreateCompanionBuilder,
      $$LogsRecordsTableUpdateCompanionBuilder,
      (
        LogAtividade,
        BaseReferences<_$SystemDatabase, $LogsRecordsTable, LogAtividade>,
      ),
      LogAtividade,
      PrefetchHooks Function()
    >;

class $SystemDatabaseManager {
  final _$SystemDatabase _db;
  $SystemDatabaseManager(this._db);
  $$UsersRecordsTableTableManager get usersRecords =>
      $$UsersRecordsTableTableManager(_db, _db.usersRecords);
  $$LogsRecordsTableTableManager get logsRecords =>
      $$LogsRecordsTableTableManager(_db, _db.logsRecords);
}
