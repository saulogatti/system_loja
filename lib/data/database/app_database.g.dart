// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoriesRecordsTable extends CategoriesRecords
    with TableInfo<$CategoriesRecordsTable, Category> {
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
    Insertable<Category> instance, {
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
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      lastUpdatedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_date'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
    );
  }

  @override
  $CategoriesRecordsTable createAlias(String alias) {
    return $CategoriesRecordsTable(attachedDatabase, alias);
  }
}

class CategoriesRecordsCompanion extends UpdateCompanion<Category> {
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
  static Insertable<Category> custom({
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
    with TableInfo<$CompanyRecordsTable, Company> {
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
    Insertable<Company> instance, {
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
  Company map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Company(
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      cnpj: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cnpj'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      address: $CompanyRecordsTable.$converteraddressn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}address'],
        ),
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
  $CompanyRecordsTable createAlias(String alias) {
    return $CompanyRecordsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Address, String, Object?> $converteraddress =
      Address.converter;
  static JsonTypeConverter2<Address?, String?, Object?> $converteraddressn =
      JsonTypeConverter2.asNullable($converteraddress);
}

class CompanyRecordsCompanion extends UpdateCompanion<Company> {
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
  static Insertable<Company> custom({
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
    with TableInfo<$CustomerRecordsTable, Customer> {
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
    Insertable<Customer> instance, {
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
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      cpf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cpf'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: $CustomerRecordsTable.$converteraddressn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}address'],
        ),
      ),
      registrationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}registration_date'],
      )!,
      lastUpdatedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_date'],
      )!,
    );
  }

  @override
  $CustomerRecordsTable createAlias(String alias) {
    return $CustomerRecordsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Address, String, Object?> $converteraddress =
      Address.converter;
  static JsonTypeConverter2<Address?, String?, Object?> $converteraddressn =
      JsonTypeConverter2.asNullable($converteraddress);
}

class CustomerRecordsCompanion extends UpdateCompanion<Customer> {
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
  static Insertable<Customer> custom({
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
    with TableInfo<$ProductsRecordsTable, Product> {
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
    categoryId,
    description,
    id,
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
    Insertable<Product> instance, {
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
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      stockQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock_quantity'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      lastUpdatedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_date'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
    );
  }

  @override
  $ProductsRecordsTable createAlias(String alias) {
    return $ProductsRecordsTable(attachedDatabase, alias);
  }
}

class ProductsRecordsCompanion extends UpdateCompanion<Product> {
  final Value<String> code;
  final Value<int?> categoryId;
  final Value<String> description;
  final Value<int> id;
  final Value<DateTime?> lastUpdatedDate;
  final Value<String> name;
  final Value<double> price;
  final Value<DateTime> registrationDate;
  final Value<int> stockQuantity;
  const ProductsRecordsCompanion({
    this.code = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.description = const Value.absent(),
    this.id = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.registrationDate = const Value.absent(),
    this.stockQuantity = const Value.absent(),
  });
  ProductsRecordsCompanion.insert({
    required String code,
    this.categoryId = const Value.absent(),
    required String description,
    this.id = const Value.absent(),
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
  static Insertable<Product> custom({
    Expression<String>? code,
    Expression<int>? categoryId,
    Expression<String>? description,
    Expression<int>? id,
    Expression<DateTime>? lastUpdatedDate,
    Expression<String>? name,
    Expression<double>? price,
    Expression<DateTime>? registrationDate,
    Expression<int>? stockQuantity,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (categoryId != null) 'category_id': categoryId,
      if (description != null) 'description': description,
      if (id != null) 'id': id,
      if (lastUpdatedDate != null) 'last_updated_date': lastUpdatedDate,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (registrationDate != null) 'registration_date': registrationDate,
      if (stockQuantity != null) 'stock_quantity': stockQuantity,
    });
  }

  ProductsRecordsCompanion copyWith({
    Value<String>? code,
    Value<int?>? categoryId,
    Value<String>? description,
    Value<int>? id,
    Value<DateTime?>? lastUpdatedDate,
    Value<String>? name,
    Value<double>? price,
    Value<DateTime>? registrationDate,
    Value<int>? stockQuantity,
  }) {
    return ProductsRecordsCompanion(
      code: code ?? this.code,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      id: id ?? this.id,
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
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
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
          ..write('categoryId: $categoryId, ')
          ..write('description: $description, ')
          ..write('id: $id, ')
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
  static const VerificationMeta _customerCpfMeta = const VerificationMeta(
    'customerCpf',
  );
  @override
  late final GeneratedColumn<String> customerCpf = GeneratedColumn<String>(
    'cliente_cpf',
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
    'cliente_id',
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
    'cliente_nome',
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
    'empresa_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
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
    'numero_nota',
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
    'data_emissao',
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
    'forma_pagamento',
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
    'valor_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<InvoiceType, String> type =
      GeneratedColumn<String>(
        'tipo',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('exit'),
      ).withConverter<InvoiceType>($InvoicesRecordsTable.$convertertype);
  @override
  List<GeneratedColumn> get $columns => [
    customerCpf,
    customerId,
    customerName,
    companyId,
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
    if (data.containsKey('cliente_cpf')) {
      context.handle(
        _customerCpfMeta,
        customerCpf.isAcceptableOrUnknown(
          data['cliente_cpf']!,
          _customerCpfMeta,
        ),
      );
    }
    if (data.containsKey('cliente_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['cliente_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('cliente_nome')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['cliente_nome']!,
          _customerNameMeta,
        ),
      );
    }
    if (data.containsKey('empresa_id')) {
      context.handle(
        _companyIdMeta,
        companyId.isAcceptableOrUnknown(data['empresa_id']!, _companyIdMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('numero_nota')) {
      context.handle(
        _invoiceNumberMeta,
        invoiceNumber.isAcceptableOrUnknown(
          data['numero_nota']!,
          _invoiceNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invoiceNumberMeta);
    }
    if (data.containsKey('data_emissao')) {
      context.handle(
        _issueDateMeta,
        issueDate.isAcceptableOrUnknown(data['data_emissao']!, _issueDateMeta),
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
    if (data.containsKey('forma_pagamento')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['forma_pagamento']!,
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
    if (data.containsKey('valor_total')) {
      context.handle(
        _totalValueMeta,
        totalValue.isAcceptableOrUnknown(data['valor_total']!, _totalValueMeta),
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
      customerCpf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cliente_cpf'],
      ),
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cliente_id'],
      ),
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cliente_nome'],
      ),
      companyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}empresa_id'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}numero_nota'],
      )!,
      issueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}data_emissao'],
      )!,
      lastUpdatedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_date'],
      ),
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}forma_pagamento'],
      )!,
      registrationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}registration_date'],
      )!,
      totalValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}valor_total'],
      )!,
      type: $InvoicesRecordsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tipo'],
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
  /// CPF do cliente (desnormalizado; null quando vínculo for empresa).
  final String? customerCpf;

