// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ClientesRecordsTable extends ClientesRecords
    with TableInfo<$ClientesRecordsTable, ClientesRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientesRecordsTable(this.attachedDatabase, [this._alias]);
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
  );
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
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
    cpf,
    email,
    phone,
    address,
    registrationDate,
    lastUpdatedDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clientes_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClientesRecord> instance, {
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
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
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
  ClientesRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientesRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      cpf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cpf'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
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
  $ClientesRecordsTable createAlias(String alias) {
    return $ClientesRecordsTable(attachedDatabase, alias);
  }
}

class ClientesRecord extends DataClass implements Insertable<ClientesRecord> {
  final int id;
  final String name;
  final String cpf;
  final String email;
  final String phone;
  final String address;
  final DateTime registrationDate;
  final DateTime? lastUpdatedDate;
  const ClientesRecord({
    required this.id,
    required this.name,
    required this.cpf,
    required this.email,
    required this.phone,
    required this.address,
    required this.registrationDate,
    this.lastUpdatedDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['cpf'] = Variable<String>(cpf);
    map['email'] = Variable<String>(email);
    map['phone'] = Variable<String>(phone);
    map['address'] = Variable<String>(address);
    map['registration_date'] = Variable<DateTime>(registrationDate);
    if (!nullToAbsent || lastUpdatedDate != null) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate);
    }
    return map;
  }

  ClientesRecordsCompanion toCompanion(bool nullToAbsent) {
    return ClientesRecordsCompanion(
      id: Value(id),
      name: Value(name),
      cpf: Value(cpf),
      email: Value(email),
      phone: Value(phone),
      address: Value(address),
      registrationDate: Value(registrationDate),
      lastUpdatedDate: lastUpdatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedDate),
    );
  }

  factory ClientesRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientesRecord(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      cpf: serializer.fromJson<String>(json['cpf']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String>(json['phone']),
      address: serializer.fromJson<String>(json['address']),
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
      'cpf': serializer.toJson<String>(cpf),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String>(phone),
      'address': serializer.toJson<String>(address),
      'registrationDate': serializer.toJson<DateTime>(registrationDate),
      'lastUpdatedDate': serializer.toJson<DateTime?>(lastUpdatedDate),
    };
  }

  ClientesRecord copyWith({
    int? id,
    String? name,
    String? cpf,
    String? email,
    String? phone,
    String? address,
    DateTime? registrationDate,
    Value<DateTime?> lastUpdatedDate = const Value.absent(),
  }) => ClientesRecord(
    id: id ?? this.id,
    name: name ?? this.name,
    cpf: cpf ?? this.cpf,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    address: address ?? this.address,
    registrationDate: registrationDate ?? this.registrationDate,
    lastUpdatedDate: lastUpdatedDate.present
        ? lastUpdatedDate.value
        : this.lastUpdatedDate,
  );
  ClientesRecord copyWithCompanion(ClientesRecordsCompanion data) {
    return ClientesRecord(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      cpf: data.cpf.present ? data.cpf.value : this.cpf,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
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
    return (StringBuffer('ClientesRecord(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('cpf: $cpf, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('registrationDate: $registrationDate, ')
          ..write('lastUpdatedDate: $lastUpdatedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    cpf,
    email,
    phone,
    address,
    registrationDate,
    lastUpdatedDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientesRecord &&
          other.id == this.id &&
          other.name == this.name &&
          other.cpf == this.cpf &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.registrationDate == this.registrationDate &&
          other.lastUpdatedDate == this.lastUpdatedDate);
}

class ClientesRecordsCompanion extends UpdateCompanion<ClientesRecord> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> cpf;
  final Value<String> email;
  final Value<String> phone;
  final Value<String> address;
  final Value<DateTime> registrationDate;
  final Value<DateTime?> lastUpdatedDate;
  const ClientesRecordsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.cpf = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.registrationDate = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
  });
  ClientesRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String cpf,
    required String email,
    required String phone,
    required String address,
    this.registrationDate = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
  }) : name = Value(name),
       cpf = Value(cpf),
       email = Value(email),
       phone = Value(phone),
       address = Value(address);
  static Insertable<ClientesRecord> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? cpf,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<DateTime>? registrationDate,
    Expression<DateTime>? lastUpdatedDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (cpf != null) 'cpf': cpf,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (registrationDate != null) 'registration_date': registrationDate,
      if (lastUpdatedDate != null) 'last_updated_date': lastUpdatedDate,
    });
  }

  ClientesRecordsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? cpf,
    Value<String>? email,
    Value<String>? phone,
    Value<String>? address,
    Value<DateTime>? registrationDate,
    Value<DateTime?>? lastUpdatedDate,
  }) {
    return ClientesRecordsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      cpf: cpf ?? this.cpf,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
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
    if (cpf.present) {
      map['cpf'] = Variable<String>(cpf.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
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
    return (StringBuffer('ClientesRecordsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('cpf: $cpf, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('registrationDate: $registrationDate, ')
          ..write('lastUpdatedDate: $lastUpdatedDate')
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
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    category,
    code,
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
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
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
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      stockQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock_quantity'],
      )!,
      lastUpdatedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_date'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
    );
  }

  @override
  $ProductsRecordsTable createAlias(String alias) {
    return $ProductsRecordsTable(attachedDatabase, alias);
  }
}

class ProductsRecordsCompanion extends UpdateCompanion<Product> {
  final Value<String> category;
  final Value<String> code;
  final Value<String> description;
  final Value<int> id;
  final Value<DateTime?> lastUpdatedDate;
  final Value<String> name;
  final Value<double> price;
  final Value<DateTime> registrationDate;
  final Value<int> stockQuantity;
  const ProductsRecordsCompanion({
    this.category = const Value.absent(),
    this.code = const Value.absent(),
    this.description = const Value.absent(),
    this.id = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.registrationDate = const Value.absent(),
    this.stockQuantity = const Value.absent(),
  });
  ProductsRecordsCompanion.insert({
    required String category,
    required String code,
    required String description,
    this.id = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    required String name,
    required double price,
    this.registrationDate = const Value.absent(),
    required int stockQuantity,
  }) : category = Value(category),
       code = Value(code),
       description = Value(description),
       name = Value(name),
       price = Value(price),
       stockQuantity = Value(stockQuantity);
  static Insertable<Product> custom({
    Expression<String>? category,
    Expression<String>? code,
    Expression<String>? description,
    Expression<int>? id,
    Expression<DateTime>? lastUpdatedDate,
    Expression<String>? name,
    Expression<double>? price,
    Expression<DateTime>? registrationDate,
    Expression<int>? stockQuantity,
  }) {
    return RawValuesInsertable({
      if (category != null) 'category': category,
      if (code != null) 'code': code,
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
    Value<String>? category,
    Value<String>? code,
    Value<String>? description,
    Value<int>? id,
    Value<DateTime?>? lastUpdatedDate,
    Value<String>? name,
    Value<double>? price,
    Value<DateTime>? registrationDate,
    Value<int>? stockQuantity,
  }) {
    return ProductsRecordsCompanion(
      category: category ?? this.category,
      code: code ?? this.code,
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
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
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
          ..write('category: $category, ')
          ..write('code: $code, ')
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

class _$ProductInsertable implements Insertable<Product> {
  Product _object;
  _$ProductInsertable(this._object);
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return ProductsRecordsCompanion(
      category: Value(_object.category),
      code: Value(_object.code),
      description: Value(_object.description),
      id: Value(_object.id),
      lastUpdatedDate: Value(_object.lastUpdatedDate),
      name: Value(_object.name),
      price: Value(_object.price),
      registrationDate: Value(_object.registrationDate),
      stockQuantity: Value(_object.stockQuantity),
    ).toColumns(false);
  }
}

extension ProductToInsertable on Product {
  _$ProductInsertable toInsertable() {
    return _$ProductInsertable(this);
  }
}

class $InvoicesRecordsTable extends InvoicesRecords
    with TableInfo<$InvoicesRecordsTable, InvoicesRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesRecordsTable(this.attachedDatabase, [this._alias]);
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
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'cliente_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'cliente_nome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerCpfMeta = const VerificationMeta(
    'customerCpf',
  );
  @override
  late final GeneratedColumn<String> customerCpf = GeneratedColumn<String>(
    'cliente_cpf',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
    invoiceNumber,
    customerId,
    customerName,
    customerCpf,
    totalValue,
    paymentMethod,
    issueDate,
    registrationDate,
    lastUpdatedDate,
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
    if (data.containsKey('cliente_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['cliente_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('cliente_nome')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['cliente_nome']!,
          _customerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('cliente_cpf')) {
      context.handle(
        _customerCpfMeta,
        customerCpf.isAcceptableOrUnknown(
          data['cliente_cpf']!,
          _customerCpfMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerCpfMeta);
    }
    if (data.containsKey('valor_total')) {
      context.handle(
        _totalValueMeta,
        totalValue.isAcceptableOrUnknown(data['valor_total']!, _totalValueMeta),
      );
    } else if (isInserting) {
      context.missing(_totalValueMeta);
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
    if (data.containsKey('data_emissao')) {
      context.handle(
        _issueDateMeta,
        issueDate.isAcceptableOrUnknown(data['data_emissao']!, _issueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_issueDateMeta);
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
  InvoicesRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoicesRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}numero_nota'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cliente_id'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cliente_nome'],
      )!,
      customerCpf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cliente_cpf'],
      )!,
      totalValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}valor_total'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}forma_pagamento'],
      )!,
      issueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}data_emissao'],
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
  $InvoicesRecordsTable createAlias(String alias) {
    return $InvoicesRecordsTable(attachedDatabase, alias);
  }
}

class InvoicesRecord extends DataClass implements Insertable<InvoicesRecord> {
  final int id;

  /// Número da nota fiscal
  final String invoiceNumber;

  /// ID do cliente
  final int customerId;

  /// Nome do cliente (desnormalizado para facilitar consultas)
  final String customerName;

  /// CPF do cliente (desnormalizado para facilitar consultas)
  final String customerCpf;

  /// Valor total da nota fiscal
  final double totalValue;

  /// Forma de pagamento
  final String paymentMethod;

  /// Data de emissão da nota
  final DateTime issueDate;

  /// Data de cadastro no sistema
  final DateTime registrationDate;

  /// Data da última atualização
  final DateTime? lastUpdatedDate;
  const InvoicesRecord({
    required this.id,
    required this.invoiceNumber,
    required this.customerId,
    required this.customerName,
    required this.customerCpf,
    required this.totalValue,
    required this.paymentMethod,
    required this.issueDate,
    required this.registrationDate,
    this.lastUpdatedDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['numero_nota'] = Variable<String>(invoiceNumber);
    map['cliente_id'] = Variable<int>(customerId);
    map['cliente_nome'] = Variable<String>(customerName);
    map['cliente_cpf'] = Variable<String>(customerCpf);
    map['valor_total'] = Variable<double>(totalValue);
    map['forma_pagamento'] = Variable<String>(paymentMethod);
    map['data_emissao'] = Variable<DateTime>(issueDate);
    map['registration_date'] = Variable<DateTime>(registrationDate);
    if (!nullToAbsent || lastUpdatedDate != null) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate);
    }
    return map;
  }

  InvoicesRecordsCompanion toCompanion(bool nullToAbsent) {
    return InvoicesRecordsCompanion(
      id: Value(id),
      invoiceNumber: Value(invoiceNumber),
      customerId: Value(customerId),
      customerName: Value(customerName),
      customerCpf: Value(customerCpf),
      totalValue: Value(totalValue),
      paymentMethod: Value(paymentMethod),
      issueDate: Value(issueDate),
      registrationDate: Value(registrationDate),
      lastUpdatedDate: lastUpdatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedDate),
    );
  }

  factory InvoicesRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoicesRecord(
      id: serializer.fromJson<int>(json['id']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      customerId: serializer.fromJson<int>(json['customerId']),
      customerName: serializer.fromJson<String>(json['customerName']),
      customerCpf: serializer.fromJson<String>(json['customerCpf']),
      totalValue: serializer.fromJson<double>(json['totalValue']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      issueDate: serializer.fromJson<DateTime>(json['issueDate']),
      registrationDate: serializer.fromJson<DateTime>(json['registrationDate']),
      lastUpdatedDate: serializer.fromJson<DateTime?>(json['lastUpdatedDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'customerId': serializer.toJson<int>(customerId),
      'customerName': serializer.toJson<String>(customerName),
      'customerCpf': serializer.toJson<String>(customerCpf),
      'totalValue': serializer.toJson<double>(totalValue),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'issueDate': serializer.toJson<DateTime>(issueDate),
      'registrationDate': serializer.toJson<DateTime>(registrationDate),
      'lastUpdatedDate': serializer.toJson<DateTime?>(lastUpdatedDate),
    };
  }

  InvoicesRecord copyWith({
    int? id,
    String? invoiceNumber,
    int? customerId,
    String? customerName,
    String? customerCpf,
    double? totalValue,
    String? paymentMethod,
    DateTime? issueDate,
    DateTime? registrationDate,
    Value<DateTime?> lastUpdatedDate = const Value.absent(),
  }) => InvoicesRecord(
    id: id ?? this.id,
    invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    customerId: customerId ?? this.customerId,
    customerName: customerName ?? this.customerName,
    customerCpf: customerCpf ?? this.customerCpf,
    totalValue: totalValue ?? this.totalValue,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    issueDate: issueDate ?? this.issueDate,
    registrationDate: registrationDate ?? this.registrationDate,
    lastUpdatedDate: lastUpdatedDate.present
        ? lastUpdatedDate.value
        : this.lastUpdatedDate,
  );
  InvoicesRecord copyWithCompanion(InvoicesRecordsCompanion data) {
    return InvoicesRecord(
      id: data.id.present ? data.id.value : this.id,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      customerCpf: data.customerCpf.present
          ? data.customerCpf.value
          : this.customerCpf,
      totalValue: data.totalValue.present
          ? data.totalValue.value
          : this.totalValue,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      issueDate: data.issueDate.present ? data.issueDate.value : this.issueDate,
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
    return (StringBuffer('InvoicesRecord(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('customerCpf: $customerCpf, ')
          ..write('totalValue: $totalValue, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('issueDate: $issueDate, ')
          ..write('registrationDate: $registrationDate, ')
          ..write('lastUpdatedDate: $lastUpdatedDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceNumber,
    customerId,
    customerName,
    customerCpf,
    totalValue,
    paymentMethod,
    issueDate,
    registrationDate,
    lastUpdatedDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoicesRecord &&
          other.id == this.id &&
          other.invoiceNumber == this.invoiceNumber &&
          other.customerId == this.customerId &&
          other.customerName == this.customerName &&
          other.customerCpf == this.customerCpf &&
          other.totalValue == this.totalValue &&
          other.paymentMethod == this.paymentMethod &&
          other.issueDate == this.issueDate &&
          other.registrationDate == this.registrationDate &&
          other.lastUpdatedDate == this.lastUpdatedDate);
}

class InvoicesRecordsCompanion extends UpdateCompanion<InvoicesRecord> {
  final Value<int> id;
  final Value<String> invoiceNumber;
  final Value<int> customerId;
  final Value<String> customerName;
  final Value<String> customerCpf;
  final Value<double> totalValue;
  final Value<String> paymentMethod;
  final Value<DateTime> issueDate;
  final Value<DateTime> registrationDate;
  final Value<DateTime?> lastUpdatedDate;
  const InvoicesRecordsCompanion({
    this.id = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.customerCpf = const Value.absent(),
    this.totalValue = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.issueDate = const Value.absent(),
    this.registrationDate = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
  });
  InvoicesRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String invoiceNumber,
    required int customerId,
    required String customerName,
    required String customerCpf,
    required double totalValue,
    required String paymentMethod,
    required DateTime issueDate,
    this.registrationDate = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
  }) : invoiceNumber = Value(invoiceNumber),
       customerId = Value(customerId),
       customerName = Value(customerName),
       customerCpf = Value(customerCpf),
       totalValue = Value(totalValue),
       paymentMethod = Value(paymentMethod),
       issueDate = Value(issueDate);
  static Insertable<InvoicesRecord> custom({
    Expression<int>? id,
    Expression<String>? invoiceNumber,
    Expression<int>? customerId,
    Expression<String>? customerName,
    Expression<String>? customerCpf,
    Expression<double>? totalValue,
    Expression<String>? paymentMethod,
    Expression<DateTime>? issueDate,
    Expression<DateTime>? registrationDate,
    Expression<DateTime>? lastUpdatedDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceNumber != null) 'numero_nota': invoiceNumber,
      if (customerId != null) 'cliente_id': customerId,
      if (customerName != null) 'cliente_nome': customerName,
      if (customerCpf != null) 'cliente_cpf': customerCpf,
      if (totalValue != null) 'valor_total': totalValue,
      if (paymentMethod != null) 'forma_pagamento': paymentMethod,
      if (issueDate != null) 'data_emissao': issueDate,
      if (registrationDate != null) 'registration_date': registrationDate,
      if (lastUpdatedDate != null) 'last_updated_date': lastUpdatedDate,
    });
  }

  InvoicesRecordsCompanion copyWith({
    Value<int>? id,
    Value<String>? invoiceNumber,
    Value<int>? customerId,
    Value<String>? customerName,
    Value<String>? customerCpf,
    Value<double>? totalValue,
    Value<String>? paymentMethod,
    Value<DateTime>? issueDate,
    Value<DateTime>? registrationDate,
    Value<DateTime?>? lastUpdatedDate,
  }) {
    return InvoicesRecordsCompanion(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerCpf: customerCpf ?? this.customerCpf,
      totalValue: totalValue ?? this.totalValue,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      issueDate: issueDate ?? this.issueDate,
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
    if (invoiceNumber.present) {
      map['numero_nota'] = Variable<String>(invoiceNumber.value);
    }
    if (customerId.present) {
      map['cliente_id'] = Variable<int>(customerId.value);
    }
    if (customerName.present) {
      map['cliente_nome'] = Variable<String>(customerName.value);
    }
    if (customerCpf.present) {
      map['cliente_cpf'] = Variable<String>(customerCpf.value);
    }
    if (totalValue.present) {
      map['valor_total'] = Variable<double>(totalValue.value);
    }
    if (paymentMethod.present) {
      map['forma_pagamento'] = Variable<String>(paymentMethod.value);
    }
    if (issueDate.present) {
      map['data_emissao'] = Variable<DateTime>(issueDate.value);
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
    return (StringBuffer('InvoicesRecordsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('customerCpf: $customerCpf, ')
          ..write('totalValue: $totalValue, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('issueDate: $issueDate, ')
          ..write('registrationDate: $registrationDate, ')
          ..write('lastUpdatedDate: $lastUpdatedDate')
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientesRecordsTable clientesRecords = $ClientesRecordsTable(
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
  late final ClienteDao clienteDao = ClienteDao(this as AppDatabase);
  late final ProductDao productDao = ProductDao(this as AppDatabase);
  late final InvoiceDao invoiceDao = InvoiceDao(this as AppDatabase);
  late final InvoiceItemDao invoiceItemDao = InvoiceItemDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    clientesRecords,
    productsRecords,
    invoicesRecords,
    invoiceItemsRecords,
  ];
}

typedef $$ClientesRecordsTableCreateCompanionBuilder =
    ClientesRecordsCompanion Function({
      Value<int> id,
      required String name,
      required String cpf,
      required String email,
      required String phone,
      required String address,
      Value<DateTime> registrationDate,
      Value<DateTime?> lastUpdatedDate,
    });
typedef $$ClientesRecordsTableUpdateCompanionBuilder =
    ClientesRecordsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> cpf,
      Value<String> email,
      Value<String> phone,
      Value<String> address,
      Value<DateTime> registrationDate,
      Value<DateTime?> lastUpdatedDate,
    });

class $$ClientesRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientesRecordsTable> {
  $$ClientesRecordsTableFilterComposer({
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

  ColumnFilters<String> get cpf => $composableBuilder(
    column: $table.cpf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
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
}

class $$ClientesRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientesRecordsTable> {
  $$ClientesRecordsTableOrderingComposer({
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

  ColumnOrderings<String> get cpf => $composableBuilder(
    column: $table.cpf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
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

class $$ClientesRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientesRecordsTable> {
  $$ClientesRecordsTableAnnotationComposer({
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

  GeneratedColumn<String> get cpf =>
      $composableBuilder(column: $table.cpf, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => column,
  );
}

class $$ClientesRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientesRecordsTable,
          ClientesRecord,
          $$ClientesRecordsTableFilterComposer,
          $$ClientesRecordsTableOrderingComposer,
          $$ClientesRecordsTableAnnotationComposer,
          $$ClientesRecordsTableCreateCompanionBuilder,
          $$ClientesRecordsTableUpdateCompanionBuilder,
          (
            ClientesRecord,
            BaseReferences<
              _$AppDatabase,
              $ClientesRecordsTable,
              ClientesRecord
            >,
          ),
          ClientesRecord,
          PrefetchHooks Function()
        > {
  $$ClientesRecordsTableTableManager(
    _$AppDatabase db,
    $ClientesRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientesRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientesRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientesRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> cpf = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
              }) => ClientesRecordsCompanion(
                id: id,
                name: name,
                cpf: cpf,
                email: email,
                phone: phone,
                address: address,
                registrationDate: registrationDate,
                lastUpdatedDate: lastUpdatedDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String cpf,
                required String email,
                required String phone,
                required String address,
                Value<DateTime> registrationDate = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
              }) => ClientesRecordsCompanion.insert(
                id: id,
                name: name,
                cpf: cpf,
                email: email,
                phone: phone,
                address: address,
                registrationDate: registrationDate,
                lastUpdatedDate: lastUpdatedDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClientesRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientesRecordsTable,
      ClientesRecord,
      $$ClientesRecordsTableFilterComposer,
      $$ClientesRecordsTableOrderingComposer,
      $$ClientesRecordsTableAnnotationComposer,
      $$ClientesRecordsTableCreateCompanionBuilder,
      $$ClientesRecordsTableUpdateCompanionBuilder,
      (
        ClientesRecord,
        BaseReferences<_$AppDatabase, $ClientesRecordsTable, ClientesRecord>,
      ),
      ClientesRecord,
      PrefetchHooks Function()
    >;
typedef $$ProductsRecordsTableCreateCompanionBuilder =
    ProductsRecordsCompanion Function({
      required String category,
      required String code,
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
      Value<String> category,
      Value<String> code,
      Value<String> description,
      Value<int> id,
      Value<DateTime?> lastUpdatedDate,
      Value<String> name,
      Value<double> price,
      Value<DateTime> registrationDate,
      Value<int> stockQuantity,
    });

class $$ProductsRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsRecordsTable> {
  $$ProductsRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

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
  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

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
  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

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
          (
            Product,
            BaseReferences<_$AppDatabase, $ProductsRecordsTable, Product>,
          ),
          Product,
          PrefetchHooks Function()
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
                Value<String> category = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
                Value<int> stockQuantity = const Value.absent(),
              }) => ProductsRecordsCompanion(
                category: category,
                code: code,
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
                required String category,
                required String code,
                required String description,
                Value<int> id = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                required String name,
                required double price,
                Value<DateTime> registrationDate = const Value.absent(),
                required int stockQuantity,
              }) => ProductsRecordsCompanion.insert(
                category: category,
                code: code,
                description: description,
                id: id,
                lastUpdatedDate: lastUpdatedDate,
                name: name,
                price: price,
                registrationDate: registrationDate,
                stockQuantity: stockQuantity,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
      (Product, BaseReferences<_$AppDatabase, $ProductsRecordsTable, Product>),
      Product,
      PrefetchHooks Function()
    >;
typedef $$InvoicesRecordsTableCreateCompanionBuilder =
    InvoicesRecordsCompanion Function({
      Value<int> id,
      required String invoiceNumber,
      required int customerId,
      required String customerName,
      required String customerCpf,
      required double totalValue,
      required String paymentMethod,
      required DateTime issueDate,
      Value<DateTime> registrationDate,
      Value<DateTime?> lastUpdatedDate,
    });
typedef $$InvoicesRecordsTableUpdateCompanionBuilder =
    InvoicesRecordsCompanion Function({
      Value<int> id,
      Value<String> invoiceNumber,
      Value<int> customerId,
      Value<String> customerName,
      Value<String> customerCpf,
      Value<double> totalValue,
      Value<String> paymentMethod,
      Value<DateTime> issueDate,
      Value<DateTime> registrationDate,
      Value<DateTime?> lastUpdatedDate,
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
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
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

  ColumnFilters<String> get customerCpf => $composableBuilder(
    column: $table.customerCpf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
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
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
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

  ColumnOrderings<String> get customerCpf => $composableBuilder(
    column: $table.customerCpf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
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

class $$InvoicesRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesRecordsTable> {
  $$InvoicesRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber => $composableBuilder(
    column: $table.invoiceNumber,
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

  GeneratedColumn<String> get customerCpf => $composableBuilder(
    column: $table.customerCpf,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalValue => $composableBuilder(
    column: $table.totalValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get issueDate =>
      $composableBuilder(column: $table.issueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get registrationDate => $composableBuilder(
    column: $table.registrationDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdatedDate => $composableBuilder(
    column: $table.lastUpdatedDate,
    builder: (column) => column,
  );
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
                Value<int> id = const Value.absent(),
                Value<String> invoiceNumber = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<String> customerName = const Value.absent(),
                Value<String> customerCpf = const Value.absent(),
                Value<double> totalValue = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<DateTime> issueDate = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
              }) => InvoicesRecordsCompanion(
                id: id,
                invoiceNumber: invoiceNumber,
                customerId: customerId,
                customerName: customerName,
                customerCpf: customerCpf,
                totalValue: totalValue,
                paymentMethod: paymentMethod,
                issueDate: issueDate,
                registrationDate: registrationDate,
                lastUpdatedDate: lastUpdatedDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String invoiceNumber,
                required int customerId,
                required String customerName,
                required String customerCpf,
                required double totalValue,
                required String paymentMethod,
                required DateTime issueDate,
                Value<DateTime> registrationDate = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
              }) => InvoicesRecordsCompanion.insert(
                id: id,
                invoiceNumber: invoiceNumber,
                customerId: customerId,
                customerName: customerName,
                customerCpf: customerCpf,
                totalValue: totalValue,
                paymentMethod: paymentMethod,
                issueDate: issueDate,
                registrationDate: registrationDate,
                lastUpdatedDate: lastUpdatedDate,
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientesRecordsTableTableManager get clientesRecords =>
      $$ClientesRecordsTableTableManager(_db, _db.clientesRecords);
  $$ProductsRecordsTableTableManager get productsRecords =>
      $$ProductsRecordsTableTableManager(_db, _db.productsRecords);
  $$InvoicesRecordsTableTableManager get invoicesRecords =>
      $$InvoicesRecordsTableTableManager(_db, _db.invoicesRecords);
  $$InvoiceItemsRecordsTableTableManager get invoiceItemsRecords =>
      $$InvoiceItemsRecordsTableTableManager(_db, _db.invoiceItemsRecords);
}
