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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
      ),
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
  final Value<String?> email;
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
    this.email = const Value.absent(),
    this.id = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    required String name,
    required String passwordHash,
    required int permission,
    this.registrationDate = const Value.absent(),
  }) : name = Value(name),
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
    Value<String?>? email,
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

class $LogsRecordsTable extends LogsRecords
    with TableInfo<$LogsRecordsTable, ActivityLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogsRecordsTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<ActionType, int> actionType =
      GeneratedColumn<int>(
        'action_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ActionType>($LogsRecordsTable.$converteractionType);
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _entityMeta = const VerificationMeta('entity');
  @override
  late final GeneratedColumn<String> entity = GeneratedColumn<String>(
    'entity',
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
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userNameMeta = const VerificationMeta(
    'userName',
  );
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
    'user_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    actionType,
    details,
    entity,
    id,
    lastUpdatedDate,
    registrationDate,
    timestamp,
    userId,
    userName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'logs_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    if (data.containsKey('entity')) {
      context.handle(
        _entityMeta,
        entity.isAcceptableOrUnknown(data['entity']!, _entityMeta),
      );
    } else if (isInserting) {
      context.missing(_entityMeta);
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
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(
        _userNameMeta,
        userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta),
      );
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      userName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_name'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      )!,
      lastUpdatedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_date'],
      )!,
      registrationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}registration_date'],
      )!,
    );
  }

  @override
  $LogsRecordsTable createAlias(String alias) {
    return $LogsRecordsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ActionType, int, int> $converteractionType =
      const EnumIndexConverter<ActionType>(ActionType.values);
}

class LogsRecordsCompanion extends UpdateCompanion<ActivityLog> {
  final Value<ActionType> actionType;
  final Value<String> details;
  final Value<String> entity;
  final Value<int> id;
  final Value<DateTime> lastUpdatedDate;
  final Value<DateTime> registrationDate;
  final Value<DateTime> timestamp;
  final Value<int> userId;
  final Value<String> userName;
  const LogsRecordsCompanion({
    this.actionType = const Value.absent(),
    this.details = const Value.absent(),
    this.entity = const Value.absent(),
    this.id = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    this.registrationDate = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.userId = const Value.absent(),
    this.userName = const Value.absent(),
  });
  LogsRecordsCompanion.insert({
    required ActionType actionType,
    this.details = const Value.absent(),
    required String entity,
    this.id = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    this.registrationDate = const Value.absent(),
    this.timestamp = const Value.absent(),
    required int userId,
    required String userName,
  }) : actionType = Value(actionType),
       entity = Value(entity),
       userId = Value(userId),
       userName = Value(userName);
  static Insertable<ActivityLog> custom({
    Expression<int>? actionType,
    Expression<String>? details,
    Expression<String>? entity,
    Expression<int>? id,
    Expression<DateTime>? lastUpdatedDate,
    Expression<DateTime>? registrationDate,
    Expression<DateTime>? timestamp,
    Expression<int>? userId,
    Expression<String>? userName,
  }) {
    return RawValuesInsertable({
      if (actionType != null) 'action_type': actionType,
      if (details != null) 'details': details,
      if (entity != null) 'entity': entity,
      if (id != null) 'id': id,
      if (lastUpdatedDate != null) 'last_updated_date': lastUpdatedDate,
      if (registrationDate != null) 'registration_date': registrationDate,
      if (timestamp != null) 'timestamp': timestamp,
      if (userId != null) 'user_id': userId,
      if (userName != null) 'user_name': userName,
    });
  }

