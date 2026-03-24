// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoriesRecordsTable extends CategoriesRecords
    with TableInfo<$CategoriesRecordsTable, CategoriesRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    registrationDate,
    lastUpdatedDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoriesRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
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
    if (data.containsKey('last_updated_date')) {
      context.handle(
        _lastUpdatedDateMeta,
        lastUpdatedDate.isAcceptableOrUnknown(
          data['last_updated_date']!,
          _lastUpdatedDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoriesRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriesRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
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
  $CategoriesRecordsTable createAlias(String alias) {
    return $CategoriesRecordsTable(attachedDatabase, alias);
  }
}

class CategoriesRecord extends DataClass
    implements Insertable<CategoriesRecord> {
  /// Identificador único da categoria (auto-incrementado)
  final int id;

  /// Nome da categoria (obrigatório e único)
  final String name;

  /// Descrição opcional da categoria
  final String? description;

  /// Data de criação do registro
  final DateTime registrationDate;

  /// Data da última atualização
  final DateTime? lastUpdatedDate;
  const CategoriesRecord({
    required this.id,
    required this.name,
    this.description,
    required this.registrationDate,
    this.lastUpdatedDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['registration_date'] = Variable<DateTime>(registrationDate);
    if (!nullToAbsent || lastUpdatedDate != null) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate);
    }
    return map;
  }

  CategoriesRecordsCompanion toCompanion(bool nullToAbsent) {
    return CategoriesRecordsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      registrationDate: Value(registrationDate),
      lastUpdatedDate: lastUpdatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedDate),
    );
  }

  factory CategoriesRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriesRecord(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      registrationDate: serializer.fromJson<DateTime>(json['registrationDate']),
      lastUpdatedDate: serializer.fromJson<DateTime?>(json['lastUpdatedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'registrationDate': serializer.toJson<DateTime>(registrationDate),
      'lastUpdatedDate': serializer.toJson<DateTime?>(lastUpdatedDate),
    };
  }

  CategoriesRecord copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    DateTime? registrationDate,
    Value<DateTime?> lastUpdatedDate = const Value.absent(),
  }) => CategoriesRecord(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    registrationDate: registrationDate ?? this.registrationDate,
    lastUpdatedDate: lastUpdatedDate.present
        ? lastUpdatedDate.value
        : this.lastUpdatedDate,
  );
  CategoriesRecord copyWithCompanion(CategoriesRecordsCompanion data) {
    return CategoriesRecord(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      registrationDate: data.registrationDate.present
          ? data.registrationDate.value
          : this.registrationDate,
      lastUpdatedDate: data.lastUpdatedDate.present
          ? data.lastUpdatedDate.value
          : this.lastUpdatedDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesRecord(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('registrationDate: $registrationDate, ')
          ..write('lastUpdatedDate: $lastUpdatedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, registrationDate, lastUpdatedDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriesRecord &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.registrationDate == this.registrationDate &&
          other.lastUpdatedDate == this.lastUpdatedDate);
}

class CategoriesRecordsCompanion extends UpdateCompanion<CategoriesRecord> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> registrationDate;
  final Value<DateTime?> lastUpdatedDate;
  const CategoriesRecordsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.registrationDate = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
  });
  CategoriesRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.registrationDate = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
  }) : name = Value(name);
  static Insertable<CategoriesRecord> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? registrationDate,
    Expression<DateTime>? lastUpdatedDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (registrationDate != null) 'registration_date': registrationDate,
      if (lastUpdatedDate != null) 'last_updated_date': lastUpdatedDate,
    });
  }

  CategoriesRecordsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<DateTime>? registrationDate,
    Value<DateTime?>? lastUpdatedDate,
  }) {
    return CategoriesRecordsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      registrationDate: registrationDate ?? this.registrationDate,
      lastUpdatedDate: lastUpdatedDate ?? this.lastUpdatedDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (registrationDate.present) {
      map['registration_date'] = Variable<DateTime>(registrationDate.value);
    }
    if (lastUpdatedDate.present) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesRecordsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('registrationDate: $registrationDate, ')
          ..write('lastUpdatedDate: $lastUpdatedDate')
          ..write(')'))
        .toString();
  }
}

class $CompanyRecordsTable extends CompanyRecords
    with TableInfo<$CompanyRecordsTable, CompanyRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompanyRecordsTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<Address?, String> address =
      GeneratedColumn<String>(
        'address',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Address?>($CompanyRecordsTable.$converteraddressn);
  static const VerificationMeta _cnpjMeta = const VerificationMeta('cnpj');
  @override
  late final GeneratedColumn<String> cnpj = GeneratedColumn<String>(
    'cnpj',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
    address,
    cnpj,
    name,
    email,
    id,
    lastUpdatedDate,
    registrationDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'company_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompanyRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cnpj')) {
      context.handle(
        _cnpjMeta,
        cnpj.isAcceptableOrUnknown(data['cnpj']!, _cnpjMeta),
      );
    } else if (isInserting) {
      context.missing(_cnpjMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
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
  CompanyRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompanyRecord(
      address: $CompanyRecordsTable.$converteraddressn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}address'],
        ),
      ),
      cnpj: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cnpj'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lastUpdatedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_date'],
      ),
      registrationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}registration_date'],
      )!,
    );
  }

  @override
  $CompanyRecordsTable createAlias(String alias) {
    return $CompanyRecordsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Address, String, Object?> $converteraddress =
      AddressCodec.driftConverter;
  static JsonTypeConverter2<Address?, String?, Object?> $converteraddressn =
      JsonTypeConverter2.asNullable($converteraddress);
}