  /// ID do cliente (null quando vínculo for empresa).
  final int? customerId;

  /// Nome do cliente (desnormalizado; null quando vínculo for empresa).
  final String? customerName;

  /// ID da empresa vinculada (null quando vínculo for cliente).
  final int? companyId;
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
    this.customerCpf,
    this.customerId,
    this.customerName,
    this.companyId,
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
    if (!nullToAbsent || customerCpf != null) {
      map['cliente_cpf'] = Variable<String>(customerCpf);
    }
    if (!nullToAbsent || customerId != null) {
      map['cliente_id'] = Variable<int>(customerId);
    }
    if (!nullToAbsent || customerName != null) {
      map['cliente_nome'] = Variable<String>(customerName);
    }
    if (!nullToAbsent || companyId != null) {
      map['empresa_id'] = Variable<int>(companyId);
    }
    map['id'] = Variable<int>(id);
    map['numero_nota'] = Variable<String>(invoiceNumber);
    map['data_emissao'] = Variable<DateTime>(issueDate);
    if (!nullToAbsent || lastUpdatedDate != null) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate);
    }
    map['forma_pagamento'] = Variable<String>(paymentMethod);
    map['registration_date'] = Variable<DateTime>(registrationDate);
    map['valor_total'] = Variable<double>(totalValue);
    {
      map['tipo'] = Variable<String>(
        $InvoicesRecordsTable.$convertertype.toSql(type),
      );
    }
    return map;
  }

  InvoicesRecordsCompanion toCompanion(bool nullToAbsent) {
    return InvoicesRecordsCompanion(
      customerCpf: customerCpf == null && nullToAbsent
          ? const Value.absent()
          : Value(customerCpf),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      companyId: companyId == null && nullToAbsent
          ? const Value.absent()
          : Value(companyId),
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
      customerCpf: serializer.fromJson<String?>(json['customerCpf']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      companyId: serializer.fromJson<int?>(json['companyId']),
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
      'customerCpf': serializer.toJson<String?>(customerCpf),
      'customerId': serializer.toJson<int?>(customerId),
      'customerName': serializer.toJson<String?>(customerName),
      'companyId': serializer.toJson<int?>(companyId),
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
    Value<String?> customerCpf = const Value.absent(),
    Value<int?> customerId = const Value.absent(),
    Value<String?> customerName = const Value.absent(),
    Value<int?> companyId = const Value.absent(),
    int? id,
    String? invoiceNumber,
    DateTime? issueDate,
    Value<DateTime?> lastUpdatedDate = const Value.absent(),
    String? paymentMethod,
    DateTime? registrationDate,
    double? totalValue,
    InvoiceType? type,
  }) => InvoicesRecord(
    customerCpf: customerCpf.present ? customerCpf.value : this.customerCpf,
    customerId: customerId.present ? customerId.value : this.customerId,
    customerName: customerName.present ? customerName.value : this.customerName,
    companyId: companyId.present ? companyId.value : this.companyId,
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
      customerCpf: data.customerCpf.present
          ? data.customerCpf.value
          : this.customerCpf,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
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
          ..write('customerCpf: $customerCpf, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('companyId: $companyId, ')
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
    customerCpf,
    customerId,
    customerName,
    companyId,
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
          other.customerCpf == this.customerCpf &&
          other.customerId == this.customerId &&
          other.customerName == this.customerName &&
          other.companyId == this.companyId &&
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
  final Value<String?> customerCpf;
  final Value<int?> customerId;
  final Value<String?> customerName;
  final Value<int?> companyId;
  final Value<int> id;
  final Value<String> invoiceNumber;
  final Value<DateTime> issueDate;
  final Value<DateTime?> lastUpdatedDate;
  final Value<String> paymentMethod;
  final Value<DateTime> registrationDate;
  final Value<double> totalValue;
  final Value<InvoiceType> type;
  const InvoicesRecordsCompanion({
    this.customerCpf = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.companyId = const Value.absent(),
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
    this.customerCpf = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.companyId = const Value.absent(),
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
    Expression<String>? customerCpf,
    Expression<int>? customerId,
    Expression<String>? customerName,
    Expression<int>? companyId,
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
      if (customerCpf != null) 'cliente_cpf': customerCpf,
      if (customerId != null) 'cliente_id': customerId,
      if (customerName != null) 'cliente_nome': customerName,
      if (companyId != null) 'empresa_id': companyId,
      if (id != null) 'id': id,
      if (invoiceNumber != null) 'numero_nota': invoiceNumber,
      if (issueDate != null) 'data_emissao': issueDate,
      if (lastUpdatedDate != null) 'last_updated_date': lastUpdatedDate,
      if (paymentMethod != null) 'forma_pagamento': paymentMethod,
      if (registrationDate != null) 'registration_date': registrationDate,
      if (totalValue != null) 'valor_total': totalValue,
      if (type != null) 'tipo': type,
    });
  }

  InvoicesRecordsCompanion copyWith({
    Value<String?>? customerCpf,
    Value<int?>? customerId,
    Value<String?>? customerName,
    Value<int?>? companyId,
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
      customerCpf: customerCpf ?? this.customerCpf,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      companyId: companyId ?? this.companyId,
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
    if (customerCpf.present) {
      map['cliente_cpf'] = Variable<String>(customerCpf.value);
    }
    if (customerId.present) {
      map['cliente_id'] = Variable<int>(customerId.value);
    }
    if (customerName.present) {
      map['cliente_nome'] = Variable<String>(customerName.value);
    }
    if (companyId.present) {
      map['empresa_id'] = Variable<int>(companyId.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceNumber.present) {
      map['numero_nota'] = Variable<String>(invoiceNumber.value);
    }
    if (issueDate.present) {
      map['data_emissao'] = Variable<DateTime>(issueDate.value);
    }
    if (lastUpdatedDate.present) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate.value);
    }
    if (paymentMethod.present) {
      map['forma_pagamento'] = Variable<String>(paymentMethod.value);
    }
    if (registrationDate.present) {
      map['registration_date'] = Variable<DateTime>(registrationDate.value);
    }
    if (totalValue.present) {
      map['valor_total'] = Variable<double>(totalValue.value);
    }
    if (type.present) {
      map['tipo'] = Variable<String>(
        $InvoicesRecordsTable.$convertertype.toSql(type.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesRecordsCompanion(')
          ..write('customerCpf: $customerCpf, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('companyId: $companyId, ')
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
    'nota_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'produto_id',
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
    'produto_nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productCodeMeta = const VerificationMeta(
    'productCode',
  );
  @override
  late final GeneratedColumn<String> productCode = GeneratedColumn<String>(
    'produto_codigo',
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
    'quantidade',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'preco_unitario',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalValueMeta = const VerificationMeta(
    'totalValue',
  );
  @override
  late final GeneratedColumn<double> totalValue = GeneratedColumn<double>(
    'valor_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    productId,
    productName,
    productCode,
    quantity,
    unitPrice,
    totalValue,
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
    if (data.containsKey('nota_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['nota_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('produto_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['produto_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('produto_nome')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['produto_nome']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('produto_codigo')) {
      context.handle(
        _productCodeMeta,
        productCode.isAcceptableOrUnknown(
          data['produto_codigo']!,
          _productCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productCodeMeta);
    }
    if (data.containsKey('quantidade')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantidade']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('preco_unitario')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(
          data['preco_unitario']!,
          _unitPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('valor_total')) {
      context.handle(
        _totalValueMeta,
        totalValue.isAcceptableOrUnknown(data['valor_total']!, _totalValueMeta),
      );
    } else if (isInserting) {
      context.missing(_totalValueMeta);
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
        data['${effectivePrefix}nota_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}produto_id'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}produto_nome'],
      )!,
      productCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}produto_codigo'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantidade'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}preco_unitario'],
      )!,
      totalValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}valor_total'],
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

  /// ID do produto
  final int productId;

  /// Nome do produto (desnormalizado para facilitar consultas)
  final String productName;

  /// Código do produto (desnormalizado para facilitar consultas)
  final String productCode;

  /// Quantidade do produto
  final int quantity;

  /// Preço unitário
  final double unitPrice;

  /// Valor total (quantidade * preço unitário)
  final double totalValue;
  const InvoiceItemsRecord({
    required this.id,
    required this.invoiceId,
    required this.productId,
    required this.productName,
    required this.productCode,
    required this.quantity,
    required this.unitPrice,
    required this.totalValue,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nota_id'] = Variable<int>(invoiceId);
    map['produto_id'] = Variable<int>(productId);
    map['produto_nome'] = Variable<String>(productName);
    map['produto_codigo'] = Variable<String>(productCode);
    map['quantidade'] = Variable<int>(quantity);
    map['preco_unitario'] = Variable<double>(unitPrice);
    map['valor_total'] = Variable<double>(totalValue);
    return map;
  }

  InvoiceItemsRecordsCompanion toCompanion(bool nullToAbsent) {
    return InvoiceItemsRecordsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      productId: Value(productId),
      productName: Value(productName),
      productCode: Value(productCode),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      totalValue: Value(totalValue),
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
      productId: serializer.fromJson<int>(json['productId']),
      productName: serializer.fromJson<String>(json['productName']),
      productCode: serializer.fromJson<String>(json['productCode']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      totalValue: serializer.fromJson<double>(json['totalValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'productId': serializer.toJson<int>(productId),
      'productName': serializer.toJson<String>(productName),
      'productCode': serializer.toJson<String>(productCode),
      'quantity': serializer.toJson<int>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'totalValue': serializer.toJson<double>(totalValue),
    };
  }

  InvoiceItemsRecord copyWith({
    int? id,
    int? invoiceId,
    int? productId,
    String? productName,
    String? productCode,
    int? quantity,
    double? unitPrice,
    double? totalValue,
  }) => InvoiceItemsRecord(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    productId: productId ?? this.productId,
    productName: productName ?? this.productName,
    productCode: productCode ?? this.productCode,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    totalValue: totalValue ?? this.totalValue,
  );
  InvoiceItemsRecord copyWithCompanion(InvoiceItemsRecordsCompanion data) {
    return InvoiceItemsRecord(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      productId: data.productId.present ? data.productId.value : this.productId,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      productCode: data.productCode.present
          ? data.productCode.value
          : this.productCode,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      totalValue: data.totalValue.present
          ? data.totalValue.value
          : this.totalValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemsRecord(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('productCode: $productCode, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalValue: $totalValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    productId,
    productName,
    productCode,
    quantity,
    unitPrice,
    totalValue,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceItemsRecord &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.productId == this.productId &&
          other.productName == this.productName &&
          other.productCode == this.productCode &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.totalValue == this.totalValue);
}

class InvoiceItemsRecordsCompanion extends UpdateCompanion<InvoiceItemsRecord> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<int> productId;
  final Value<String> productName;
  final Value<String> productCode;
  final Value<int> quantity;
  final Value<double> unitPrice;
  final Value<double> totalValue;
  const InvoiceItemsRecordsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.productId = const Value.absent(),
    this.productName = const Value.absent(),
    this.productCode = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.totalValue = const Value.absent(),
  });
  InvoiceItemsRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required int productId,
    required String productName,
    required String productCode,
    required int quantity,
    required double unitPrice,
    required double totalValue,
  }) : invoiceId = Value(invoiceId),
       productId = Value(productId),
       productName = Value(productName),
       productCode = Value(productCode),
       quantity = Value(quantity),
       unitPrice = Value(unitPrice),
       totalValue = Value(totalValue);
  static Insertable<InvoiceItemsRecord> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<int>? productId,
    Expression<String>? productName,
    Expression<String>? productCode,
    Expression<int>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? totalValue,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'nota_id': invoiceId,
      if (productId != null) 'produto_id': productId,
      if (productName != null) 'produto_nome': productName,
      if (productCode != null) 'produto_codigo': productCode,
      if (quantity != null) 'quantidade': quantity,
      if (unitPrice != null) 'preco_unitario': unitPrice,
      if (totalValue != null) 'valor_total': totalValue,
    });
  }

  InvoiceItemsRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceId,
    Value<int>? productId,
    Value<String>? productName,
    Value<String>? productCode,
    Value<int>? quantity,
    Value<double>? unitPrice,
    Value<double>? totalValue,
  }) {
    return InvoiceItemsRecordsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productCode: productCode ?? this.productCode,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalValue: totalValue ?? this.totalValue,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['nota_id'] = Variable<int>(invoiceId.value);
    }
    if (productId.present) {
      map['produto_id'] = Variable<int>(productId.value);
    }
    if (productName.present) {
      map['produto_nome'] = Variable<String>(productName.value);
    }
    if (productCode.present) {
      map['produto_codigo'] = Variable<String>(productCode.value);
    }
    if (quantity.present) {
      map['quantidade'] = Variable<int>(quantity.value);
    }
    if (unitPrice.present) {
      map['preco_unitario'] = Variable<double>(unitPrice.value);
    }
    if (totalValue.present) {
      map['valor_total'] = Variable<double>(totalValue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemsRecordsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('productName: $productName, ')
          ..write('productCode: $productCode, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalValue: $totalValue')
          ..write(')'))
        .toString();
  }
}

class $AddressRecordsTable extends AddressRecords
    with TableInfo<$AddressRecordsTable, Address> {
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
    Insertable<Address> instance, {
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
  Address map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Address(
      street: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}street'],
      )!,
      zipCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}zip_code'],
      )!,
      neighborhood: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}neighborhood'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
    );
  }

  @override
  $AddressRecordsTable createAlias(String alias) {
    return $AddressRecordsTable(attachedDatabase, alias);
  }
}