  LogsRecordsCompanion copyWith({
    Value<ActionType>? actionType,
    Value<String>? details,
    Value<String>? entity,
    Value<int>? id,
    Value<DateTime>? lastUpdatedDate,
    Value<DateTime>? registrationDate,
    Value<DateTime>? timestamp,
    Value<int>? userId,
    Value<String>? userName,
  }) {
    return LogsRecordsCompanion(
      actionType: actionType ?? this.actionType,
      details: details ?? this.details,
      entity: entity ?? this.entity,
      id: id ?? this.id,
      lastUpdatedDate: lastUpdatedDate ?? this.lastUpdatedDate,
      registrationDate: registrationDate ?? this.registrationDate,
      timestamp: timestamp ?? this.timestamp,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (actionType.present) {
      map['action_type'] = Variable<int>(
        $LogsRecordsTable.$converteractionType.toSql(actionType.value),
      );
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (entity.present) {
      map['entity'] = Variable<String>(entity.value);
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
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogsRecordsCompanion(')
          ..write('actionType: $actionType, ')
          ..write('details: $details, ')
          ..write('entity: $entity, ')
          ..write('id: $id, ')
          ..write('lastUpdatedDate: $lastUpdatedDate, ')
          ..write('registrationDate: $registrationDate, ')
          ..write('timestamp: $timestamp, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName')
          ..write(')'))
        .toString();
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
      Value<String?> email,
      Value<int> id,
      Value<DateTime?> lastUpdatedDate,
      required String name,
      required String passwordHash,
      required int permission,
      Value<DateTime> registrationDate,
    });
typedef $$UsersRecordsTableUpdateCompanionBuilder =
    UsersRecordsCompanion Function({
      Value<String?> email,
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
                Value<String?> email = const Value.absent(),
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
                Value<String?> email = const Value.absent(),
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
      required ActionType actionType,
      Value<String> details,
      required String entity,
      Value<int> id,
      Value<DateTime> lastUpdatedDate,
      Value<DateTime> registrationDate,
      Value<DateTime> timestamp,
      required int userId,
      required String userName,
    });
typedef $$LogsRecordsTableUpdateCompanionBuilder =
    LogsRecordsCompanion Function({
      Value<ActionType> actionType,
      Value<String> details,
      Value<String> entity,
      Value<int> id,
      Value<DateTime> lastUpdatedDate,
      Value<DateTime> registrationDate,
      Value<DateTime> timestamp,
      Value<int> userId,
      Value<String> userName,
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
  ColumnWithTypeConverterFilters<ActionType, ActionType, int> get actionType =>
      $composableBuilder(
        column: $table.actionType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entity => $composableBuilder(
    column: $table.entity,
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

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userName => $composableBuilder(
    column: $table.userName,
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
  ColumnOrderings<int> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entity => $composableBuilder(
    column: $table.entity,
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

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userName => $composableBuilder(
    column: $table.userName,
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
  GeneratedColumnWithTypeConverter<ActionType, int> get actionType =>
      $composableBuilder(
        column: $table.actionType,
        builder: (column) => column,
      );

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<String> get entity =>
      $composableBuilder(column: $table.entity, builder: (column) => column);

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

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);
}

class $$LogsRecordsTableTableManager
    extends
        RootTableManager<
          _$SystemDatabase,
          $LogsRecordsTable,
          ActivityLog,
          $$LogsRecordsTableFilterComposer,
          $$LogsRecordsTableOrderingComposer,
          $$LogsRecordsTableAnnotationComposer,
          $$LogsRecordsTableCreateCompanionBuilder,
          $$LogsRecordsTableUpdateCompanionBuilder,
          (
            ActivityLog,
            BaseReferences<_$SystemDatabase, $LogsRecordsTable, ActivityLog>,
          ),
          ActivityLog,
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
                Value<ActionType> actionType = const Value.absent(),
                Value<String> details = const Value.absent(),
                Value<String> entity = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<DateTime> lastUpdatedDate = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> userName = const Value.absent(),
              }) => LogsRecordsCompanion(
                actionType: actionType,
                details: details,
                entity: entity,
                id: id,
                lastUpdatedDate: lastUpdatedDate,
                registrationDate: registrationDate,
                timestamp: timestamp,
                userId: userId,
                userName: userName,
              ),
          createCompanionCallback:
              ({
                required ActionType actionType,
                Value<String> details = const Value.absent(),
                required String entity,
                Value<int> id = const Value.absent(),
                Value<DateTime> lastUpdatedDate = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                required int userId,
                required String userName,
              }) => LogsRecordsCompanion.insert(
                actionType: actionType,
                details: details,
                entity: entity,
                id: id,
                lastUpdatedDate: lastUpdatedDate,
                registrationDate: registrationDate,
                timestamp: timestamp,
                userId: userId,
                userName: userName,
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
      ActivityLog,
      $$LogsRecordsTableFilterComposer,
      $$LogsRecordsTableOrderingComposer,
      $$LogsRecordsTableAnnotationComposer,
      $$LogsRecordsTableCreateCompanionBuilder,
      $$LogsRecordsTableUpdateCompanionBuilder,
      (
        ActivityLog,
        BaseReferences<_$SystemDatabase, $LogsRecordsTable, ActivityLog>,
      ),
      ActivityLog,
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
