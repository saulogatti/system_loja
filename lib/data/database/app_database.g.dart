// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ClientesRecordsTable extends ClientesRecords
    with TableInfo<$ClientesRecordsTable, ClientesRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientesRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
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
  static const String $name = 'clientes_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClientesRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
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
    } else if (isInserting) {
      context.missing(_phoneMeta);
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
  ClientesRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientesRecord(
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      cpf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cpf'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      lastUpdatedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated_date'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      registrationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}registration_date'],
      )!,
    );
  }

  @override
  $ClientesRecordsTable createAlias(String alias) {
    return $ClientesRecordsTable(attachedDatabase, alias);
  }
}

class ClientesRecord extends DataClass implements Insertable<ClientesRecord> {
  final String address;
  final String cpf;
  final String email;
  final int id;
  final DateTime? lastUpdatedDate;
  final String name;
  final String phone;
  final DateTime registrationDate;
  const ClientesRecord({
    required this.address,
    required this.cpf,
    required this.email,
    required this.id,
    this.lastUpdatedDate,
    required this.name,
    required this.phone,
    required this.registrationDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['address'] = Variable<String>(address);
    map['cpf'] = Variable<String>(cpf);
    map['email'] = Variable<String>(email);
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || lastUpdatedDate != null) {
      map['last_updated_date'] = Variable<DateTime>(lastUpdatedDate);
    }
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    map['registration_date'] = Variable<DateTime>(registrationDate);
    return map;
  }

  ClientesRecordsCompanion toCompanion(bool nullToAbsent) {
    return ClientesRecordsCompanion(
      address: Value(address),
      cpf: Value(cpf),
      email: Value(email),
      id: Value(id),
      lastUpdatedDate: lastUpdatedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedDate),
      name: Value(name),
      phone: Value(phone),
      registrationDate: Value(registrationDate),
    );
  }

  factory ClientesRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientesRecord(
      address: serializer.fromJson<String>(json['address']),
      cpf: serializer.fromJson<String>(json['cpf']),
      email: serializer.fromJson<String>(json['email']),
      id: serializer.fromJson<int>(json['id']),
      lastUpdatedDate: serializer.fromJson<DateTime?>(json['lastUpdatedDate']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      registrationDate: serializer.fromJson<DateTime>(json['registrationDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'address': serializer.toJson<String>(address),
      'cpf': serializer.toJson<String>(cpf),
      'email': serializer.toJson<String>(email),
      'id': serializer.toJson<int>(id),
      'lastUpdatedDate': serializer.toJson<DateTime?>(lastUpdatedDate),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'registrationDate': serializer.toJson<DateTime>(registrationDate),
    };
  }

  ClientesRecord copyWith({
    String? address,
    String? cpf,
    String? email,
    int? id,
    Value<DateTime?> lastUpdatedDate = const Value.absent(),
    String? name,
    String? phone,
    DateTime? registrationDate,
  }) => ClientesRecord(
    address: address ?? this.address,
    cpf: cpf ?? this.cpf,
    email: email ?? this.email,
    id: id ?? this.id,
    lastUpdatedDate: lastUpdatedDate.present
        ? lastUpdatedDate.value
        : this.lastUpdatedDate,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    registrationDate: registrationDate ?? this.registrationDate,
  );
  ClientesRecord copyWithCompanion(ClientesRecordsCompanion data) {
    return ClientesRecord(
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
    return (StringBuffer('ClientesRecord(')
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
      (other is ClientesRecord &&
          other.address == this.address &&
          other.cpf == this.cpf &&
          other.email == this.email &&
          other.id == this.id &&
          other.lastUpdatedDate == this.lastUpdatedDate &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.registrationDate == this.registrationDate);
}

class ClientesRecordsCompanion extends UpdateCompanion<ClientesRecord> {
  final Value<String> address;
  final Value<String> cpf;
  final Value<String> email;
  final Value<int> id;
  final Value<DateTime?> lastUpdatedDate;
  final Value<String> name;
  final Value<String> phone;
  final Value<DateTime> registrationDate;
  const ClientesRecordsCompanion({
    this.address = const Value.absent(),
    this.cpf = const Value.absent(),
    this.email = const Value.absent(),
    this.id = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.registrationDate = const Value.absent(),
  });
  ClientesRecordsCompanion.insert({
    required String address,
    required String cpf,
    required String email,
    this.id = const Value.absent(),
    this.lastUpdatedDate = const Value.absent(),
    required String name,
    required String phone,
    this.registrationDate = const Value.absent(),
  }) : address = Value(address),
       cpf = Value(cpf),
       email = Value(email),
       name = Value(name),
       phone = Value(phone);
  static Insertable<ClientesRecord> custom({
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

  ClientesRecordsCompanion copyWith({
    Value<String>? address,
    Value<String>? cpf,
    Value<String>? email,
    Value<int>? id,
    Value<DateTime?>? lastUpdatedDate,
    Value<String>? name,
    Value<String>? phone,
    Value<DateTime>? registrationDate,
  }) {
    return ClientesRecordsCompanion(
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
      map['address'] = Variable<String>(address.value);
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
    return (StringBuffer('ClientesRecordsCompanion(')
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientesRecordsTable clientesRecords = $ClientesRecordsTable(
    this,
  );
  late final $ProductsRecordsTable productsRecords = $ProductsRecordsTable(
    this,
  );
  late final ClienteDao clienteDao = ClienteDao(this as AppDatabase);
  late final ProductDao productDao = ProductDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    clientesRecords,
    productsRecords,
  ];
}

typedef $$ClientesRecordsTableCreateCompanionBuilder =
    ClientesRecordsCompanion Function({
      required String address,
      required String cpf,
      required String email,
      Value<int> id,
      Value<DateTime?> lastUpdatedDate,
      required String name,
      required String phone,
      Value<DateTime> registrationDate,
    });
typedef $$ClientesRecordsTableUpdateCompanionBuilder =
    ClientesRecordsCompanion Function({
      Value<String> address,
      Value<String> cpf,
      Value<String> email,
      Value<int> id,
      Value<DateTime?> lastUpdatedDate,
      Value<String> name,
      Value<String> phone,
      Value<DateTime> registrationDate,
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
  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
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

class $$ClientesRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientesRecordsTable> {
  $$ClientesRecordsTableOrderingComposer({
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

class $$ClientesRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientesRecordsTable> {
  $$ClientesRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get address =>
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
                Value<String> address = const Value.absent(),
                Value<String> cpf = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<DateTime> registrationDate = const Value.absent(),
              }) => ClientesRecordsCompanion(
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
                required String address,
                required String cpf,
                required String email,
                Value<int> id = const Value.absent(),
                Value<DateTime?> lastUpdatedDate = const Value.absent(),
                required String name,
                required String phone,
                Value<DateTime> registrationDate = const Value.absent(),
              }) => ClientesRecordsCompanion.insert(
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientesRecordsTableTableManager get clientesRecords =>
      $$ClientesRecordsTableTableManager(_db, _db.clientesRecords);
  $$ProductsRecordsTableTableManager get productsRecords =>
      $$ProductsRecordsTableTableManager(_db, _db.productsRecords);
}