class CompanyRecord extends DataClass implements Insertable<CompanyRecord> {
  final Address? address;
  final String cnpj;
  final String name;
  final String? email;
  final int id;
  final DateTime? lastUpdatedDate;
  final DateTime registrationDate;
  const CompanyRecord({
    this.address,
    required this.cnpj,
    required this.name,
    this.email,
    required this.id,
    this.lastUpdatedDate,
    required this.registrationDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(
        $CompanyRecordsTable.$converteraddressn.toSql(address),
      );
    }
    map['cnpj'] = Variable<String>(cnpj);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || lastUpdatedDate != null) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate);
    }
    map['registration_date'] = Variable<DateTime>(registrationDate);
    return map;
  }

  CompanyRecordsCompanion toCompanion(bool nullToAbsent) {
    return CompanyRecordsCompanion(
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      cnpj: Value(cnpj),
      name: Value(name),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      id: Value(id),
      lastUpdatedDate: lastUpdatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedDate),
      registrationDate: Value(registrationDate),
    );
  }

  factory CompanyRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompanyRecord(
      address: $CompanyRecordsTable.$converteraddressn.fromJson(
        serializer.fromJson<Object?>(json['address']),
      ),
      cnpj: serializer.fromJson<String>(json['cnpj']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      id: serializer.fromJson<int>(json['id']),
      lastUpdatedDate: serializer.fromJson<DateTime?>(json['lastUpdatedDate']),
      registrationDate: serializer.fromJson<DateTime>(json['registrationDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'address': serializer.toJson<Object?>(
        $CompanyRecordsTable.$converteraddressn.toJson(address),
      ),
      'cnpj': serializer.toJson<String>(cnpj),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'id': serializer.toJson<int>(id),
      'lastUpdatedDate': serializer.toJson<DateTime?>(lastUpdatedDate),
      'registrationDate': serializer.toJson<DateTime>(registrationDate),
    };
  }

  CompanyRecord copyWith({
    Value<Address?> address = const Value.absent(),
    String? cnpj,
    String? name,
    Value<String?> email = const Value.absent(),
    int? id,
    Value<DateTime?> lastUpdatedDate = const Value.absent(),
    DateTime? registrationDate,
  }) => CompanyRecord(
    address: address.present ? address.value : this.address,
    cnpj: cnpj ?? this.cnpj,
    name: name ?? this.name,
    email: email.present ? email.value : this.email,
    id: id ?? this.id,
    lastUpdatedDate: lastUpdatedDate.present
        ? lastUpdatedDate.value
        : this.lastUpdatedDate,
    registrationDate: registrationDate ?? this.registrationDate,
  );
  CompanyRecord copyWithCompanion(CompanyRecordsCompanion data) {
    return CompanyRecord(
      address: data.address.present ? data.address.value : this.address,
      cnpj: data.cnpj.present ? data.cnpj.value : this.cnpj,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      id: data.id.present ? data.id.value : this.id,
      lastUpdatedDate: data.lastUpdatedDate.present
          ? data.lastUpdatedDate.value
          : this.lastUpdatedDate,
      registrationDate: data.registrationDate.present
          ? data.registrationDate.value
          : this.registrationDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompanyRecord(')
          ..write('address: $address, ')
          ..write('cnpj: $cnpj, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('id: $id, ')
          ..write('lastUpdatedDate: $lastUpdatedDate, ')
          ..write('registrationDate: $registrationDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    address,
    cnpj,
    name,
    email,
    id,
    lastUpdatedDate,
    registrationDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompanyRecord &&
          other.address == this.address &&
          other.cnpj == this.cnpj &&
          other.name == this.name &&
          other.email == this.email &&
          other.id == this.id &&
          other.lastUpdatedDate == this.lastUpdatedDate &&
          other.registrationDate == this.registrationDate);
}

class CompanyRecordsCompanion extends UpdateCompanion<CompanyRecord> {
  final Value<Address?> address;
  final Value<String> cnpj;
  final Value<String> name;
  final Value<String?> email;
  final Value<int> id;
  final Value<DateTime?> lastUpdatedDate;
  final Value<DateTime> registrationDate;
  const CompanyRecordsCompanion({
    this.address = const Value.absent(),
    this.cnpj = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.id = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    this.registrationDate = const Value.absent(),
  });
  CompanyRecordsCompanion.insert({
    this.address = const Value.absent(),
    required String cnpj,
    required String name,
    this.email = const Value.absent(),
    this.id = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    this.registrationDate = const Value.absent(),
  }) : cnpj = Value(cnpj),
       name = Value(name);
  static Insertable<CompanyRecord> custom({
    Expression<String>? address,
    Expression<String>? cnpj,
    Expression<String>? name,
    Expression<String>? email,
    Expression<int>? id,
    Expression<DateTime>? lastUpdatedDate,
    Expression<DateTime>? registrationDate,
  }) {
    return RawValuesInsertable({
      if (address != null) 'address': address,
      if (cnpj != null) 'cnpj': cnpj,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (id != null) 'id': id,
      if (lastUpdatedDate != null) 'last_updated_date': lastUpdatedDate,
      if (registrationDate != null) 'registration_date': registrationDate,
    });
  }

  CompanyRecordsCompanion copyWith({
    Value<Address?>? address,
    Value<String>? cnpj,
    Value<String>? name,
    Value<String?>? email,
    Value<int>? id,
    Value<DateTime?>? lastUpdatedDate,
    Value<DateTime>? registrationDate,
  }) {
    return CompanyRecordsCompanion(
      address: address ?? this.address,
      cnpj: cnpj ?? this.cnpj,
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      lastUpdatedDate: lastUpdatedDate ?? this.lastUpdatedDate,
      registrationDate: registrationDate ?? this.registrationDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (address.present) {
      map['address'] = Variable<String>(
        $CompanyRecordsTable.$converteraddressn.toSql(address.value),
      );
    }
    if (cnpj.present) {
      map['cnpj'] = Variable<String>(cnpj.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompanyRecordsCompanion(')
          ..write('address: $address, ')
          ..write('cnpj: $cnpj, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('id: $id, ')
          ..write('lastUpdatedDate: $lastUpdatedDate, ')
          ..write('registrationDate: $registrationDate')
          ..write(')'))
        .toString();
  }
}

class $CustomerRecordsTable extends CustomerRecords
    with TableInfo<$CustomerRecordsTable, CustomerRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerRecordsTable(this.attachedDatabase, [this._alias]);
  @override
  late final GeneratedColumnWithTypeConverter<Address?, String> address =
      GeneratedColumn<String>(
        'address',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Address?>($CustomerRecordsTable.$converteraddressn);
  static const VerificationMeta _cpfMeta = const VerificationMeta('cpf');
  @override
  late final GeneratedColumn<String> cpf = GeneratedColumn<String>(
    'cpf',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
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
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
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
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    address,
    cpf,
    email,
    id,
    lastUpdatedDate,
    name,
    phone,
    registrationDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cpf')) {
      context.handle(
        _cpfMeta,
        cpf.isAcceptableOrUnknown(data['cpf']!, _cpfMeta),
      );
    } else if (isInserting) {
      context.missing(_cpfMeta);
    }
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
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerRecord(
      address: $CustomerRecordsTable.$converteraddressn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}address'],
        ),
      ),
      cpf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cpf'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lastUpdatedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_date'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      registrationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}registration_date'],
      )!,
    );
  }

  @override
  $CustomerRecordsTable createAlias(String alias) {
    return $CustomerRecordsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Address, String, Object?> $converteraddress =
      AddressCodec.driftConverter;
  static JsonTypeConverter2<Address?, String?, Object?> $converteraddressn =
      JsonTypeConverter2.asNullable($converteraddress);
}

class CustomerRecord extends DataClass implements Insertable<CustomerRecord> {
  final Address? address;
  final String cpf;
  final String? email;
  final int id;
  final DateTime lastUpdatedDate;
  final String name;
  final String? phone;
  final DateTime registrationDate;
  const CustomerRecord({
    this.address,
    required this.cpf,
    this.email,
    required this.id,
    required this.lastUpdatedDate,
    required this.name,
    this.phone,
    required this.registrationDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(
        $CustomerRecordsTable.$converteraddressn.toSql(address),
      );
    }
    map['cpf'] = Variable<String>(cpf);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['id'] = Variable<int>(id);
    map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['registration_date'] = Variable<DateTime>(registrationDate);
    return map;
  }

  CustomerRecordsCompanion toCompanion(bool nullToAbsent) {
    return CustomerRecordsCompanion(
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      cpf: Value(cpf),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      id: Value(id),
      lastUpdatedDate: Value(lastUpdatedDate),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      registrationDate: Value(registrationDate),
    );
  }

  factory CustomerRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerRecord(
      address: $CustomerRecordsTable.$converteraddressn.fromJson(
        serializer.fromJson<Object?>(json['address']),
      ),
      cpf: serializer.fromJson<String>(json['cpf']),
      email: serializer.fromJson<String?>(json['email']),
      id: serializer.fromJson<int>(json['id']),
      lastUpdatedDate: serializer.fromJson<DateTime>(json['lastUpdatedDate']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      registrationDate: serializer.fromJson<DateTime>(json['registrationDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'address': serializer.toJson<Object?>(
        $CustomerRecordsTable.$converteraddressn.toJson(address),
      ),
      'cpf': serializer.toJson<String>(cpf),
      'email': serializer.toJson<String?>(email),
      'id': serializer.toJson<int>(id),
      'lastUpdatedDate': serializer.toJson<DateTime>(lastUpdatedDate),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'registrationDate': serializer.toJson<DateTime>(registrationDate),
    };
  }

  CustomerRecord copyWith({
    Value<Address?> address = const Value.absent(),
    String? cpf,
    Value<String?> email = const Value.absent(),
    int? id,
    DateTime? lastUpdatedDate,
    String? name,
    Value<String?> phone = const Value.absent(),
    DateTime? registrationDate,
  }) => CustomerRecord(
    address: address.present ? address.value : this.address,
    cpf: cpf ?? this.cpf,
    email: email.present ? email.value : this.email,
    id: id ?? this.id,
    lastUpdatedDate: lastUpdatedDate ?? this.lastUpdatedDate,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    registrationDate: registrationDate ?? this.registrationDate,
  );
  CustomerRecord copyWithCompanion(CustomerRecordsCompanion data) {
    return CustomerRecord(
      address: data.address.present ? data.address.value : this.address,
      cpf: data.cpf.present ? data.cpf.value : this.cpf,
      email: data.email.present ? data.email.value : this.email,
      id: data.id.present ? data.id.value : this.id,
      lastUpdatedDate: data.lastUpdatedDate.present
          ? data.lastUpdatedDate.value
          : this.lastUpdatedDate,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      registrationDate: data.registrationDate.present
          ? data.registrationDate.value
          : this.registrationDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerRecord(')
          ..write('address: $address, ')
          ..write('cpf: $cpf, ')
          ..write('email: $email, ')
          ..write('id: $id, ')
          ..write('lastUpdatedDate: $lastUpdatedDate, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('registrationDate: $registrationDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    address,
    cpf,
    email,
    id,
    lastUpdatedDate,
    name,
    phone,
    registrationDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerRecord &&
          other.address == this.address &&
          other.cpf == this.cpf &&
          other.email == this.email &&
          other.id == this.id &&
          other.lastUpdatedDate == this.lastUpdatedDate &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.registrationDate == this.registrationDate);
}

class CustomerRecordsCompanion extends UpdateCompanion<CustomerRecord> {
  final Value<Address?> address;
  final Value<String> cpf;
  final Value<String?> email;
  final Value<int> id;
  final Value<DateTime> lastUpdatedDate;
  final Value<String> name;
  final Value<String?> phone;
  final Value<DateTime> registrationDate;
  const CustomerRecordsCompanion({
    this.address = const Value.absent(),
    this.cpf = const Value.absent(),
    this.email = const Value.absent(),
    this.id = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.registrationDate = const Value.absent(),
  });
  CustomerRecordsCompanion.insert({
    this.address = const Value.absent(),
    required String cpf,
    this.email = const Value.absent(),
    this.id = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.registrationDate = const Value.absent(),
  }) : cpf = Value(cpf),
       name = Value(name);
  static Insertable<CustomerRecord> custom({
    Expression<String>? address,
    Expression<String>? cpf,
    Expression<String>? email,
    Expression<int>? id,
    Expression<DateTime>? lastUpdatedDate,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<DateTime>? registrationDate,
  }) {
    return RawValuesInsertable({
      if (address != null) 'address': address,
      if (cpf != null) 'cpf': cpf,
      if (email != null) 'email': email,
      if (id != null) 'id': id,
      if (lastUpdatedDate != null) 'last_updated_date': lastUpdatedDate,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (registrationDate != null) 'registration_date': registrationDate,
    });
  }

  CustomerRecordsCompanion copyWith({
    Value<Address?>? address,
    Value<String>? cpf,
    Value<String?>? email,
    Value<int>? id,
    Value<DateTime>? lastUpdatedDate,
    Value<String>? name,
    Value<String?>? phone,
    Value<DateTime>? registrationDate,
  }) {
    return CustomerRecordsCompanion(
      address: address ?? this.address,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      id: id ?? this.id,
      lastUpdatedDate: lastUpdatedDate ?? this.lastUpdatedDate,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      registrationDate: registrationDate ?? this.registrationDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (address.present) {
      map['address'] = Variable<String>(
        $CustomerRecordsTable.$converteraddressn.toSql(address.value),
      );
    }
    if (cpf.present) {
      map['cpf'] = Variable<String>(cpf.value);
    }
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
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (registrationDate.present) {
      map['registration_date'] = Variable<DateTime>(registrationDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerRecordsCompanion(')
          ..write('address: $address, ')
          ..write('cpf: $cpf, ')
          ..write('email: $email, ')
          ..write('id: $id, ')
          ..write('lastUpdatedDate: $lastUpdatedDate, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('registrationDate: $registrationDate')
          ..write(')'))
        .toString();
  }
}

class $ProductsRecordsTable extends ProductsRecords
    with TableInfo<$ProductsRecordsTable, ProductsRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
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
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories_records (id)',
    ),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
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
  static const VerificationMeta _stockQuantityMeta = const VerificationMeta(
    'stockQuantity',
  );
  @override
  late final GeneratedColumn<int> stockQuantity = GeneratedColumn<int>(
    'stock_quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    code,
    id,
    categoryId,
    description,
    lastUpdatedDate,
    name,
    price,
    registrationDate,
    stockQuantity,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductsRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
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
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
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
    if (data.containsKey('stock_quantity')) {
      context.handle(
        _stockQuantityMeta,
        stockQuantity.isAcceptableOrUnknown(
          data['stock_quantity']!,
          _stockQuantityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stockQuantityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductsRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductsRecord(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      lastUpdatedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_date'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      registrationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}registration_date'],
      )!,
      stockQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock_quantity'],
      )!,
    );
  }

  @override
  $ProductsRecordsTable createAlias(String alias) {
    return $ProductsRecordsTable(attachedDatabase, alias);
  }
}

class ProductsRecord extends DataClass implements Insertable<ProductsRecord> {
  final String code;
  final int id;

  /// ID da categoria (chave estrangeira para categories_records)
  final int? categoryId;
  final String description;
  final DateTime? lastUpdatedDate;
  final String name;
  final double price;
  final DateTime registrationDate;
  final int stockQuantity;
  const ProductsRecord({
    required this.code,
    required this.id,
    this.categoryId,
    required this.description,
    this.lastUpdatedDate,
    required this.name,
    required this.price,
    required this.registrationDate,
    required this.stockQuantity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || lastUpdatedDate != null) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate);
    }
    map['name'] = Variable<String>(name);
    map['price'] = Variable<double>(price);
    map['registration_date'] = Variable<DateTime>(registrationDate);
    map['stock_quantity'] = Variable<int>(stockQuantity);
    return map;
  }

  ProductsRecordsCompanion toCompanion(bool nullToAbsent) {
    return ProductsRecordsCompanion(
      code: Value(code),
      id: Value(id),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      description: Value(description),
      lastUpdatedDate: lastUpdatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedDate),
      name: Value(name),
      price: Value(price),
      registrationDate: Value(registrationDate),
      stockQuantity: Value(stockQuantity),
    );
  }

  factory ProductsRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductsRecord(
      code: serializer.fromJson<String>(json['code']),
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      description: serializer.fromJson<String>(json['description']),
      lastUpdatedDate: serializer.fromJson<DateTime?>(json['lastUpdatedDate']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<double>(json['price']),
      registrationDate: serializer.fromJson<DateTime>(json['registrationDate']),
      stockQuantity: serializer.fromJson<int>(json['stockQuantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int?>(categoryId),
      'description': serializer.toJson<String>(description),
      'lastUpdatedDate': serializer.toJson<DateTime?>(lastUpdatedDate),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<double>(price),
      'registrationDate': serializer.toJson<DateTime>(registrationDate),
      'stockQuantity': serializer.toJson<int>(stockQuantity),
    };
  }

  ProductsRecord copyWith({
    String? code,
    int? id,
    Value<int?> categoryId = const Value.absent(),
    String? description,
    Value<DateTime?> lastUpdatedDate = const Value.absent(),
    String? name,
    double? price,
    DateTime? registrationDate,
    int? stockQuantity,
  }) => ProductsRecord(
    code: code ?? this.code,
    id: id ?? this.id,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    description: description ?? this.description,
    lastUpdatedDate: lastUpdatedDate.present
        ? lastUpdatedDate.value
        : this.lastUpdatedDate,
    name: name ?? this.name,
    price: price ?? this.price,
    registrationDate: registrationDate ?? this.registrationDate,
    stockQuantity: stockQuantity ?? this.stockQuantity,
  );
  ProductsRecord copyWithCompanion(ProductsRecordsCompanion data) {
    return ProductsRecord(
      code: data.code.present ? data.code.value : this.code,
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      description: data.description.present
          ? data.description.value
          : this.description,
      lastUpdatedDate: data.lastUpdatedDate.present
          ? data.lastUpdatedDate.value
          : this.lastUpdatedDate,
      name: data.name.present ? data.name.value : this.name,
      price: data.price.present ? data.price.value : this.price,
      registrationDate: data.registrationDate.present
          ? data.registrationDate.value
          : this.registrationDate,
      stockQuantity: data.stockQuantity.present
          ? data.stockQuantity.value
          : this.stockQuantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductsRecord(')
          ..write('code: $code, ')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('description: $description, ')
          ..write('lastUpdatedDate: $lastUpdatedDate, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('registrationDate: $registrationDate, ')
          ..write('stockQuantity: $stockQuantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    code,
    id,
    categoryId,
    description,
    lastUpdatedDate,
    name,
    price,
    registrationDate,
    stockQuantity,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductsRecord &&
          other.code == this.code &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.description == this.description &&
          other.lastUpdatedDate == this.lastUpdatedDate &&
          other.name == this.name &&
          other.price == this.price &&
          other.registrationDate == this.registrationDate &&
          other.stockQuantity == this.stockQuantity);
}

class ProductsRecordsCompanion extends UpdateCompanion<ProductsRecord> {
  final Value<String> code;
  final Value<int> id;
  final Value<int?> categoryId;
  final Value<String> description;
  final Value<DateTime?> lastUpdatedDate;
  final Value<String> name;
  final Value<double> price;
  final Value<DateTime> registrationDate;
  final Value<int> stockQuantity;
  const ProductsRecordsCompanion({
    this.code = const Value.absent(),
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.description = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.registrationDate = const Value.absent(),
    this.stockQuantity = const Value.absent(),
  });
  ProductsRecordsCompanion.insert({
    required String code,
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    required String description,
    this.lastUpdatedDate = const Value.absent(),
    required String name,
    required double price,
    this.registrationDate = const Value.absent(),
    required int stockQuantity,
  }) : code = Value(code),
       description = Value(description),
       name = Value(name),
       price = Value(price),
       stockQuantity = Value(stockQuantity);
  static Insertable<ProductsRecord> custom({
    Expression<String>? code,
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? description,
    Expression<DateTime>? lastUpdatedDate,
    Expression<String>? name,
    Expression<double>? price,
    Expression<DateTime>? registrationDate,
    Expression<int>? stockQuantity,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (description != null) 'description': description,
      if (lastUpdatedDate != null) 'last_updated_date': lastUpdatedDate,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (registrationDate != null) 'registration_date': registrationDate,
      if (stockQuantity != null) 'stock_quantity': stockQuantity,
    });
  }

  ProductsRecordsCompanion copyWith({
    Value<String>? code,
    Value<int>? id,
    Value<int?>? categoryId,
    Value<String>? description,
    Value<DateTime?>? lastUpdatedDate,
    Value<String>? name,
    Value<double>? price,
    Value<DateTime>? registrationDate,
    Value<int>? stockQuantity,
  }) {
    return ProductsRecordsCompanion(
      code: code ?? this.code,
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      lastUpdatedDate: lastUpdatedDate ?? this.lastUpdatedDate,
      name: name ?? this.name,
      price: price ?? this.price,
      registrationDate: registrationDate ?? this.registrationDate,
      stockQuantity: stockQuantity ?? this.stockQuantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (lastUpdatedDate.present) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (registrationDate.present) {
      map['registration_date'] = Variable<DateTime>(registrationDate.value);
    }
    if (stockQuantity.present) {
      map['stock_quantity'] = Variable<int>(stockQuantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsRecordsCompanion(')
          ..write('code: $code, ')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('description: $description, ')
          ..write('lastUpdatedDate: $lastUpdatedDate, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('registrationDate: $registrationDate, ')
          ..write('stockQuantity: $stockQuantity')
          ..write(')'))
        .toString();
  }
}

class $InvoicesRecordsTable extends InvoicesRecords
    with TableInfo<$InvoicesRecordsTable, InvoicesRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _companyCnpjMeta = const VerificationMeta(
    'companyCnpj',
  );
  @override
  late final GeneratedColumn<String> companyCnpj = GeneratedColumn<String>(
    'company_cnpj',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _companyIdMeta = const VerificationMeta(
    'companyId',
  );
  @override
  late final GeneratedColumn<int> companyId = GeneratedColumn<int>(
    'company_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _companyNameMeta = const VerificationMeta(
    'companyName',
  );
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
    'company_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerCpfMeta = const VerificationMeta(
    'customerCpf',
  );
  @override
  late final GeneratedColumn<String> customerCpf = GeneratedColumn<String>(
    'customer_cpf',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
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
  static const VerificationMeta _invoiceNumberMeta = const VerificationMeta(
    'invoiceNumber',
  );
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
    'invoice_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _issueDateMeta = const VerificationMeta(
    'issueDate',
  );
  @override
  late final GeneratedColumn<DateTime> issueDate = GeneratedColumn<DateTime>(
    'issue_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
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
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _totalValueMeta = const VerificationMeta(
    'totalValue',
  );
  @override
  late final GeneratedColumn<double> totalValue = GeneratedColumn<double>(
    'total_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<InvoiceType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('exit'),
      ).withConverter<InvoiceType>($InvoicesRecordsTable.$convertertype);
  @override
  List<GeneratedColumn> get $columns => [
    companyCnpj,
    companyId,
    companyName,
    customerCpf,
    customerId,
    customerName,
    id,
    invoiceNumber,
    issueDate,
    lastUpdatedDate,
    paymentMethod,
    registrationDate,
    totalValue,
    type,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoicesRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('company_cnpj')) {
      context.handle(
        _companyCnpjMeta,
        companyCnpj.isAcceptableOrUnknown(
          data['company_cnpj']!,
          _companyCnpjMeta,
        ),
      );
    }
    if (data.containsKey('company_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta),
      );
    }
    if (data.containsKey('company_name')) {
      context.handle(
        _companyNameMeta,
        companyName.isAcceptableOrUnknown(
          data['company_name']!,
          _companyNameMeta,
        ),
      );
    }
    if (data.containsKey('customer_cpf')) {
      context.handle(
        _customerCpfMeta,
        customerCpf.isAcceptableOrUnknown(
          data['customer_cpf']!,
          _customerCpfMeta,
        ),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
        _invoiceNumberMeta,
        invoiceNumber.isAcceptableOrUnknown(
          data['invoice_number']!,
          _invoiceNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('issue_date')) {
      context.handle(
        _issueDateMeta,
        issueDate.isAcceptableOrUnknown(data['issue_date']!, _issueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_issueDateMeta);
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
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
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
    if (data.containsKey('total_value')) {
      context.handle(
        _totalValueMeta,
        totalValue.isAcceptableOrUnknown(data['total_value']!, _totalValueMeta),
      );
    } else if (isInserting) {
      context.missing(_totalValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoicesRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoicesRecord(
      companyCnpj: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_cnpj'],
      ),
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}company_id'],
      ),
      companyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_name'],
      ),
      customerCpf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_cpf'],
      ),
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_number'],
      )!,
      issueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issue_date'],
      )!,
      lastUpdatedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_date'],
      ),
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      registrationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}registration_date'],
      )!,
      totalValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_value'],
      )!,
      type: $InvoicesRecordsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
    );
  }

  @override
  $InvoicesRecordsTable createAlias(String alias) {
    return $InvoicesRecordsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<InvoiceType, String, String> $convertertype =
      const EnumNameConverter<InvoiceType>(InvoiceType.values);
}

class InvoicesRecord extends DataClass implements Insertable<InvoicesRecord> {
  /// CNPJ da empresa (desnormalizado; null quando vínculo for cliente).
  final String? companyCnpj;

  /// ID da empresa vinculada (null quando vínculo for cliente).
  final int? companyId;

  /// Nome da empresa (desnormalizado; null quando vínculo for cliente).
  final String? companyName;

  /// CPF do cliente (desnormalizado; null quando vínculo for empresa).
  final String? customerCpf;

  /// ID do cliente (null quando vínculo for empresa).
  final int? customerId;

  /// Nome do cliente (desnormalizado; null quando vínculo for empresa).
  final String? customerName;
  final int id;

  /// Número da nota fiscal.
  final String invoiceNumber;

  /// Data de emissão da nota.
  final DateTime issueDate;

  /// Data da última atualização.
  final DateTime? lastUpdatedDate;

  /// Forma de pagamento.
  final String paymentMethod;

  /// Data de cadastro no sistema.
  final DateTime registrationDate;

  /// Valor total da nota fiscal.
  final double totalValue;

  /// Tipo da nota fiscal (entrada ou saída). Padrão: saída.
  final InvoiceType type;
  const InvoicesRecord({
    this.companyCnpj,
    this.companyId,
    this.companyName,
    this.customerCpf,
    this.customerId,
    this.customerName,
    required this.id,
    required this.invoiceNumber,
    required this.issueDate,
    this.lastUpdatedDate,
    required this.paymentMethod,
    required this.registrationDate,
    required this.totalValue,
    required this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || companyCnpj != null) {
      map['company_cnpj'] = Variable<String>(companyCnpj);
    }
    if (!nullToAbsent || companyId != null) {
      map['company_id'] = Variable<int>(companyId);
    }
    if (!nullToAbsent || companyName != null) {
      map['company_name'] = Variable<String>(companyName);
    }
    if (!nullToAbsent || customerCpf != null) {
      map['customer_cpf'] = Variable<String>(customerCpf);
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    map['id'] = Variable<int>(id);
    map['invoice_number'] = Variable<String>(invoiceNumber);
    map['issue_date'] = Variable<DateTime>(issueDate);
    if (!nullToAbsent || lastUpdatedDate != null) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate);
    }
    map['payment_method'] = Variable<String>(paymentMethod);
    map['registration_date'] = Variable<DateTime>(registrationDate);
    map['total_value'] = Variable<double>(totalValue);
    {
      map['type'] = Variable<String>(
        $InvoicesRecordsTable.$convertertype.toSql(type),
      );
    }
    return map;
  }

  InvoicesRecordsCompanion toCompanion(bool nullToAbsent) {
    return InvoicesRecordsCompanion(
      companyCnpj: companyCnpj == null && nullToAbsent
          ? const Value.absent()
          : Value(companyCnpj),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
      companyName: companyName == null && nullToAbsent
          ? const Value.absent()
          : Value(companyName),
      customerCpf: customerCpf == null && nullToAbsent
          ? const Value.absent()
          : Value(customerCpf),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      id: Value(id),
      invoiceNumber: Value(invoiceNumber),
      issueDate: Value(issueDate),
      lastUpdatedDate: lastUpdatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedDate),
      paymentMethod: Value(paymentMethod),
      registrationDate: Value(registrationDate),
      totalValue: Value(totalValue),
      type: Value(type),
    );
  }

  factory InvoicesRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoicesRecord(
      companyCnpj: serializer.fromJson<String?>(json['companyCnpj']),
      companyId: serializer.fromJson<int?>(json['companyId']),
      companyName: serializer.fromJson<String?>(json['companyName']),
      customerCpf: serializer.fromJson<String?>(json['customerCpf']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      id: serializer.fromJson<int>(json['id']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      issueDate: serializer.fromJson<DateTime>(json['issueDate']),
      lastUpdatedDate: serializer.fromJson<DateTime?>(json['lastUpdatedDate']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      registrationDate: serializer.fromJson<DateTime>(json['registrationDate']),
      totalValue: serializer.fromJson<double>(json['totalValue']),
      type: $InvoicesRecordsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'companyCnpj': serializer.toJson<String?>(companyCnpj),
      'companyId': serializer.toJson<int?>(companyId),
      'companyName': serializer.toJson<String?>(companyName),
      'customerCpf': serializer.toJson<String?>(customerCpf),
      'customerId': serializer.toJson<int?>(customerId),
      'customerName': serializer.toJson<String?>(customerName),
      'id': serializer.toJson<int>(id),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'issueDate': serializer.toJson<DateTime>(issueDate),
      'lastUpdatedDate': serializer.toJson<DateTime?>(lastUpdatedDate),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'registrationDate': serializer.toJson<DateTime>(registrationDate),
      'totalValue': serializer.toJson<double>(totalValue),
      'type': serializer.toJson<String>(
        $InvoicesRecordsTable.$convertertype.toJson(type),
      ),
    };
  }

  InvoicesRecord copyWith({
    Value<String?> companyCnpj = const Value.absent(),
    Value<int?> companyId = const Value.absent(),
    Value<String?> companyName = const Value.absent(),
    Value<String?> customerCpf = const Value.absent(),
    Value<int?> customerId = const Value.absent(),
    Value<String?> customerName = const Value.absent(),
    int? id,
    String? invoiceNumber,
    DateTime? issueDate,
    Value<DateTime?> lastUpdatedDate = const Value.absent(),
    String? paymentMethod,
    DateTime? registrationDate,
    double? totalValue,
    InvoiceType? type,
  }) => InvoicesRecord(
    companyCnpj: companyCnpj.present ? companyCnpj.value : this.companyCnpj,
    companyId: companyId.present ? companyId.value : this.companyId,
    companyName: companyName.present ? companyName.value : this.companyName,
    customerCpf: customerCpf.present ? customerCpf.value : this.customerCpf,
    customerId: customerId.present ? customerId.value : this.customerId,
    customerName: customerName.present ? customerName.value : this.customerName,
    id: id ?? this.id,
    invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    issueDate: issueDate ?? this.issueDate,
    lastUpdatedDate: lastUpdatedDate.present
        ? lastUpdatedDate.value
        : this.lastUpdatedDate,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    registrationDate: registrationDate ?? this.registrationDate,
    totalValue: totalValue ?? this.totalValue,
    type: type ?? this.type,
  );
  InvoicesRecord copyWithCompanion(InvoicesRecordsCompanion data) {
    return InvoicesRecord(
      companyCnpj: data.companyCnpj.present
          ? data.companyCnpj.value
          : this.companyCnpj,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      companyName: data.companyName.present
          ? data.companyName.value
          : this.companyName,
      customerCpf: data.customerCpf.present
          ? data.customerCpf.value
          : this.customerCpf,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      id: data.id.present ? data.id.value : this.id,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      issueDate: data.issueDate.present ? data.issueDate.value : this.issueDate,
      lastUpdatedDate: data.lastUpdatedDate.present
          ? data.lastUpdatedDate.value
          : this.lastUpdatedDate,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      registrationDate: data.registrationDate.present
          ? data.registrationDate.value
          : this.registrationDate,
      totalValue: data.totalValue.present
          ? data.totalValue.value
          : this.totalValue,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesRecord(')
          ..write('companyCnpj: $companyCnpj, ')
          ..write('companyId: $companyId, ')
          ..write('companyName: $companyName, ')
          ..write('customerCpf: $customerCpf, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('issueDate: $issueDate, ')
          ..write('lastUpdatedDate: $lastUpdatedDate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('registrationDate: $registrationDate, ')
          ..write('totalValue: $totalValue, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    companyCnpj,
    companyId,
    companyName,
    customerCpf,
    customerId,
    customerName,
    id,
    invoiceNumber,
    issueDate,
    lastUpdatedDate,
    paymentMethod,
    registrationDate,
    totalValue,
    type,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoicesRecord &&
          other.companyCnpj == this.companyCnpj &&
          other.companyId == this.companyId &&
          other.companyName == this.companyName &&
          other.customerCpf == this.customerCpf &&
          other.customerId == this.customerId &&
          other.customerName == this.customerName &&
          other.id == this.id &&
          other.invoiceNumber == this.invoiceNumber &&
          other.issueDate == this.issueDate &&
          other.lastUpdatedDate == this.lastUpdatedDate &&
          other.paymentMethod == this.paymentMethod &&
          other.registrationDate == this.registrationDate &&
          other.totalValue == this.totalValue &&
          other.type == this.type);
}

class InvoicesRecordsCompanion extends UpdateCompanion<InvoicesRecord> {
  final Value<String?> companyCnpj;
  final Value<int?> companyId;
  final Value<String?> companyName;
  final Value<String?> customerCpf;
  final Value<int?> customerId;
  final Value<String?> customerName;
  final Value<int> id;
  final Value<String> invoiceNumber;
  final Value<DateTime> issueDate;
  final Value<DateTime?> lastUpdatedDate;
  final Value<String> paymentMethod;
  final Value<DateTime> registrationDate;
  final Value<double> totalValue;
  final Value<InvoiceType> type;
  const InvoicesRecordsCompanion({
    this.companyCnpj = const Value.absent(),
    this.companyId = const Value.absent(),
    this.companyName = const Value.absent(),
    this.customerCpf = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.id = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.issueDate = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.registrationDate = const Value.absent(),
    this.totalValue = const Value.absent(),
    this.type = const Value.absent(),
  });
  InvoicesRecordsCompanion.insert({
    this.companyCnpj = const Value.absent(),
    this.companyId = const Value.absent(),
    this.companyName = const Value.absent(),
    this.customerCpf = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.id = const Value.absent(),
    required String invoiceNumber,
    required DateTime issueDate,
    this.lastUpdatedDate = const Value.absent(),
    required String paymentMethod,
    this.registrationDate = const Value.absent(),
    required double totalValue,
    this.type = const Value.absent(),
  }) : invoiceNumber = Value(invoiceNumber),
       issueDate = Value(issueDate),
       paymentMethod = Value(paymentMethod),
       totalValue = Value(totalValue);
  static Insertable<InvoicesRecord> custom({
    Expression<String>? companyCnpj,
    Expression<int>? companyId,
    Expression<String>? companyName,
    Expression<String>? customerCpf,
    Expression<int>? customerId,
    Expression<String>? customerName,
    Expression<int>? id,
    Expression<String>? invoiceNumber,
    Expression<DateTime>? issueDate,
    Expression<DateTime>? lastUpdatedDate,
    Expression<String>? paymentMethod,
    Expression<DateTime>? registrationDate,
    Expression<double>? totalValue,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (companyCnpj != null) 'company_cnpj': companyCnpj,
      if (companyId != null) 'company_id': companyId,
      if (companyName != null) 'company_name': companyName,
      if (customerCpf != null) 'customer_cpf': customerCpf,
      if (customerId != null) 'customer_id': customerId,
      if (customerName != null) 'customer_name': customerName,
      if (id != null) 'id': id,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (issueDate != null) 'issue_date': issueDate,
      if (lastUpdatedDate != null) 'last_updated_date': lastUpdatedDate,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (registrationDate != null) 'registration_date': registrationDate,
      if (totalValue != null) 'total_value': totalValue,
      if (type != null) 'type': type,
    });
  }

  InvoicesRecordsCompanion copyWith({
    Value<String?>? companyCnpj,
    Value<int?>? companyId,
    Value<String?>? companyName,
    Value<String?>? customerCpf,
    Value<int?>? customerId,
    Value<String?>? customerName,
    Value<int>? id,
    Value<String>? invoiceNumber,
    Value<DateTime>? issueDate,
    Value<DateTime?>? lastUpdatedDate,
    Value<String>? paymentMethod,
    Value<DateTime>? registrationDate,
    Value<double>? totalValue,
    Value<InvoiceType>? type,
  }) {
    return InvoicesRecordsCompanion(
      companyCnpj: companyCnpj ?? this.companyCnpj,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      customerCpf: customerCpf ?? this.customerCpf,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      issueDate: issueDate ?? this.issueDate,
      lastUpdatedDate: lastUpdatedDate ?? this.lastUpdatedDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      registrationDate: registrationDate ?? this.registrationDate,
      totalValue: totalValue ?? this.totalValue,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (companyCnpj.present) {
      map['company_cnpj'] = Variable<String>(companyCnpj.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<int>(companyId.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (customerCpf.present) {
      map['customer_cpf'] = Variable<String>(customerCpf.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (issueDate.present) {
      map['issue_date'] = Variable<DateTime>(issueDate.value);
    }
    if (lastUpdatedDate.present) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (registrationDate.present) {
      map['registration_date'] = Variable<DateTime>(registrationDate.value);
    }
    if (totalValue.present) {
      map['total_value'] = Variable<double>(totalValue.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $InvoicesRecordsTable.$convertertype.toSql(type.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesRecordsCompanion(')
          ..write('companyCnpj: $companyCnpj, ')
          ..write('companyId: $companyId, ')
          ..write('companyName: $companyName, ')
          ..write('customerCpf: $customerCpf, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('issueDate: $issueDate, ')
          ..write('lastUpdatedDate: $lastUpdatedDate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('registrationDate: $registrationDate, ')
          ..write('totalValue: $totalValue, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $InvoiceItemsRecordsTable extends InvoiceItemsRecords
    with TableInfo<$InvoiceItemsRecordsTable, InvoiceItemsRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceItemsRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productCodeMeta = const VerificationMeta(
    'productCode',
  );
  @override
  late final GeneratedColumn<String> productCode = GeneratedColumn<String>(
    'product_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalValueMeta = const VerificationMeta(
    'totalValue',
  );
  @override
  late final GeneratedColumn<double> totalValue = GeneratedColumn<double>(
    'total_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    productCode,
    productId,
    productName,
    quantity,
    totalValue,
    unitPrice,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_items_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceItemsRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('product_code')) {
      context.handle(
        _productCodeMeta,
        productCode.isAcceptableOrUnknown(
          data['product_code']!,
          _productCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productCodeMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('total_value')) {
      context.handle(
        _totalValueMeta,
        totalValue.isAcceptableOrUnknown(data['total_value']!, _totalValueMeta),
      );
    } else if (isInserting) {
      context.missing(_totalValueMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceItemsRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceItemsRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      productCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_code'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      totalValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_value'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
    );
  }

  @override
  $InvoiceItemsRecordsTable createAlias(String alias) {
    return $InvoiceItemsRecordsTable(attachedDatabase, alias);
  }
}

class InvoiceItemsRecord extends DataClass
    implements Insertable<InvoiceItemsRecord> {
  final int id;

  /// ID da nota fiscal (relacionamento)
  final int invoiceId;

  /// Código do produto (desnormalizado para facilitar consultas)
  final String productCode;

  /// ID do produto
  final int productId;

  /// Nome do produto (desnormalizado para facilitar consultas)
  final String productName;

  /// Quantidade do produto
  final int quantity;

  /// Valor total (quantidade * preço unitário)
  final double totalValue;

  /// Preço unitário
  final double unitPrice;
  const InvoiceItemsRecord({
    required this.id,
    required this.invoiceId,
    required this.productCode,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.totalValue,
    required this.unitPrice,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['product_code'] = Variable<String>(productCode);
    map['product_id'] = Variable<int>(productId);
    map['product_name'] = Variable<String>(productName);
    map['quantity'] = Variable<int>(quantity);
    map['total_value'] = Variable<double>(totalValue);
    map['unit_price'] = Variable<double>(unitPrice);
    return map;
  }

  InvoiceItemsRecordsCompanion toCompanion(bool nullToAbsent) {
    return InvoiceItemsRecordsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      productCode: Value(productCode),
      productId: Value(productId),
      productName: Value(productName),
      quantity: Value(quantity),
      totalValue: Value(totalValue),
      unitPrice: Value(unitPrice),
    );
  }

  factory InvoiceItemsRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceItemsRecord(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      productCode: serializer.fromJson<String>(json['productCode']),
      productId: serializer.fromJson<int>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      quantity: serializer.fromJson<int>(json['quantity']),
      totalValue: serializer.fromJson<double>(json['totalValue']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'productCode': serializer.toJson<String>(productCode),
      'productId': serializer.toJson<int>(productId),
      'productName': serializer.toJson<String>(productName),
      'quantity': serializer.toJson<int>(quantity),
      'totalValue': serializer.toJson<double>(totalValue),
      'unitPrice': serializer.toJson<double>(unitPrice),
    };
  }

  InvoiceItemsRecord copyWith({
    int? id,
    int? invoiceId,
    String? productCode,
    int? productId,
    String? productName,
    int? quantity,
    double? totalValue,
    double? unitPrice,
  }) => InvoiceItemsRecord(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    productCode: productCode ?? this.productCode,
    productId: productId ?? this.productId,
    productName: productName ?? this.productName,
    quantity: quantity ?? this.quantity,
    totalValue: totalValue ?? this.totalValue,
    unitPrice: unitPrice ?? this.unitPrice,
  );
  InvoiceItemsRecord copyWithCompanion(InvoiceItemsRecordsCompanion data) {
    return InvoiceItemsRecord(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      productCode: data.productCode.present
          ? data.productCode.value
          : this.productCode,
      productId: data.productId.present ? data.productId.value : this.productId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      totalValue: data.totalValue.present
          ? data.totalValue.value
          : this.totalValue,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemsRecord(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productCode: $productCode, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('totalValue: $totalValue, ')
          ..write('unitPrice: $unitPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    productCode,
    productId,
    productName,
    quantity,
    totalValue,
    unitPrice,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceItemsRecord &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.productCode == this.productCode &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.quantity == this.quantity &&
          other.totalValue == this.totalValue &&
          other.unitPrice == this.unitPrice);
}

class InvoiceItemsRecordsCompanion extends UpdateCompanion<InvoiceItemsRecord> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<String> productCode;
  final Value<int> productId;
  final Value<String> productName;
  final Value<int> quantity;
  final Value<double> totalValue;
  final Value<double> unitPrice;
  const InvoiceItemsRecordsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.productCode = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.totalValue = const Value.absent(),
    this.unitPrice = const Value.absent(),
  });
  InvoiceItemsRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required String productCode,
    required int productId,
    required String productName,
    required int quantity,
    required double totalValue,
    required double unitPrice,
  }) : invoiceId = Value(invoiceId),
       productCode = Value(productCode),
       productId = Value(productId),
       productName = Value(productName),
       quantity = Value(quantity),
       totalValue = Value(totalValue),
       unitPrice = Value(unitPrice);
  static Insertable<InvoiceItemsRecord> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<String>? productCode,
    Expression<int>? productId,
    Expression<String>? productName,
    Expression<int>? quantity,
    Expression<double>? totalValue,
    Expression<double>? unitPrice,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (productCode != null) 'product_code': productCode,
      if (productId != null) 'product_id': productId,
      if (productName != null) 'product_name': productName,
      if (quantity != null) 'quantity': quantity,
      if (totalValue != null) 'total_value': totalValue,
      if (unitPrice != null) 'unit_price': unitPrice,
    });
  }

  InvoiceItemsRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceId,
    Value<String>? productCode,
    Value<int>? productId,
    Value<String>? productName,
    Value<int>? quantity,
    Value<double>? totalValue,
    Value<double>? unitPrice,
  }) {
    return InvoiceItemsRecordsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      productCode: productCode ?? this.productCode,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      totalValue: totalValue ?? this.totalValue,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (productCode.present) {
      map['product_code'] = Variable<String>(productCode.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (totalValue.present) {
      map['total_value'] = Variable<double>(totalValue.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemsRecordsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productCode: $productCode, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('quantity: $quantity, ')
          ..write('totalValue: $totalValue, ')
          ..write('unitPrice: $unitPrice')
          ..write(')'))
        .toString();
  }
}

class $AddressRecordsTable extends AddressRecords
    with TableInfo<$AddressRecordsTable, AddressRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AddressRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _neighborhoodMeta = const VerificationMeta(
    'neighborhood',
  );
  @override
  late final GeneratedColumn<String> neighborhood = GeneratedColumn<String>(
    'neighborhood',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _streetMeta = const VerificationMeta('street');
  @override
  late final GeneratedColumn<String> street = GeneratedColumn<String>(
    'street',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _zipCodeMeta = const VerificationMeta(
    'zipCode',
  );
  @override
  late final GeneratedColumn<String> zipCode = GeneratedColumn<String>(
    'zip_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    city,
    lastUpdatedDate,
    neighborhood,
    state,
    street,
    zipCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'address_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<AddressRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
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
    if (data.containsKey('neighborhood')) {
      context.handle(
        _neighborhoodMeta,
        neighborhood.isAcceptableOrUnknown(
          data['neighborhood']!,
          _neighborhoodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_neighborhoodMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('street')) {
      context.handle(
        _streetMeta,
        street.isAcceptableOrUnknown(data['street']!, _streetMeta),
      );
    } else if (isInserting) {
      context.missing(_streetMeta);
    }
    if (data.containsKey('zip_code')) {
      context.handle(
        _zipCodeMeta,
        zipCode.isAcceptableOrUnknown(data['zip_code']!, _zipCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_zipCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  AddressRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AddressRecord(
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      lastUpdatedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_date'],
      ),
      neighborhood: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}neighborhood'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      street: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}street'],
      )!,
      zipCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}zip_code'],
      )!,
    );
  }

  @override
  $AddressRecordsTable createAlias(String alias) {
    return $AddressRecordsTable(attachedDatabase, alias);
  }
}

class AddressRecord extends DataClass implements Insertable<AddressRecord> {
  final String city;
  final DateTime? lastUpdatedDate;
  final String neighborhood;
  final String state;
  final String street;
  final String zipCode;
  const AddressRecord({
    required this.city,
    this.lastUpdatedDate,
    required this.neighborhood,
    required this.state,
    required this.street,
    required this.zipCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['city'] = Variable<String>(city);
    if (!nullToAbsent || lastUpdatedDate != null) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate);
    }
    map['neighborhood'] = Variable<String>(neighborhood);
    map['state'] = Variable<String>(state);
    map['street'] = Variable<String>(street);
    map['zip_code'] = Variable<String>(zipCode);
    return map;
  }

  AddressRecordsCompanion toCompanion(bool nullToAbsent) {
    return AddressRecordsCompanion(
      city: Value(city),
      lastUpdatedDate: lastUpdatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedDate),
      neighborhood: Value(neighborhood),
      state: Value(state),
      street: Value(street),
      zipCode: Value(zipCode),
    );
  }

  factory AddressRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AddressRecord(
      city: serializer.fromJson<String>(json['city']),
      lastUpdatedDate: serializer.fromJson<DateTime?>(json['lastUpdatedDate']),
      neighborhood: serializer.fromJson<String>(json['neighborhood']),
      state: serializer.fromJson<String>(json['state']),
      street: serializer.fromJson<String>(json['street']),
      zipCode: serializer.fromJson<String>(json['zipCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'city': serializer.toJson<String>(city),
      'lastUpdatedDate': serializer.toJson<DateTime?>(lastUpdatedDate),
      'neighborhood': serializer.toJson<String>(neighborhood),
      'state': serializer.toJson<String>(state),
      'street': serializer.toJson<String>(street),
      'zipCode': serializer.toJson<String>(zipCode),
    };
  }

  AddressRecord copyWith({
    String? city,
    Value<DateTime?> lastUpdatedDate = const Value.absent(),
    String? neighborhood,
    String? state,
    String? street,
    String? zipCode,
  }) => AddressRecord(
    city: city ?? this.city,
    lastUpdatedDate: lastUpdatedDate.present
        ? lastUpdatedDate.value
        : this.lastUpdatedDate,
    neighborhood: neighborhood ?? this.neighborhood,
    state: state ?? this.state,
    street: street ?? this.street,
    zipCode: zipCode ?? this.zipCode,
  );
  AddressRecord copyWithCompanion(AddressRecordsCompanion data) {
    return AddressRecord(
      city: data.city.present ? data.city.value : this.city,
      lastUpdatedDate: data.lastUpdatedDate.present
          ? data.lastUpdatedDate.value
          : this.lastUpdatedDate,
      neighborhood: data.neighborhood.present
          ? data.neighborhood.value
          : this.neighborhood,
      state: data.state.present ? data.state.value : this.state,
      street: data.street.present ? data.street.value : this.street,
      zipCode: data.zipCode.present ? data.zipCode.value : this.zipCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AddressRecord(')
          ..write('city: $city, ')
          ..write('lastUpdatedDate: $lastUpdatedDate, ')
          ..write('neighborhood: $neighborhood, ')
          ..write('state: $state, ')
          ..write('street: $street, ')
          ..write('zipCode: $zipCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(city, lastUpdatedDate, neighborhood, state, street, zipCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AddressRecord &&
          other.city == this.city &&
          other.lastUpdatedDate == this.lastUpdatedDate &&
          other.neighborhood == this.neighborhood &&
          other.state == this.state &&
          other.street == this.street &&
          other.zipCode == this.zipCode);
}

class AddressRecordsCompanion extends UpdateCompanion<AddressRecord> {
  final Value<String> city;
  final Value<DateTime?> lastUpdatedDate;
  final Value<String> neighborhood;
  final Value<String> state;
  final Value<String> street;
  final Value<String> zipCode;
  final Value<int> rowid;
  const AddressRecordsCompanion({
    this.city = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    this.neighborhood = const Value.absent(),
    this.state = const Value.absent(),
    this.street = const Value.absent(),
    this.zipCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AddressRecordsCompanion.insert({
    required String city,
    this.lastUpdatedDate = const Value.absent(),
    required String neighborhood,
    required String state,
    required String street,
    required String zipCode,
    this.rowid = const Value.absent(),
  }) : city = Value(city),
       neighborhood = Value(neighborhood),
       state = Value(state),
       street = Value(street),
       zipCode = Value(zipCode);
  static Insertable<AddressRecord> custom({
    Expression<String>? city,
    Expression<DateTime>? lastUpdatedDate,
    Expression<String>? neighborhood,
    Expression<String>? state,
    Expression<String>? street,
    Expression<String>? zipCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (city != null) 'city': city,
      if (lastUpdatedDate != null) 'last_updated_date': lastUpdatedDate,
      if (neighborhood != null) 'neighborhood': neighborhood,
      if (state != null) 'state': state,
      if (street != null) 'street': street,
      if (zipCode != null) 'zip_code': zipCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AddressRecordsCompanion copyWith({
    Value<String>? city,
    Value<DateTime?>? lastUpdatedDate,
    Value<String>? neighborhood,
    Value<String>? state,
    Value<String>? street,
    Value<String>? zipCode,
    Value<int>? rowid,
  }) {
    return AddressRecordsCompanion(
      city: city ?? this.city,
      lastUpdatedDate: lastUpdatedDate ?? this.lastUpdatedDate,
      neighborhood: neighborhood ?? this.neighborhood,
      state: state ?? this.state,
      street: street ?? this.street,
      zipCode: zipCode ?? this.zipCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (lastUpdatedDate.present) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate.value);
    }
    if (neighborhood.present) {
      map['neighborhood'] = Variable<String>(neighborhood.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (street.present) {
      map['street'] = Variable<String>(street.value);
    }
    if (zipCode.present) {
      map['zip_code'] = Variable<String>(zipCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AddressRecordsCompanion(')
          ..write('city: $city, ')
          ..write('lastUpdatedDate: $lastUpdatedDate, ')
          ..write('neighborhood: $neighborhood, ')
          ..write('state: $state, ')
          ..write('street: $street, ')
          ..write('zipCode: $zipCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesRecordsTable categoriesRecords =
      $CategoriesRecordsTable(this);
  late final $CompanyRecordsTable companyRecords = $CompanyRecordsTable(this);
  late final $CustomerRecordsTable customerRecords = $CustomerRecordsTable(
    this,
  );
  late final $ProductsRecordsTable productsRecords = $ProductsRecordsTable(
    this,
  );
  late final $InvoicesRecordsTable invoicesRecords = $InvoicesRecordsTable(
    this,
  );
  late final $InvoiceItemsRecordsTable invoiceItemsRecords =
      $InvoiceItemsRecordsTable(this);
  late final $AddressRecordsTable addressRecords = $AddressRecordsTable(this);
  late final CategoryDao categoryDao = CategoryDao(this as AppDatabase);
  late final CompanyDao companyDao = CompanyDao(this as AppDatabase);
  late final CustomerDao customerDao = CustomerDao(this as AppDatabase);
  late final ProductDao productDao = ProductDao(this as AppDatabase);
  late final InvoiceDao invoiceDao = InvoiceDao(this as AppDatabase);
  late final InvoiceItemDao invoiceItemDao = InvoiceItemDao(
    this as AppDatabase,
  );
  late final AddressDao addressDao = AddressDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categoriesRecords,
    companyRecords,
    customerRecords,
    productsRecords,
    invoicesRecords,
    invoiceItemsRecords,
    addressRecords,
  ];
}

typedef $$CategoriesRecordsTableCreateCompanionBuilder =
    CategoriesRecordsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<DateTime> registrationDate,
      Value<DateTime?> lastUpdatedDate,
    });
typedef $$CategoriesRecordsTableUpdateCompanionBuilder =
    CategoriesRecordsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<DateTime> registrationDate,
      Value<DateTime?> lastUpdatedDate,
    });

final class $$CategoriesRecordsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CategoriesRecordsTable,
          CategoriesRecord
        > {
  $$CategoriesRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ProductsRecordsTable, List<ProductsRecord>>
  _productsRecordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.productsRecords,
    aliasName: $_aliasNameGenerator(
      db.categoriesRecords.id,
      db.productsRecords.categoryId,
    ),
  );

  $$ProductsRecordsTableProcessedTableManager get productsRecordsRefs {
    final manager = $$ProductsRecordsTableTableManager(
      $_db,
      $_db.productsRecords,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _productsRecordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesRecordsTable> {
  $$CategoriesRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productsRecordsRefs(
    Expression<bool> Function($$ProductsRecordsTableFilterComposer f) f,
  ) {
    final $$ProductsRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productsRecords,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsRecordsTableFilterComposer(
            $db: $db,
            $table: $db.productsRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesRecordsTable> {
  $$CategoriesRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesRecordsTable> {
  $$CategoriesRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => column,
  );

  Expression<T> productsRecordsRefs<T extends Object>(
    Expression<T> Function($$ProductsRecordsTableAnnotationComposer a) f,
  ) {
    final $$ProductsRecordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productsRecords,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsRecordsTableAnnotationComposer(
            $db: $db,
            $table: $db.productsRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesRecordsTable,
          CategoriesRecord,
          $$CategoriesRecordsTableFilterComposer,
          $$CategoriesRecordsTableOrderingComposer,
          $$CategoriesRecordsTableAnnotationComposer,
          $$CategoriesRecordsTableCreateCompanionBuilder,
          $$CategoriesRecordsTableUpdateCompanionBuilder,
          (CategoriesRecord, $$CategoriesRecordsTableReferences),
          CategoriesRecord,
          PrefetchHooks Function({bool productsRecordsRefs})
        > {
  $$CategoriesRecordsTableTableManager(
    _$AppDatabase db,
    $CategoriesRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
              }) => CategoriesRecordsCompanion(
                id: id,
                name: name,
                description: description,
                registrationDate: registrationDate,
                lastUpdatedDate: lastUpdatedDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
              }) => CategoriesRecordsCompanion.insert(
                id: id,
                name: name,
                description: description,
                registrationDate: registrationDate,
                lastUpdatedDate: lastUpdatedDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productsRecordsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (productsRecordsRefs) db.productsRecords,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productsRecordsRefs)
                    await $_getPrefetchedData<
                      CategoriesRecord,
                      $CategoriesRecordsTable,
                      ProductsRecord
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesRecordsTableReferences
                          ._productsRecordsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesRecordsTableReferences(
                            db,
                            table,
                            p0,
                          ).productsRecordsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesRecordsTable,
      CategoriesRecord,
      $$CategoriesRecordsTableFilterComposer,
      $$CategoriesRecordsTableOrderingComposer,
      $$CategoriesRecordsTableAnnotationComposer,
      $$CategoriesRecordsTableCreateCompanionBuilder,
      $$CategoriesRecordsTableUpdateCompanionBuilder,
      (CategoriesRecord, $$CategoriesRecordsTableReferences),
      CategoriesRecord,
      PrefetchHooks Function({bool productsRecordsRefs})
    >;
typedef $$CompanyRecordsTableCreateCompanionBuilder =
    CompanyRecordsCompanion Function({
      Value<Address?> address,
      required String cnpj,
      required String name,
      Value<String?> email,
      Value<int> id,
      Value<DateTime?> lastUpdatedDate,
      Value<DateTime> registrationDate,
    });
typedef $$CompanyRecordsTableUpdateCompanionBuilder =
    CompanyRecordsCompanion Function({
      Value<Address?> address,
      Value<String> cnpj,
      Value<String> name,
      Value<String?> email,
      Value<int> id,
      Value<DateTime?> lastUpdatedDate,
      Value<DateTime> registrationDate,
    });

class $$CompanyRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $CompanyRecordsTable> {
  $$CompanyRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<Address?, Address, String> get address =>
      $composableBuilder(
        column: $table.address,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get cnpj => $composableBuilder(
    column: $table.cnpj,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

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

  ColumnFilters<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CompanyRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $CompanyRecordsTable> {
  $$CompanyRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cnpj => $composableBuilder(
    column: $table.cnpj,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

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

  ColumnOrderings<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompanyRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompanyRecordsTable> {
  $$CompanyRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<Address?, String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get cnpj =>
      $composableBuilder(column: $table.cnpj, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

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
}

class $$CompanyRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompanyRecordsTable,
          CompanyRecord,
          $$CompanyRecordsTableFilterComposer,
          $$CompanyRecordsTableOrderingComposer,
          $$CompanyRecordsTableAnnotationComposer,
          $$CompanyRecordsTableCreateCompanionBuilder,
          $$CompanyRecordsTableUpdateCompanionBuilder,
          (
            CompanyRecord,
            BaseReferences<_$AppDatabase, $CompanyRecordsTable, CompanyRecord>,
          ),
          CompanyRecord,
          PrefetchHooks Function()
        > {
  $$CompanyRecordsTableTableManager(
    _$AppDatabase db,
    $CompanyRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompanyRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompanyRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompanyRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<Address?> address = const Value.absent(),
                Value<String> cnpj = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
              }) => CompanyRecordsCompanion(
                address: address,
                cnpj: cnpj,
                name: name,
                email: email,
                id: id,
                lastUpdatedDate: lastUpdatedDate,
                registrationDate: registrationDate,
              ),
          createCompanionCallback:
              ({
                Value<Address?> address = const Value.absent(),
                required String cnpj,
                required String name,
                Value<String?> email = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
              }) => CompanyRecordsCompanion.insert(
                address: address,
                cnpj: cnpj,
                name: name,
                email: email,
                id: id,
                lastUpdatedDate: lastUpdatedDate,
                registrationDate: registrationDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CompanyRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompanyRecordsTable,
      CompanyRecord,
      $$CompanyRecordsTableFilterComposer,
      $$CompanyRecordsTableOrderingComposer,
      $$CompanyRecordsTableAnnotationComposer,
      $$CompanyRecordsTableCreateCompanionBuilder,
      $$CompanyRecordsTableUpdateCompanionBuilder,
      (
        CompanyRecord,
        BaseReferences<_$AppDatabase, $CompanyRecordsTable, CompanyRecord>,
      ),
      CompanyRecord,
      PrefetchHooks Function()
    >;
typedef $$CustomerRecordsTableCreateCompanionBuilder =
    CustomerRecordsCompanion Function({
      Value<Address?> address,
      required String cpf,
      Value<String?> email,
      Value<int> id,
      Value<DateTime> lastUpdatedDate,
      required String name,
      Value<String?> phone,
      Value<DateTime> registrationDate,
    });
typedef $$CustomerRecordsTableUpdateCompanionBuilder =
    CustomerRecordsCompanion Function({
      Value<Address?> address,
      Value<String> cpf,
      Value<String?> email,
      Value<int> id,
      Value<DateTime> lastUpdatedDate,
      Value<String> name,
      Value<String?> phone,
      Value<DateTime> registrationDate,
    });

class $$CustomerRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $CustomerRecordsTable> {
  $$CustomerRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<Address?, Address, String> get address =>
      $composableBuilder(
        column: $table.address,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get cpf => $composableBuilder(
    column: $table.cpf,
    builder: (column) => ColumnFilters(column),
  );

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

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomerRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomerRecordsTable> {
  $$CustomerRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cpf => $composableBuilder(
    column: $table.cpf,
    builder: (column) => ColumnOrderings(column),
  );

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

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomerRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomerRecordsTable> {
  $$CustomerRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<Address?, String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get cpf =>
      $composableBuilder(column: $table.cpf, builder: (column) => column);

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

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => column,
  );
}

class $$CustomerRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomerRecordsTable,
          CustomerRecord,
          $$CustomerRecordsTableFilterComposer,
          $$CustomerRecordsTableOrderingComposer,
          $$CustomerRecordsTableAnnotationComposer,
          $$CustomerRecordsTableCreateCompanionBuilder,
          $$CustomerRecordsTableUpdateCompanionBuilder,
          (
            CustomerRecord,
            BaseReferences<
              _$AppDatabase,
              $CustomerRecordsTable,
              CustomerRecord
            >,
          ),
          CustomerRecord,
          PrefetchHooks Function()
        > {
  $$CustomerRecordsTableTableManager(
    _$AppDatabase db,
    $CustomerRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomerRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomerRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomerRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<Address?> address = const Value.absent(),
                Value<String> cpf = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<DateTime> lastUpdatedDate = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
              }) => CustomerRecordsCompanion(
                address: address,
                cpf: cpf,
                email: email,
                id: id,
                lastUpdatedDate: lastUpdatedDate,
                name: name,
                phone: phone,
                registrationDate: registrationDate,
              ),
          createCompanionCallback:
              ({
                Value<Address?> address = const Value.absent(),
                required String cpf,
                Value<String?> email = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<DateTime> lastUpdatedDate = const Value.absent(),
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
              }) => CustomerRecordsCompanion.insert(
                address: address,
                cpf: cpf,
                email: email,
                id: id,
                lastUpdatedDate: lastUpdatedDate,
                name: name,
                phone: phone,
                registrationDate: registrationDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomerRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomerRecordsTable,
      CustomerRecord,
      $$CustomerRecordsTableFilterComposer,
      $$CustomerRecordsTableOrderingComposer,
      $$CustomerRecordsTableAnnotationComposer,
      $$CustomerRecordsTableCreateCompanionBuilder,
      $$CustomerRecordsTableUpdateCompanionBuilder,
      (
        CustomerRecord,
        BaseReferences<_$AppDatabase, $CustomerRecordsTable, CustomerRecord>,
      ),
      CustomerRecord,
      PrefetchHooks Function()
    >;
typedef $$ProductsRecordsTableCreateCompanionBuilder =
    ProductsRecordsCompanion Function({
      required String code,
      Value<int> id,
      Value<int?> categoryId,
      required String description,
      Value<DateTime?> lastUpdatedDate,
      required String name,
      required double price,
      Value<DateTime> registrationDate,
      required int stockQuantity,
    });
typedef $$ProductsRecordsTableUpdateCompanionBuilder =
    ProductsRecordsCompanion Function({
      Value<String> code,
      Value<int> id,
      Value<int?> categoryId,
      Value<String> description,
      Value<DateTime?> lastUpdatedDate,
      Value<String> name,
      Value<double> price,
      Value<DateTime> registrationDate,
      Value<int> stockQuantity,
    });

final class $$ProductsRecordsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ProductsRecordsTable, ProductsRecord> {
  $$ProductsRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoriesRecordsTable _categoryIdTable(_$AppDatabase db) =>
      db.categoriesRecords.createAlias(
        $_aliasNameGenerator(
          db.productsRecords.categoryId,
          db.categoriesRecords.id,
        ),
      );

  $$CategoriesRecordsTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$CategoriesRecordsTableTableManager(
      $_db,
      $_db.categoriesRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProductsRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsRecordsTable> {
  $$ProductsRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
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

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriesRecordsTableFilterComposer get categoryId {
    final $$CategoriesRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesRecordsTableFilterComposer(
            $db: $db,
            $table: $db.categoriesRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductsRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsRecordsTable> {
  $$ProductsRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
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

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriesRecordsTableOrderingComposer get categoryId {
    final $$CategoriesRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoriesRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.categoriesRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductsRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsRecordsTable> {
  $$ProductsRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stockQuantity => $composableBuilder(
    column: $table.stockQuantity,
    builder: (column) => column,
  );

  $$CategoriesRecordsTableAnnotationComposer get categoryId {
    final $$CategoriesRecordsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.categoriesRecords,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CategoriesRecordsTableAnnotationComposer(
                $db: $db,
                $table: $db.categoriesRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ProductsRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsRecordsTable,
          ProductsRecord,
          $$ProductsRecordsTableFilterComposer,
          $$ProductsRecordsTableOrderingComposer,
          $$ProductsRecordsTableAnnotationComposer,
          $$ProductsRecordsTableCreateCompanionBuilder,
          $$ProductsRecordsTableUpdateCompanionBuilder,
          (ProductsRecord, $$ProductsRecordsTableReferences),
          ProductsRecord,
          PrefetchHooks Function({bool categoryId})
        > {
  $$ProductsRecordsTableTableManager(
    _$AppDatabase db,
    $ProductsRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
                Value<int> stockQuantity = const Value.absent(),
              }) => ProductsRecordsCompanion(
                code: code,
                id: id,
                categoryId: categoryId,
                description: description,
                lastUpdatedDate: lastUpdatedDate,
                name: name,
                price: price,
                registrationDate: registrationDate,
                stockQuantity: stockQuantity,
              ),
          createCompanionCallback:
              ({
                required String code,
                Value<int> id = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                required String description,
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                required String name,
                required double price,
                Value<DateTime> registrationDate = const Value.absent(),
                required int stockQuantity,
              }) => ProductsRecordsCompanion.insert(
                code: code,
                id: id,
                categoryId: categoryId,
                description: description,
                lastUpdatedDate: lastUpdatedDate,
                name: name,
                price: price,
                registrationDate: registrationDate,
                stockQuantity: stockQuantity,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable:
                                    $$ProductsRecordsTableReferences
                                        ._categoryIdTable(db),
                                referencedColumn:
                                    $$ProductsRecordsTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProductsRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsRecordsTable,
      ProductsRecord,
      $$ProductsRecordsTableFilterComposer,
      $$ProductsRecordsTableOrderingComposer,
      $$ProductsRecordsTableAnnotationComposer,
      $$ProductsRecordsTableCreateCompanionBuilder,
      $$ProductsRecordsTableUpdateCompanionBuilder,
      (ProductsRecord, $$ProductsRecordsTableReferences),
      ProductsRecord,
      PrefetchHooks Function({bool categoryId})
    >;
typedef $$InvoicesRecordsTableCreateCompanionBuilder =
    InvoicesRecordsCompanion Function({
      Value<String?> companyCnpj,
      Value<int?> companyId,
      Value<String?> companyName,
      Value<String?> customerCpf,
      Value<int?> customerId,
      Value<String?> customerName,
      Value<int> id,
      required String invoiceNumber,
      required DateTime issueDate,
      Value<DateTime?> lastUpdatedDate,
      required String paymentMethod,
      Value<DateTime> registrationDate,
      required double totalValue,
      Value<InvoiceType> type,
    });
typedef $$InvoicesRecordsTableUpdateCompanionBuilder =
    InvoicesRecordsCompanion Function({
      Value<String?> companyCnpj,
      Value<int?> companyId,
      Value<String?> companyName,
      Value<String?> customerCpf,
      Value<int?> customerId,
      Value<String?> customerName,
      Value<int> id,
      Value<String> invoiceNumber,
      Value<DateTime> issueDate,
      Value<DateTime?> lastUpdatedDate,
      Value<String> paymentMethod,
      Value<DateTime> registrationDate,
      Value<double> totalValue,
      Value<InvoiceType> type,
    });

class $$InvoicesRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesRecordsTable> {
  $$InvoicesRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get companyCnpj => $composableBuilder(
    column: $table.companyCnpj,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerCpf => $composableBuilder(
    column: $table.customerCpf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<InvoiceType, InvoiceType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$InvoicesRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesRecordsTable> {
  $$InvoicesRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get companyCnpj => $composableBuilder(
    column: $table.companyCnpj,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get companyId => $composableBuilder(
    column: $table.companyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerCpf => $composableBuilder(
    column: $table.customerCpf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InvoicesRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesRecordsTable> {
  $$InvoicesRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get companyCnpj => $composableBuilder(
    column: $table.companyCnpj,
    builder: (column) => column,
  );

  GeneratedColumn<int> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

  GeneratedColumn<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerCpf => $composableBuilder(
    column: $table.customerCpf,
    builder: (column) => column,
  );

  GeneratedColumn<int> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get issueDate =>
      $composableBuilder(column: $table.issueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<InvoiceType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);
}

class $$InvoicesRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesRecordsTable,
          InvoicesRecord,
          $$InvoicesRecordsTableFilterComposer,
          $$InvoicesRecordsTableOrderingComposer,
          $$InvoicesRecordsTableAnnotationComposer,
          $$InvoicesRecordsTableCreateCompanionBuilder,
          $$InvoicesRecordsTableUpdateCompanionBuilder,
          (
            InvoicesRecord,
            BaseReferences<
              _$AppDatabase,
              $InvoicesRecordsTable,
              InvoicesRecord
            >,
          ),
          InvoicesRecord,
          PrefetchHooks Function()
        > {
  $$InvoicesRecordsTableTableManager(
    _$AppDatabase db,
    $InvoicesRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String?> companyCnpj = const Value.absent(),
                Value<int?> companyId = const Value.absent(),
                Value<String?> companyName = const Value.absent(),
                Value<String?> customerCpf = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<String> invoiceNumber = const Value.absent(),
                Value<DateTime> issueDate = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
                Value<double> totalValue = const Value.absent(),
                Value<InvoiceType> type = const Value.absent(),
              }) => InvoicesRecordsCompanion(
                companyCnpj: companyCnpj,
                companyId: companyId,
                companyName: companyName,
                customerCpf: customerCpf,
                customerId: customerId,
                customerName: customerName,
                id: id,
                invoiceNumber: invoiceNumber,
                issueDate: issueDate,
                lastUpdatedDate: lastUpdatedDate,
                paymentMethod: paymentMethod,
                registrationDate: registrationDate,
                totalValue: totalValue,
                type: type,
              ),
          createCompanionCallback:
              ({
                Value<String?> companyCnpj = const Value.absent(),
                Value<int?> companyId = const Value.absent(),
                Value<String?> companyName = const Value.absent(),
                Value<String?> customerCpf = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<int> id = const Value.absent(),
                required String invoiceNumber,
                required DateTime issueDate,
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                required String paymentMethod,
                Value<DateTime> registrationDate = const Value.absent(),
                required double totalValue,
                Value<InvoiceType> type = const Value.absent(),
              }) => InvoicesRecordsCompanion.insert(
                companyCnpj: companyCnpj,
                companyId: companyId,
                companyName: companyName,
                customerCpf: customerCpf,
                customerId: customerId,
                customerName: customerName,
                id: id,
                invoiceNumber: invoiceNumber,
                issueDate: issueDate,
                lastUpdatedDate: lastUpdatedDate,
                paymentMethod: paymentMethod,
                registrationDate: registrationDate,
                totalValue: totalValue,
                type: type,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InvoicesRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesRecordsTable,
      InvoicesRecord,
      $$InvoicesRecordsTableFilterComposer,
      $$InvoicesRecordsTableOrderingComposer,
      $$InvoicesRecordsTableAnnotationComposer,
      $$InvoicesRecordsTableCreateCompanionBuilder,
      $$InvoicesRecordsTableUpdateCompanionBuilder,
      (
        InvoicesRecord,
        BaseReferences<_$AppDatabase, $InvoicesRecordsTable, InvoicesRecord>,
      ),
      InvoicesRecord,
      PrefetchHooks Function()
    >;
typedef $$InvoiceItemsRecordsTableCreateCompanionBuilder =
    InvoiceItemsRecordsCompanion Function({
      Value<int> id,
      required int invoiceId,
      required String productCode,
      required int productId,
      required String productName,
      required int quantity,
      required double totalValue,
      required double unitPrice,
    });
typedef $$InvoiceItemsRecordsTableUpdateCompanionBuilder =
    InvoiceItemsRecordsCompanion Function({
      Value<int> id,
      Value<int> invoiceId,
      Value<String> productCode,
      Value<int> productId,
      Value<String> productName,
      Value<int> quantity,
      Value<double> totalValue,
      Value<double> unitPrice,
    });

class $$InvoiceItemsRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceItemsRecordsTable> {
  $$InvoiceItemsRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InvoiceItemsRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceItemsRecordsTable> {
  $$InvoiceItemsRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get invoiceId => $composableBuilder(
    column: $table.invoiceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InvoiceItemsRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceItemsRecordsTable> {
  $$InvoiceItemsRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get invoiceId =>
      $composableBuilder(column: $table.invoiceId, builder: (column) => column);

  GeneratedColumn<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);
}

class $$InvoiceItemsRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoiceItemsRecordsTable,
          InvoiceItemsRecord,
          $$InvoiceItemsRecordsTableFilterComposer,
          $$InvoiceItemsRecordsTableOrderingComposer,
          $$InvoiceItemsRecordsTableAnnotationComposer,
          $$InvoiceItemsRecordsTableCreateCompanionBuilder,
          $$InvoiceItemsRecordsTableUpdateCompanionBuilder,
          (
            InvoiceItemsRecord,
            BaseReferences<
              _$AppDatabase,
              $InvoiceItemsRecordsTable,
              InvoiceItemsRecord
            >,
          ),
          InvoiceItemsRecord,
          PrefetchHooks Function()
        > {
  $$InvoiceItemsRecordsTableTableManager(
    _$AppDatabase db,
    $InvoiceItemsRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceItemsRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceItemsRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InvoiceItemsRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<String> productCode = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> totalValue = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
              }) => InvoiceItemsRecordsCompanion(
                id: id,
                invoiceId: invoiceId,
                productCode: productCode,
                productId: productId,
                productName: productName,
                quantity: quantity,
                totalValue: totalValue,
                unitPrice: unitPrice,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceId,
                required String productCode,
                required int productId,
                required String productName,
                required int quantity,
                required double totalValue,
                required double unitPrice,
              }) => InvoiceItemsRecordsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                productCode: productCode,
                productId: productId,
                productName: productName,
                quantity: quantity,
                totalValue: totalValue,
                unitPrice: unitPrice,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InvoiceItemsRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoiceItemsRecordsTable,
      InvoiceItemsRecord,
      $$InvoiceItemsRecordsTableFilterComposer,
      $$InvoiceItemsRecordsTableOrderingComposer,
      $$InvoiceItemsRecordsTableAnnotationComposer,
      $$InvoiceItemsRecordsTableCreateCompanionBuilder,
      $$InvoiceItemsRecordsTableUpdateCompanionBuilder,
      (
        InvoiceItemsRecord,
        BaseReferences<
          _$AppDatabase,
          $InvoiceItemsRecordsTable,
          InvoiceItemsRecord
        >,
      ),
      InvoiceItemsRecord,
      PrefetchHooks Function()
    >;
typedef $$AddressRecordsTableCreateCompanionBuilder =
    AddressRecordsCompanion Function({
      required String city,
      Value<DateTime?> lastUpdatedDate,
      required String neighborhood,
      required String state,
      required String street,
      required String zipCode,
      Value<int> rowid,
    });
typedef $$AddressRecordsTableUpdateCompanionBuilder =
    AddressRecordsCompanion Function({
      Value<String> city,
      Value<DateTime?> lastUpdatedDate,
      Value<String> neighborhood,
      Value<String> state,
      Value<String> street,
      Value<String> zipCode,
      Value<int> rowid,
    });

class $$AddressRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $AddressRecordsTable> {
  $$AddressRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get neighborhood => $composableBuilder(
    column: $table.neighborhood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get street => $composableBuilder(
    column: $table.street,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get zipCode => $composableBuilder(
    column: $table.zipCode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AddressRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $AddressRecordsTable> {
  $$AddressRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get neighborhood => $composableBuilder(
    column: $table.neighborhood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get street => $composableBuilder(
    column: $table.street,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get zipCode => $composableBuilder(
    column: $table.zipCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AddressRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AddressRecordsTable> {
  $$AddressRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get neighborhood => $composableBuilder(
    column: $table.neighborhood,
    builder: (column) => column,
  );

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get street =>
      $composableBuilder(column: $table.street, builder: (column) => column);

  GeneratedColumn<String> get zipCode =>
      $composableBuilder(column: $table.zipCode, builder: (column) => column);
}

class $$AddressRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AddressRecordsTable,
          AddressRecord,
          $$AddressRecordsTableFilterComposer,
          $$AddressRecordsTableOrderingComposer,
          $$AddressRecordsTableAnnotationComposer,
          $$AddressRecordsTableCreateCompanionBuilder,
          $$AddressRecordsTableUpdateCompanionBuilder,
          (
            AddressRecord,
            BaseReferences<_$AppDatabase, $AddressRecordsTable, AddressRecord>,
          ),
          AddressRecord,
          PrefetchHooks Function()
        > {
  $$AddressRecordsTableTableManager(
    _$AppDatabase db,
    $AddressRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AddressRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AddressRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AddressRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> city = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                Value<String> neighborhood = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String> street = const Value.absent(),
                Value<String> zipCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AddressRecordsCompanion(
                city: city,
                lastUpdatedDate: lastUpdatedDate,
                neighborhood: neighborhood,
                state: state,
                street: street,
                zipCode: zipCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String city,
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                required String neighborhood,
                required String state,
                required String street,
                required String zipCode,
                Value<int> rowid = const Value.absent(),
              }) => AddressRecordsCompanion.insert(
                city: city,
                lastUpdatedDate: lastUpdatedDate,
                neighborhood: neighborhood,
                state: state,
                street: street,
                zipCode: zipCode,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AddressRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AddressRecordsTable,
      AddressRecord,
      $$AddressRecordsTableFilterComposer,
      $$AddressRecordsTableOrderingComposer,
      $$AddressRecordsTableAnnotationComposer,
      $$AddressRecordsTableCreateCompanionBuilder,
      $$AddressRecordsTableUpdateCompanionBuilder,
      (
        AddressRecord,
        BaseReferences<_$AppDatabase, $AddressRecordsTable, AddressRecord>,
      ),
      AddressRecord,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesRecordsTableTableManager get categoriesRecords =>
      $$CategoriesRecordsTableTableManager(_db, _db.categoriesRecords);
  $$CompanyRecordsTableTableManager get companyRecords =>
      $$CompanyRecordsTableTableManager(_db, _db.companyRecords);
  $$CustomerRecordsTableTableManager get customerRecords =>
      $$CustomerRecordsTableTableManager(_db, _db.customerRecords);
  $$ProductsRecordsTableTableManager get productsRecords =>
      $$ProductsRecordsTableTableManager(_db, _db.productsRecords);
  $$InvoicesRecordsTableTableManager get invoicesRecords =>
      $$InvoicesRecordsTableTableManager(_db, _db.invoicesRecords);
  $$InvoiceItemsRecordsTableTableManager get invoiceItemsRecords =>
      $$InvoiceItemsRecordsTableTableManager(_db, _db.invoiceItemsRecords);
  $$AddressRecordsTableTableManager get addressRecords =>
      $$AddressRecordsTableTableManager(_db, _db.addressRecords);
}