class AddressRecordsCompanion extends UpdateCompanion<Address> {
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
  static Insertable<Address> custom({
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
    extends BaseReferences<_$AppDatabase, $CategoriesRecordsTable, Category> {
  $$CategoriesRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ProductsRecordsTable, List<Product>>
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
          Category,
          $$CategoriesRecordsTableFilterComposer,
          $$CategoriesRecordsTableOrderingComposer,
          $$CategoriesRecordsTableAnnotationComposer,
          $$CategoriesRecordsTableCreateCompanionBuilder,
          $$CategoriesRecordsTableUpdateCompanionBuilder,
          (Category, $$CategoriesRecordsTableReferences),
          Category,
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
                      Category,
                      $CategoriesRecordsTable,
                      Product
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
      Category,
      $$CategoriesRecordsTableFilterComposer,
      $$CategoriesRecordsTableOrderingComposer,
      $$CategoriesRecordsTableAnnotationComposer,
      $$CategoriesRecordsTableCreateCompanionBuilder,
      $$CategoriesRecordsTableUpdateCompanionBuilder,
      (Category, $$CategoriesRecordsTableReferences),
      Category,
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
          Company,
          $$CompanyRecordsTableFilterComposer,
          $$CompanyRecordsTableOrderingComposer,
          $$CompanyRecordsTableAnnotationComposer,
          $$CompanyRecordsTableCreateCompanionBuilder,
          $$CompanyRecordsTableUpdateCompanionBuilder,
          (
            Company,
            BaseReferences<_$AppDatabase, $CompanyRecordsTable, Company>,
          ),
          Company,
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
      Company,
      $$CompanyRecordsTableFilterComposer,
      $$CompanyRecordsTableOrderingComposer,
      $$CompanyRecordsTableAnnotationComposer,
      $$CompanyRecordsTableCreateCompanionBuilder,
      $$CompanyRecordsTableUpdateCompanionBuilder,
      (Company, BaseReferences<_$AppDatabase, $CompanyRecordsTable, Company>),
      Company,
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
          Customer,
          $$CustomerRecordsTableFilterComposer,
          $$CustomerRecordsTableOrderingComposer,
          $$CustomerRecordsTableAnnotationComposer,
          $$CustomerRecordsTableCreateCompanionBuilder,
          $$CustomerRecordsTableUpdateCompanionBuilder,
          (
            Customer,
            BaseReferences<_$AppDatabase, $CustomerRecordsTable, Customer>,
          ),
          Customer,
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
      Customer,
      $$CustomerRecordsTableFilterComposer,
      $$CustomerRecordsTableOrderingComposer,
      $$CustomerRecordsTableAnnotationComposer,
      $$CustomerRecordsTableCreateCompanionBuilder,
      $$CustomerRecordsTableUpdateCompanionBuilder,
      (
        Customer,
        BaseReferences<_$AppDatabase, $CustomerRecordsTable, Customer>,
      ),
      Customer,
      PrefetchHooks Function()
    >;
typedef $$ProductsRecordsTableCreateCompanionBuilder =
    ProductsRecordsCompanion Function({
      required String code,
      Value<int?> categoryId,
      required String description,
      Value<int> id,
      Value<DateTime?> lastUpdatedDate,
      required String name,
      required double price,
      Value<DateTime> registrationDate,
      required int stockQuantity,
    });
typedef $$ProductsRecordsTableUpdateCompanionBuilder =
    ProductsRecordsCompanion Function({
      Value<String> code,
      Value<int?> categoryId,
      Value<String> description,
      Value<int> id,
      Value<DateTime?> lastUpdatedDate,
      Value<String> name,
      Value<double> price,
      Value<DateTime> registrationDate,
      Value<int> stockQuantity,
    });

final class $$ProductsRecordsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsRecordsTable, Product> {
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
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

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

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
          Product,
          $$ProductsRecordsTableFilterComposer,
          $$ProductsRecordsTableOrderingComposer,
          $$ProductsRecordsTableAnnotationComposer,
          $$ProductsRecordsTableCreateCompanionBuilder,
          $$ProductsRecordsTableUpdateCompanionBuilder,
          (Product, $$ProductsRecordsTableReferences),
          Product,
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
                Value<int?> categoryId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
                Value<int> stockQuantity = const Value.absent(),
              }) => ProductsRecordsCompanion(
                code: code,
                categoryId: categoryId,
                description: description,
                id: id,
                lastUpdatedDate: lastUpdatedDate,
                name: name,
                price: price,
                registrationDate: registrationDate,
                stockQuantity: stockQuantity,
              ),
          createCompanionCallback:
              ({
                required String code,
                Value<int?> categoryId = const Value.absent(),
                required String description,
                Value<int> id = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                required String name,
                required double price,
                Value<DateTime> registrationDate = const Value.absent(),
                required int stockQuantity,
              }) => ProductsRecordsCompanion.insert(
                code: code,
                categoryId: categoryId,
                description: description,
                id: id,
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
      Product,
      $$ProductsRecordsTableFilterComposer,
      $$ProductsRecordsTableOrderingComposer,
      $$ProductsRecordsTableAnnotationComposer,
      $$ProductsRecordsTableCreateCompanionBuilder,
      $$ProductsRecordsTableUpdateCompanionBuilder,
      (Product, $$ProductsRecordsTableReferences),
      Product,
      PrefetchHooks Function({bool categoryId})
    >;
typedef $$InvoicesRecordsTableCreateCompanionBuilder =
    InvoicesRecordsCompanion Function({
      Value<String?> customerCpf,
      Value<int?> customerId,
      Value<String?> customerName,
      Value<int?> companyId,
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
      Value<String?> customerCpf,
      Value<int?> customerId,
      Value<String?> customerName,
      Value<int?> companyId,
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

  ColumnFilters<int> get companyId => $composableBuilder(
    column: $table.companyId,
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

  ColumnOrderings<int> get companyId => $composableBuilder(
    column: $table.companyId,
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

  GeneratedColumn<int> get companyId =>
      $composableBuilder(column: $table.companyId, builder: (column) => column);

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
                Value<String?> customerCpf = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<int?> companyId = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<String> invoiceNumber = const Value.absent(),
                Value<DateTime> issueDate = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
                Value<double> totalValue = const Value.absent(),
                Value<InvoiceType> type = const Value.absent(),
              }) => InvoicesRecordsCompanion(
                customerCpf: customerCpf,
                customerId: customerId,
                customerName: customerName,
                companyId: companyId,
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
                Value<String?> customerCpf = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<int?> companyId = const Value.absent(),
                Value<int> id = const Value.absent(),
                required String invoiceNumber,
                required DateTime issueDate,
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                required String paymentMethod,
                Value<DateTime> registrationDate = const Value.absent(),
                required double totalValue,
                Value<InvoiceType> type = const Value.absent(),
              }) => InvoicesRecordsCompanion.insert(
                customerCpf: customerCpf,
                customerId: customerId,
                customerName: customerName,
                companyId: companyId,
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
      required int productId,
      required String productName,
      required String productCode,
      required int quantity,
      required double unitPrice,
      required double totalValue,
    });
typedef $$InvoiceItemsRecordsTableUpdateCompanionBuilder =
    InvoiceItemsRecordsCompanion Function({
      Value<int> id,
      Value<int> invoiceId,
      Value<int> productId,
      Value<String> productName,
      Value<String> productCode,
      Value<int> quantity,
      Value<double> unitPrice,
      Value<double> totalValue,
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

  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
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

  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
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

  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => column,
  );
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
                Value<int> productId = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<String> productCode = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> totalValue = const Value.absent(),
              }) => InvoiceItemsRecordsCompanion(
                id: id,
                invoiceId: invoiceId,
                productId: productId,
                productName: productName,
                productCode: productCode,
                quantity: quantity,
                unitPrice: unitPrice,
                totalValue: totalValue,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceId,
                required int productId,
                required String productName,
                required String productCode,
                required int quantity,
                required double unitPrice,
                required double totalValue,
              }) => InvoiceItemsRecordsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                productId: productId,
                productName: productName,
                productCode: productCode,
                quantity: quantity,
                unitPrice: unitPrice,
                totalValue: totalValue,
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
          Address,
          $$AddressRecordsTableFilterComposer,
          $$AddressRecordsTableOrderingComposer,
          $$AddressRecordsTableAnnotationComposer,
          $$AddressRecordsTableCreateCompanionBuilder,
          $$AddressRecordsTableUpdateCompanionBuilder,
          (
            Address,
            BaseReferences<_$AppDatabase, $AddressRecordsTable, Address>,
          ),
          Address,
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
      Address,
      $$AddressRecordsTableFilterComposer,
      $$AddressRecordsTableOrderingComposer,
      $$AddressRecordsTableAnnotationComposer,
      $$AddressRecordsTableCreateCompanionBuilder,
      $$AddressRecordsTableUpdateCompanionBuilder,
      (Address, BaseReferences<_$AppDatabase, $AddressRecordsTable, Address>),
      Address,
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
