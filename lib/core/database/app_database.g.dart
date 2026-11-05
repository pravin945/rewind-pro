// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  @override
  late final GeneratedColumn<String> mobile = GeneratedColumn<String>(
    'mobile',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 10,
      maxTextLength: 15,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alternateMobileMeta = const VerificationMeta(
    'alternateMobile',
  );
  @override
  late final GeneratedColumn<String> alternateMobile = GeneratedColumn<String>(
    'alternate_mobile',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _villageCityMeta = const VerificationMeta(
    'villageCity',
  );
  @override
  late final GeneratedColumn<String> villageCity = GeneratedColumn<String>(
    'village_city',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    mobile,
    alternateMobile,
    address,
    villageCity,
    notes,
    createdAt,
    updatedAt,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<Customer> instance, {
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
    if (data.containsKey('mobile')) {
      context.handle(
        _mobileMeta,
        mobile.isAcceptableOrUnknown(data['mobile']!, _mobileMeta),
      );
    } else if (isInserting) {
      context.missing(_mobileMeta);
    }
    if (data.containsKey('alternate_mobile')) {
      context.handle(
        _alternateMobileMeta,
        alternateMobile.isAcceptableOrUnknown(
          data['alternate_mobile']!,
          _alternateMobileMeta,
        ),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('village_city')) {
      context.handle(
        _villageCityMeta,
        villageCity.isAcceptableOrUnknown(
          data['village_city']!,
          _villageCityMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
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
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      mobile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mobile'],
      )!,
      alternateMobile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alternate_mobile'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      villageCity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}village_city'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String name;
  final String mobile;
  final String? alternateMobile;
  final String? address;
  final String? villageCity;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isDeleted;
  const Customer({
    required this.id,
    required this.name,
    required this.mobile,
    this.alternateMobile,
    this.address,
    this.villageCity,
    this.notes,
    required this.createdAt,
    this.updatedAt,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['mobile'] = Variable<String>(mobile);
    if (!nullToAbsent || alternateMobile != null) {
      map['alternate_mobile'] = Variable<String>(alternateMobile);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || villageCity != null) {
      map['village_city'] = Variable<String>(villageCity);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      mobile: Value(mobile),
      alternateMobile: alternateMobile == null && nullToAbsent
          ? const Value.absent()
          : Value(alternateMobile),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      villageCity: villageCity == null && nullToAbsent
          ? const Value.absent()
          : Value(villageCity),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      isDeleted: Value(isDeleted),
    );
  }

  factory Customer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      mobile: serializer.fromJson<String>(json['mobile']),
      alternateMobile: serializer.fromJson<String?>(json['alternateMobile']),
      address: serializer.fromJson<String?>(json['address']),
      villageCity: serializer.fromJson<String?>(json['villageCity']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'mobile': serializer.toJson<String>(mobile),
      'alternateMobile': serializer.toJson<String?>(alternateMobile),
      'address': serializer.toJson<String?>(address),
      'villageCity': serializer.toJson<String?>(villageCity),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  Customer copyWith({
    int? id,
    String? name,
    String? mobile,
    Value<String?> alternateMobile = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> villageCity = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    bool? isDeleted,
  }) => Customer(
    id: id ?? this.id,
    name: name ?? this.name,
    mobile: mobile ?? this.mobile,
    alternateMobile: alternateMobile.present
        ? alternateMobile.value
        : this.alternateMobile,
    address: address.present ? address.value : this.address,
    villageCity: villageCity.present ? villageCity.value : this.villageCity,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      mobile: data.mobile.present ? data.mobile.value : this.mobile,
      alternateMobile: data.alternateMobile.present
          ? data.alternateMobile.value
          : this.alternateMobile,
      address: data.address.present ? data.address.value : this.address,
      villageCity: data.villageCity.present
          ? data.villageCity.value
          : this.villageCity,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mobile: $mobile, ')
          ..write('alternateMobile: $alternateMobile, ')
          ..write('address: $address, ')
          ..write('villageCity: $villageCity, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    mobile,
    alternateMobile,
    address,
    villageCity,
    notes,
    createdAt,
    updatedAt,
    isDeleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.mobile == this.mobile &&
          other.alternateMobile == this.alternateMobile &&
          other.address == this.address &&
          other.villageCity == this.villageCity &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> mobile;
  final Value<String?> alternateMobile;
  final Value<String?> address;
  final Value<String?> villageCity;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<bool> isDeleted;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.mobile = const Value.absent(),
    this.alternateMobile = const Value.absent(),
    this.address = const Value.absent(),
    this.villageCity = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String mobile,
    this.alternateMobile = const Value.absent(),
    this.address = const Value.absent(),
    this.villageCity = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
  }) : name = Value(name),
       mobile = Value(mobile);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? mobile,
    Expression<String>? alternateMobile,
    Expression<String>? address,
    Expression<String>? villageCity,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (mobile != null) 'mobile': mobile,
      if (alternateMobile != null) 'alternate_mobile': alternateMobile,
      if (address != null) 'address': address,
      if (villageCity != null) 'village_city': villageCity,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? mobile,
    Value<String?>? alternateMobile,
    Value<String?>? address,
    Value<String?>? villageCity,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<bool>? isDeleted,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      alternateMobile: alternateMobile ?? this.alternateMobile,
      address: address ?? this.address,
      villageCity: villageCity ?? this.villageCity,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
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
    if (mobile.present) {
      map['mobile'] = Variable<String>(mobile.value);
    }
    if (alternateMobile.present) {
      map['alternate_mobile'] = Variable<String>(alternateMobile.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (villageCity.present) {
      map['village_city'] = Variable<String>(villageCity.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('mobile: $mobile, ')
          ..write('alternateMobile: $alternateMobile, ')
          ..write('address: $address, ')
          ..write('villageCity: $villageCity, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }
}

class $ProductCategoriesTable extends ProductCategories
    with TableInfo<$ProductCategoriesTable, ProductCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductCategoriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductCategory> instance, {
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
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductCategory(
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
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ProductCategoriesTable createAlias(String alias) {
    return $ProductCategoriesTable(attachedDatabase, alias);
  }
}

class ProductCategory extends DataClass implements Insertable<ProductCategory> {
  final int id;
  final String name;
  final String? description;
  final DateTime createdAt;
  const ProductCategory({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ProductCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ProductCategoriesCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
    );
  }

  factory ProductCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductCategory(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ProductCategory copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    DateTime? createdAt,
  }) => ProductCategory(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    createdAt: createdAt ?? this.createdAt,
  );
  ProductCategory copyWithCompanion(ProductCategoriesCompanion data) {
    return ProductCategory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductCategory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductCategory &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt);
}

class ProductCategoriesCompanion extends UpdateCompanion<ProductCategory> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  const ProductCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ProductCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<ProductCategory> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ProductCategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<DateTime>? createdAt,
  }) {
    return ProductCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
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
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
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
      'REFERENCES product_categories (id)',
    ),
  );
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modelNumberMeta = const VerificationMeta(
    'modelNumber',
  );
  @override
  late final GeneratedColumn<String> modelNumber = GeneratedColumn<String>(
    'model_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hpMeta = const VerificationMeta('hp');
  @override
  late final GeneratedColumn<String> hp = GeneratedColumn<String>(
    'hp',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _sellingPriceMeta = const VerificationMeta(
    'sellingPrice',
  );
  @override
  late final GeneratedColumn<double> sellingPrice = GeneratedColumn<double>(
    'selling_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _currentStockMeta = const VerificationMeta(
    'currentStock',
  );
  @override
  late final GeneratedColumn<double> currentStock = GeneratedColumn<double>(
    'current_stock',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _minimumStockLevelMeta = const VerificationMeta(
    'minimumStockLevel',
  );
  @override
  late final GeneratedColumn<double> minimumStockLevel =
      GeneratedColumn<double>(
        'minimum_stock_level',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pcs'),
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    categoryId,
    brand,
    modelNumber,
    hp,
    description,
    purchasePrice,
    sellingPrice,
    currentStock,
    minimumStockLevel,
    unit,
    isDeleted,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
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
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('model_number')) {
      context.handle(
        _modelNumberMeta,
        modelNumber.isAcceptableOrUnknown(
          data['model_number']!,
          _modelNumberMeta,
        ),
      );
    }
    if (data.containsKey('hp')) {
      context.handle(_hpMeta, hp.isAcceptableOrUnknown(data['hp']!, _hpMeta));
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
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    }
    if (data.containsKey('selling_price')) {
      context.handle(
        _sellingPriceMeta,
        sellingPrice.isAcceptableOrUnknown(
          data['selling_price']!,
          _sellingPriceMeta,
        ),
      );
    }
    if (data.containsKey('current_stock')) {
      context.handle(
        _currentStockMeta,
        currentStock.isAcceptableOrUnknown(
          data['current_stock']!,
          _currentStockMeta,
        ),
      );
    }
    if (data.containsKey('minimum_stock_level')) {
      context.handle(
        _minimumStockLevelMeta,
        minimumStockLevel.isAcceptableOrUnknown(
          data['minimum_stock_level']!,
          _minimumStockLevelMeta,
        ),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
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
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      modelNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_number'],
      ),
      hp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hp'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      )!,
      sellingPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}selling_price'],
      )!,
      currentStock: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_stock'],
      )!,
      minimumStockLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}minimum_stock_level'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String name;
  final int? categoryId;
  final String? brand;
  final String? modelNumber;
  final String? hp;
  final String? description;
  final double purchasePrice;
  final double sellingPrice;
  final double currentStock;
  final double minimumStockLevel;
  final String unit;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Product({
    required this.id,
    required this.name,
    this.categoryId,
    this.brand,
    this.modelNumber,
    this.hp,
    this.description,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.currentStock,
    required this.minimumStockLevel,
    required this.unit,
    required this.isDeleted,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || modelNumber != null) {
      map['model_number'] = Variable<String>(modelNumber);
    }
    if (!nullToAbsent || hp != null) {
      map['hp'] = Variable<String>(hp);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['purchase_price'] = Variable<double>(purchasePrice);
    map['selling_price'] = Variable<double>(sellingPrice);
    map['current_stock'] = Variable<double>(currentStock);
    map['minimum_stock_level'] = Variable<double>(minimumStockLevel);
    map['unit'] = Variable<String>(unit);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      modelNumber: modelNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(modelNumber),
      hp: hp == null && nullToAbsent ? const Value.absent() : Value(hp),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      purchasePrice: Value(purchasePrice),
      sellingPrice: Value(sellingPrice),
      currentStock: Value(currentStock),
      minimumStockLevel: Value(minimumStockLevel),
      unit: Value(unit),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      brand: serializer.fromJson<String?>(json['brand']),
      modelNumber: serializer.fromJson<String?>(json['modelNumber']),
      hp: serializer.fromJson<String?>(json['hp']),
      description: serializer.fromJson<String?>(json['description']),
      purchasePrice: serializer.fromJson<double>(json['purchasePrice']),
      sellingPrice: serializer.fromJson<double>(json['sellingPrice']),
      currentStock: serializer.fromJson<double>(json['currentStock']),
      minimumStockLevel: serializer.fromJson<double>(json['minimumStockLevel']),
      unit: serializer.fromJson<String>(json['unit']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'categoryId': serializer.toJson<int?>(categoryId),
      'brand': serializer.toJson<String?>(brand),
      'modelNumber': serializer.toJson<String?>(modelNumber),
      'hp': serializer.toJson<String?>(hp),
      'description': serializer.toJson<String?>(description),
      'purchasePrice': serializer.toJson<double>(purchasePrice),
      'sellingPrice': serializer.toJson<double>(sellingPrice),
      'currentStock': serializer.toJson<double>(currentStock),
      'minimumStockLevel': serializer.toJson<double>(minimumStockLevel),
      'unit': serializer.toJson<String>(unit),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Product copyWith({
    int? id,
    String? name,
    Value<int?> categoryId = const Value.absent(),
    Value<String?> brand = const Value.absent(),
    Value<String?> modelNumber = const Value.absent(),
    Value<String?> hp = const Value.absent(),
    Value<String?> description = const Value.absent(),
    double? purchasePrice,
    double? sellingPrice,
    double? currentStock,
    double? minimumStockLevel,
    String? unit,
    bool? isDeleted,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    brand: brand.present ? brand.value : this.brand,
    modelNumber: modelNumber.present ? modelNumber.value : this.modelNumber,
    hp: hp.present ? hp.value : this.hp,
    description: description.present ? description.value : this.description,
    purchasePrice: purchasePrice ?? this.purchasePrice,
    sellingPrice: sellingPrice ?? this.sellingPrice,
    currentStock: currentStock ?? this.currentStock,
    minimumStockLevel: minimumStockLevel ?? this.minimumStockLevel,
    unit: unit ?? this.unit,
    isDeleted: isDeleted ?? this.isDeleted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      brand: data.brand.present ? data.brand.value : this.brand,
      modelNumber: data.modelNumber.present
          ? data.modelNumber.value
          : this.modelNumber,
      hp: data.hp.present ? data.hp.value : this.hp,
      description: data.description.present
          ? data.description.value
          : this.description,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      sellingPrice: data.sellingPrice.present
          ? data.sellingPrice.value
          : this.sellingPrice,
      currentStock: data.currentStock.present
          ? data.currentStock.value
          : this.currentStock,
      minimumStockLevel: data.minimumStockLevel.present
          ? data.minimumStockLevel.value
          : this.minimumStockLevel,
      unit: data.unit.present ? data.unit.value : this.unit,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('brand: $brand, ')
          ..write('modelNumber: $modelNumber, ')
          ..write('hp: $hp, ')
          ..write('description: $description, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('currentStock: $currentStock, ')
          ..write('minimumStockLevel: $minimumStockLevel, ')
          ..write('unit: $unit, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    categoryId,
    brand,
    modelNumber,
    hp,
    description,
    purchasePrice,
    sellingPrice,
    currentStock,
    minimumStockLevel,
    unit,
    isDeleted,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.categoryId == this.categoryId &&
          other.brand == this.brand &&
          other.modelNumber == this.modelNumber &&
          other.hp == this.hp &&
          other.description == this.description &&
          other.purchasePrice == this.purchasePrice &&
          other.sellingPrice == this.sellingPrice &&
          other.currentStock == this.currentStock &&
          other.minimumStockLevel == this.minimumStockLevel &&
          other.unit == this.unit &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> categoryId;
  final Value<String?> brand;
  final Value<String?> modelNumber;
  final Value<String?> hp;
  final Value<String?> description;
  final Value<double> purchasePrice;
  final Value<double> sellingPrice;
  final Value<double> currentStock;
  final Value<double> minimumStockLevel;
  final Value<String> unit;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.brand = const Value.absent(),
    this.modelNumber = const Value.absent(),
    this.hp = const Value.absent(),
    this.description = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.currentStock = const Value.absent(),
    this.minimumStockLevel = const Value.absent(),
    this.unit = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.categoryId = const Value.absent(),
    this.brand = const Value.absent(),
    this.modelNumber = const Value.absent(),
    this.hp = const Value.absent(),
    this.description = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.currentStock = const Value.absent(),
    this.minimumStockLevel = const Value.absent(),
    this.unit = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? categoryId,
    Expression<String>? brand,
    Expression<String>? modelNumber,
    Expression<String>? hp,
    Expression<String>? description,
    Expression<double>? purchasePrice,
    Expression<double>? sellingPrice,
    Expression<double>? currentStock,
    Expression<double>? minimumStockLevel,
    Expression<String>? unit,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (categoryId != null) 'category_id': categoryId,
      if (brand != null) 'brand': brand,
      if (modelNumber != null) 'model_number': modelNumber,
      if (hp != null) 'hp': hp,
      if (description != null) 'description': description,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (sellingPrice != null) 'selling_price': sellingPrice,
      if (currentStock != null) 'current_stock': currentStock,
      if (minimumStockLevel != null) 'minimum_stock_level': minimumStockLevel,
      if (unit != null) 'unit': unit,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int?>? categoryId,
    Value<String?>? brand,
    Value<String?>? modelNumber,
    Value<String?>? hp,
    Value<String?>? description,
    Value<double>? purchasePrice,
    Value<double>? sellingPrice,
    Value<double>? currentStock,
    Value<double>? minimumStockLevel,
    Value<String>? unit,
    Value<bool>? isDeleted,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      brand: brand ?? this.brand,
      modelNumber: modelNumber ?? this.modelNumber,
      hp: hp ?? this.hp,
      description: description ?? this.description,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      currentStock: currentStock ?? this.currentStock,
      minimumStockLevel: minimumStockLevel ?? this.minimumStockLevel,
      unit: unit ?? this.unit,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (modelNumber.present) {
      map['model_number'] = Variable<String>(modelNumber.value);
    }
    if (hp.present) {
      map['hp'] = Variable<String>(hp.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (sellingPrice.present) {
      map['selling_price'] = Variable<double>(sellingPrice.value);
    }
    if (currentStock.present) {
      map['current_stock'] = Variable<double>(currentStock.value);
    }
    if (minimumStockLevel.present) {
      map['minimum_stock_level'] = Variable<double>(minimumStockLevel.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('brand: $brand, ')
          ..write('modelNumber: $modelNumber, ')
          ..write('hp: $hp, ')
          ..write('description: $description, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('currentStock: $currentStock, ')
          ..write('minimumStockLevel: $minimumStockLevel, ')
          ..write('unit: $unit, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RepairJobsTable extends RepairJobs
    with TableInfo<$RepairJobsTable, RepairJob> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepairJobsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _jobNumberMeta = const VerificationMeta(
    'jobNumber',
  );
  @override
  late final GeneratedColumn<String> jobNumber = GeneratedColumn<String>(
    'job_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _customerNameSnapshotMeta =
      const VerificationMeta('customerNameSnapshot');
  @override
  late final GeneratedColumn<String> customerNameSnapshot =
      GeneratedColumn<String>(
        'customer_name_snapshot',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _customerMobileSnapshotMeta =
      const VerificationMeta('customerMobileSnapshot');
  @override
  late final GeneratedColumn<String> customerMobileSnapshot =
      GeneratedColumn<String>(
        'customer_mobile_snapshot',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _motorTypeMeta = const VerificationMeta(
    'motorType',
  );
  @override
  late final GeneratedColumn<String> motorType = GeneratedColumn<String>(
    'motor_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _motorBrandMeta = const VerificationMeta(
    'motorBrand',
  );
  @override
  late final GeneratedColumn<String> motorBrand = GeneratedColumn<String>(
    'motor_brand',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _motorHpMeta = const VerificationMeta(
    'motorHp',
  );
  @override
  late final GeneratedColumn<String> motorHp = GeneratedColumn<String>(
    'motor_hp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _motorPhaseMeta = const VerificationMeta(
    'motorPhase',
  );
  @override
  late final GeneratedColumn<String> motorPhase = GeneratedColumn<String>(
    'motor_phase',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _motorVoltageMeta = const VerificationMeta(
    'motorVoltage',
  );
  @override
  late final GeneratedColumn<String> motorVoltage = GeneratedColumn<String>(
    'motor_voltage',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _motorSerialNumberMeta = const VerificationMeta(
    'motorSerialNumber',
  );
  @override
  late final GeneratedColumn<String> motorSerialNumber =
      GeneratedColumn<String>(
        'motor_serial_number',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _problemDescriptionMeta =
      const VerificationMeta('problemDescription');
  @override
  late final GeneratedColumn<String> problemDescription =
      GeneratedColumn<String>(
        'problem_description',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _workDescriptionMeta = const VerificationMeta(
    'workDescription',
  );
  @override
  late final GeneratedColumn<String> workDescription = GeneratedColumn<String>(
    'work_description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labourChargesMeta = const VerificationMeta(
    'labourCharges',
  );
  @override
  late final GeneratedColumn<double> labourCharges = GeneratedColumn<double>(
    'labour_charges',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _materialChargesMeta = const VerificationMeta(
    'materialCharges',
  );
  @override
  late final GeneratedColumn<double> materialCharges = GeneratedColumn<double>(
    'material_charges',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _otherChargesMeta = const VerificationMeta(
    'otherCharges',
  );
  @override
  late final GeneratedColumn<double> otherCharges = GeneratedColumn<double>(
    'other_charges',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _finalAmountMeta = const VerificationMeta(
    'finalAmount',
  );
  @override
  late final GeneratedColumn<double> finalAmount = GeneratedColumn<double>(
    'final_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _advancePaymentMeta = const VerificationMeta(
    'advancePayment',
  );
  @override
  late final GeneratedColumn<double> advancePayment = GeneratedColumn<double>(
    'advance_payment',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _remainingAmountMeta = const VerificationMeta(
    'remainingAmount',
  );
  @override
  late final GeneratedColumn<double> remainingAmount = GeneratedColumn<double>(
    'remaining_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _jobStatusMeta = const VerificationMeta(
    'jobStatus',
  );
  @override
  late final GeneratedColumn<String> jobStatus = GeneratedColumn<String>(
    'job_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('received'),
  );
  static const VerificationMeta _receivedDateMeta = const VerificationMeta(
    'receivedDate',
  );
  @override
  late final GeneratedColumn<DateTime> receivedDate = GeneratedColumn<DateTime>(
    'received_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _expectedDeliveryDateMeta =
      const VerificationMeta('expectedDeliveryDate');
  @override
  late final GeneratedColumn<DateTime> expectedDeliveryDate =
      GeneratedColumn<DateTime>(
        'expected_delivery_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _deliveryDateMeta = const VerificationMeta(
    'deliveryDate',
  );
  @override
  late final GeneratedColumn<DateTime> deliveryDate = GeneratedColumn<DateTime>(
    'delivery_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _warrantyInfoMeta = const VerificationMeta(
    'warrantyInfo',
  );
  @override
  late final GeneratedColumn<String> warrantyInfo = GeneratedColumn<String>(
    'warranty_info',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    jobNumber,
    customerId,
    customerNameSnapshot,
    customerMobileSnapshot,
    motorType,
    motorBrand,
    motorHp,
    motorPhase,
    motorVoltage,
    motorSerialNumber,
    problemDescription,
    workDescription,
    labourCharges,
    materialCharges,
    otherCharges,
    discount,
    finalAmount,
    advancePayment,
    remainingAmount,
    jobStatus,
    receivedDate,
    expectedDeliveryDate,
    deliveryDate,
    warrantyInfo,
    notes,
    isDeleted,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repair_jobs';
  @override
  VerificationContext validateIntegrity(
    Insertable<RepairJob> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('job_number')) {
      context.handle(
        _jobNumberMeta,
        jobNumber.isAcceptableOrUnknown(data['job_number']!, _jobNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_jobNumberMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('customer_name_snapshot')) {
      context.handle(
        _customerNameSnapshotMeta,
        customerNameSnapshot.isAcceptableOrUnknown(
          data['customer_name_snapshot']!,
          _customerNameSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('customer_mobile_snapshot')) {
      context.handle(
        _customerMobileSnapshotMeta,
        customerMobileSnapshot.isAcceptableOrUnknown(
          data['customer_mobile_snapshot']!,
          _customerMobileSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('motor_type')) {
      context.handle(
        _motorTypeMeta,
        motorType.isAcceptableOrUnknown(data['motor_type']!, _motorTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_motorTypeMeta);
    }
    if (data.containsKey('motor_brand')) {
      context.handle(
        _motorBrandMeta,
        motorBrand.isAcceptableOrUnknown(data['motor_brand']!, _motorBrandMeta),
      );
    } else if (isInserting) {
      context.missing(_motorBrandMeta);
    }
    if (data.containsKey('motor_hp')) {
      context.handle(
        _motorHpMeta,
        motorHp.isAcceptableOrUnknown(data['motor_hp']!, _motorHpMeta),
      );
    } else if (isInserting) {
      context.missing(_motorHpMeta);
    }
    if (data.containsKey('motor_phase')) {
      context.handle(
        _motorPhaseMeta,
        motorPhase.isAcceptableOrUnknown(data['motor_phase']!, _motorPhaseMeta),
      );
    } else if (isInserting) {
      context.missing(_motorPhaseMeta);
    }
    if (data.containsKey('motor_voltage')) {
      context.handle(
        _motorVoltageMeta,
        motorVoltage.isAcceptableOrUnknown(
          data['motor_voltage']!,
          _motorVoltageMeta,
        ),
      );
    }
    if (data.containsKey('motor_serial_number')) {
      context.handle(
        _motorSerialNumberMeta,
        motorSerialNumber.isAcceptableOrUnknown(
          data['motor_serial_number']!,
          _motorSerialNumberMeta,
        ),
      );
    }
    if (data.containsKey('problem_description')) {
      context.handle(
        _problemDescriptionMeta,
        problemDescription.isAcceptableOrUnknown(
          data['problem_description']!,
          _problemDescriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_problemDescriptionMeta);
    }
    if (data.containsKey('work_description')) {
      context.handle(
        _workDescriptionMeta,
        workDescription.isAcceptableOrUnknown(
          data['work_description']!,
          _workDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('labour_charges')) {
      context.handle(
        _labourChargesMeta,
        labourCharges.isAcceptableOrUnknown(
          data['labour_charges']!,
          _labourChargesMeta,
        ),
      );
    }
    if (data.containsKey('material_charges')) {
      context.handle(
        _materialChargesMeta,
        materialCharges.isAcceptableOrUnknown(
          data['material_charges']!,
          _materialChargesMeta,
        ),
      );
    }
    if (data.containsKey('other_charges')) {
      context.handle(
        _otherChargesMeta,
        otherCharges.isAcceptableOrUnknown(
          data['other_charges']!,
          _otherChargesMeta,
        ),
      );
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    }
    if (data.containsKey('final_amount')) {
      context.handle(
        _finalAmountMeta,
        finalAmount.isAcceptableOrUnknown(
          data['final_amount']!,
          _finalAmountMeta,
        ),
      );
    }
    if (data.containsKey('advance_payment')) {
      context.handle(
        _advancePaymentMeta,
        advancePayment.isAcceptableOrUnknown(
          data['advance_payment']!,
          _advancePaymentMeta,
        ),
      );
    }
    if (data.containsKey('remaining_amount')) {
      context.handle(
        _remainingAmountMeta,
        remainingAmount.isAcceptableOrUnknown(
          data['remaining_amount']!,
          _remainingAmountMeta,
        ),
      );
    }
    if (data.containsKey('job_status')) {
      context.handle(
        _jobStatusMeta,
        jobStatus.isAcceptableOrUnknown(data['job_status']!, _jobStatusMeta),
      );
    }
    if (data.containsKey('received_date')) {
      context.handle(
        _receivedDateMeta,
        receivedDate.isAcceptableOrUnknown(
          data['received_date']!,
          _receivedDateMeta,
        ),
      );
    }
    if (data.containsKey('expected_delivery_date')) {
      context.handle(
        _expectedDeliveryDateMeta,
        expectedDeliveryDate.isAcceptableOrUnknown(
          data['expected_delivery_date']!,
          _expectedDeliveryDateMeta,
        ),
      );
    }
    if (data.containsKey('delivery_date')) {
      context.handle(
        _deliveryDateMeta,
        deliveryDate.isAcceptableOrUnknown(
          data['delivery_date']!,
          _deliveryDateMeta,
        ),
      );
    }
    if (data.containsKey('warranty_info')) {
      context.handle(
        _warrantyInfoMeta,
        warrantyInfo.isAcceptableOrUnknown(
          data['warranty_info']!,
          _warrantyInfoMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RepairJob map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepairJob(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jobNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_number'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      )!,
      customerNameSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name_snapshot'],
      ),
      customerMobileSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_mobile_snapshot'],
      ),
      motorType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motor_type'],
      )!,
      motorBrand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motor_brand'],
      )!,
      motorHp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motor_hp'],
      )!,
      motorPhase: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motor_phase'],
      )!,
      motorVoltage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motor_voltage'],
      ),
      motorSerialNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motor_serial_number'],
      ),
      problemDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}problem_description'],
      )!,
      workDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_description'],
      ),
      labourCharges: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}labour_charges'],
      )!,
      materialCharges: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}material_charges'],
      )!,
      otherCharges: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}other_charges'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount'],
      )!,
      finalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}final_amount'],
      )!,
      advancePayment: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}advance_payment'],
      )!,
      remainingAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}remaining_amount'],
      )!,
      jobStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_status'],
      )!,
      receivedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_date'],
      )!,
      expectedDeliveryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expected_delivery_date'],
      ),
      deliveryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}delivery_date'],
      ),
      warrantyInfo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warranty_info'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $RepairJobsTable createAlias(String alias) {
    return $RepairJobsTable(attachedDatabase, alias);
  }
}

class RepairJob extends DataClass implements Insertable<RepairJob> {
  final int id;
  final String jobNumber;
  final int customerId;
  final String? customerNameSnapshot;
  final String? customerMobileSnapshot;
  final String motorType;
  final String motorBrand;
  final String motorHp;
  final String motorPhase;
  final String? motorVoltage;
  final String? motorSerialNumber;
  final String problemDescription;
  final String? workDescription;
  final double labourCharges;
  final double materialCharges;
  final double otherCharges;
  final double discount;
  final double finalAmount;
  final double advancePayment;
  final double remainingAmount;
  final String jobStatus;
  final DateTime receivedDate;
  final DateTime? expectedDeliveryDate;
  final DateTime? deliveryDate;
  final String? warrantyInfo;
  final String? notes;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const RepairJob({
    required this.id,
    required this.jobNumber,
    required this.customerId,
    this.customerNameSnapshot,
    this.customerMobileSnapshot,
    required this.motorType,
    required this.motorBrand,
    required this.motorHp,
    required this.motorPhase,
    this.motorVoltage,
    this.motorSerialNumber,
    required this.problemDescription,
    this.workDescription,
    required this.labourCharges,
    required this.materialCharges,
    required this.otherCharges,
    required this.discount,
    required this.finalAmount,
    required this.advancePayment,
    required this.remainingAmount,
    required this.jobStatus,
    required this.receivedDate,
    this.expectedDeliveryDate,
    this.deliveryDate,
    this.warrantyInfo,
    this.notes,
    required this.isDeleted,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['job_number'] = Variable<String>(jobNumber);
    map['customer_id'] = Variable<int>(customerId);
    if (!nullToAbsent || customerNameSnapshot != null) {
      map['customer_name_snapshot'] = Variable<String>(customerNameSnapshot);
    }
    if (!nullToAbsent || customerMobileSnapshot != null) {
      map['customer_mobile_snapshot'] = Variable<String>(
        customerMobileSnapshot,
      );
    }
    map['motor_type'] = Variable<String>(motorType);
    map['motor_brand'] = Variable<String>(motorBrand);
    map['motor_hp'] = Variable<String>(motorHp);
    map['motor_phase'] = Variable<String>(motorPhase);
    if (!nullToAbsent || motorVoltage != null) {
      map['motor_voltage'] = Variable<String>(motorVoltage);
    }
    if (!nullToAbsent || motorSerialNumber != null) {
      map['motor_serial_number'] = Variable<String>(motorSerialNumber);
    }
    map['problem_description'] = Variable<String>(problemDescription);
    if (!nullToAbsent || workDescription != null) {
      map['work_description'] = Variable<String>(workDescription);
    }
    map['labour_charges'] = Variable<double>(labourCharges);
    map['material_charges'] = Variable<double>(materialCharges);
    map['other_charges'] = Variable<double>(otherCharges);
    map['discount'] = Variable<double>(discount);
    map['final_amount'] = Variable<double>(finalAmount);
    map['advance_payment'] = Variable<double>(advancePayment);
    map['remaining_amount'] = Variable<double>(remainingAmount);
    map['job_status'] = Variable<String>(jobStatus);
    map['received_date'] = Variable<DateTime>(receivedDate);
    if (!nullToAbsent || expectedDeliveryDate != null) {
      map['expected_delivery_date'] = Variable<DateTime>(expectedDeliveryDate);
    }
    if (!nullToAbsent || deliveryDate != null) {
      map['delivery_date'] = Variable<DateTime>(deliveryDate);
    }
    if (!nullToAbsent || warrantyInfo != null) {
      map['warranty_info'] = Variable<String>(warrantyInfo);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  RepairJobsCompanion toCompanion(bool nullToAbsent) {
    return RepairJobsCompanion(
      id: Value(id),
      jobNumber: Value(jobNumber),
      customerId: Value(customerId),
      customerNameSnapshot: customerNameSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(customerNameSnapshot),
      customerMobileSnapshot: customerMobileSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(customerMobileSnapshot),
      motorType: Value(motorType),
      motorBrand: Value(motorBrand),
      motorHp: Value(motorHp),
      motorPhase: Value(motorPhase),
      motorVoltage: motorVoltage == null && nullToAbsent
          ? const Value.absent()
          : Value(motorVoltage),
      motorSerialNumber: motorSerialNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(motorSerialNumber),
      problemDescription: Value(problemDescription),
      workDescription: workDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(workDescription),
      labourCharges: Value(labourCharges),
      materialCharges: Value(materialCharges),
      otherCharges: Value(otherCharges),
      discount: Value(discount),
      finalAmount: Value(finalAmount),
      advancePayment: Value(advancePayment),
      remainingAmount: Value(remainingAmount),
      jobStatus: Value(jobStatus),
      receivedDate: Value(receivedDate),
      expectedDeliveryDate: expectedDeliveryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedDeliveryDate),
      deliveryDate: deliveryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryDate),
      warrantyInfo: warrantyInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(warrantyInfo),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory RepairJob.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepairJob(
      id: serializer.fromJson<int>(json['id']),
      jobNumber: serializer.fromJson<String>(json['jobNumber']),
      customerId: serializer.fromJson<int>(json['customerId']),
      customerNameSnapshot: serializer.fromJson<String?>(
        json['customerNameSnapshot'],
      ),
      customerMobileSnapshot: serializer.fromJson<String?>(
        json['customerMobileSnapshot'],
      ),
      motorType: serializer.fromJson<String>(json['motorType']),
      motorBrand: serializer.fromJson<String>(json['motorBrand']),
      motorHp: serializer.fromJson<String>(json['motorHp']),
      motorPhase: serializer.fromJson<String>(json['motorPhase']),
      motorVoltage: serializer.fromJson<String?>(json['motorVoltage']),
      motorSerialNumber: serializer.fromJson<String?>(
        json['motorSerialNumber'],
      ),
      problemDescription: serializer.fromJson<String>(
        json['problemDescription'],
      ),
      workDescription: serializer.fromJson<String?>(json['workDescription']),
      labourCharges: serializer.fromJson<double>(json['labourCharges']),
      materialCharges: serializer.fromJson<double>(json['materialCharges']),
      otherCharges: serializer.fromJson<double>(json['otherCharges']),
      discount: serializer.fromJson<double>(json['discount']),
      finalAmount: serializer.fromJson<double>(json['finalAmount']),
      advancePayment: serializer.fromJson<double>(json['advancePayment']),
      remainingAmount: serializer.fromJson<double>(json['remainingAmount']),
      jobStatus: serializer.fromJson<String>(json['jobStatus']),
      receivedDate: serializer.fromJson<DateTime>(json['receivedDate']),
      expectedDeliveryDate: serializer.fromJson<DateTime?>(
        json['expectedDeliveryDate'],
      ),
      deliveryDate: serializer.fromJson<DateTime?>(json['deliveryDate']),
      warrantyInfo: serializer.fromJson<String?>(json['warrantyInfo']),
      notes: serializer.fromJson<String?>(json['notes']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jobNumber': serializer.toJson<String>(jobNumber),
      'customerId': serializer.toJson<int>(customerId),
      'customerNameSnapshot': serializer.toJson<String?>(customerNameSnapshot),
      'customerMobileSnapshot': serializer.toJson<String?>(
        customerMobileSnapshot,
      ),
      'motorType': serializer.toJson<String>(motorType),
      'motorBrand': serializer.toJson<String>(motorBrand),
      'motorHp': serializer.toJson<String>(motorHp),
      'motorPhase': serializer.toJson<String>(motorPhase),
      'motorVoltage': serializer.toJson<String?>(motorVoltage),
      'motorSerialNumber': serializer.toJson<String?>(motorSerialNumber),
      'problemDescription': serializer.toJson<String>(problemDescription),
      'workDescription': serializer.toJson<String?>(workDescription),
      'labourCharges': serializer.toJson<double>(labourCharges),
      'materialCharges': serializer.toJson<double>(materialCharges),
      'otherCharges': serializer.toJson<double>(otherCharges),
      'discount': serializer.toJson<double>(discount),
      'finalAmount': serializer.toJson<double>(finalAmount),
      'advancePayment': serializer.toJson<double>(advancePayment),
      'remainingAmount': serializer.toJson<double>(remainingAmount),
      'jobStatus': serializer.toJson<String>(jobStatus),
      'receivedDate': serializer.toJson<DateTime>(receivedDate),
      'expectedDeliveryDate': serializer.toJson<DateTime?>(
        expectedDeliveryDate,
      ),
      'deliveryDate': serializer.toJson<DateTime?>(deliveryDate),
      'warrantyInfo': serializer.toJson<String?>(warrantyInfo),
      'notes': serializer.toJson<String?>(notes),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  RepairJob copyWith({
    int? id,
    String? jobNumber,
    int? customerId,
    Value<String?> customerNameSnapshot = const Value.absent(),
    Value<String?> customerMobileSnapshot = const Value.absent(),
    String? motorType,
    String? motorBrand,
    String? motorHp,
    String? motorPhase,
    Value<String?> motorVoltage = const Value.absent(),
    Value<String?> motorSerialNumber = const Value.absent(),
    String? problemDescription,
    Value<String?> workDescription = const Value.absent(),
    double? labourCharges,
    double? materialCharges,
    double? otherCharges,
    double? discount,
    double? finalAmount,
    double? advancePayment,
    double? remainingAmount,
    String? jobStatus,
    DateTime? receivedDate,
    Value<DateTime?> expectedDeliveryDate = const Value.absent(),
    Value<DateTime?> deliveryDate = const Value.absent(),
    Value<String?> warrantyInfo = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isDeleted,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => RepairJob(
    id: id ?? this.id,
    jobNumber: jobNumber ?? this.jobNumber,
    customerId: customerId ?? this.customerId,
    customerNameSnapshot: customerNameSnapshot.present
        ? customerNameSnapshot.value
        : this.customerNameSnapshot,
    customerMobileSnapshot: customerMobileSnapshot.present
        ? customerMobileSnapshot.value
        : this.customerMobileSnapshot,
    motorType: motorType ?? this.motorType,
    motorBrand: motorBrand ?? this.motorBrand,
    motorHp: motorHp ?? this.motorHp,
    motorPhase: motorPhase ?? this.motorPhase,
    motorVoltage: motorVoltage.present ? motorVoltage.value : this.motorVoltage,
    motorSerialNumber: motorSerialNumber.present
        ? motorSerialNumber.value
        : this.motorSerialNumber,
    problemDescription: problemDescription ?? this.problemDescription,
    workDescription: workDescription.present
        ? workDescription.value
        : this.workDescription,
    labourCharges: labourCharges ?? this.labourCharges,
    materialCharges: materialCharges ?? this.materialCharges,
    otherCharges: otherCharges ?? this.otherCharges,
    discount: discount ?? this.discount,
    finalAmount: finalAmount ?? this.finalAmount,
    advancePayment: advancePayment ?? this.advancePayment,
    remainingAmount: remainingAmount ?? this.remainingAmount,
    jobStatus: jobStatus ?? this.jobStatus,
    receivedDate: receivedDate ?? this.receivedDate,
    expectedDeliveryDate: expectedDeliveryDate.present
        ? expectedDeliveryDate.value
        : this.expectedDeliveryDate,
    deliveryDate: deliveryDate.present ? deliveryDate.value : this.deliveryDate,
    warrantyInfo: warrantyInfo.present ? warrantyInfo.value : this.warrantyInfo,
    notes: notes.present ? notes.value : this.notes,
    isDeleted: isDeleted ?? this.isDeleted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  RepairJob copyWithCompanion(RepairJobsCompanion data) {
    return RepairJob(
      id: data.id.present ? data.id.value : this.id,
      jobNumber: data.jobNumber.present ? data.jobNumber.value : this.jobNumber,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      customerNameSnapshot: data.customerNameSnapshot.present
          ? data.customerNameSnapshot.value
          : this.customerNameSnapshot,
      customerMobileSnapshot: data.customerMobileSnapshot.present
          ? data.customerMobileSnapshot.value
          : this.customerMobileSnapshot,
      motorType: data.motorType.present ? data.motorType.value : this.motorType,
      motorBrand: data.motorBrand.present
          ? data.motorBrand.value
          : this.motorBrand,
      motorHp: data.motorHp.present ? data.motorHp.value : this.motorHp,
      motorPhase: data.motorPhase.present
          ? data.motorPhase.value
          : this.motorPhase,
      motorVoltage: data.motorVoltage.present
          ? data.motorVoltage.value
          : this.motorVoltage,
      motorSerialNumber: data.motorSerialNumber.present
          ? data.motorSerialNumber.value
          : this.motorSerialNumber,
      problemDescription: data.problemDescription.present
          ? data.problemDescription.value
          : this.problemDescription,
      workDescription: data.workDescription.present
          ? data.workDescription.value
          : this.workDescription,
      labourCharges: data.labourCharges.present
          ? data.labourCharges.value
          : this.labourCharges,
      materialCharges: data.materialCharges.present
          ? data.materialCharges.value
          : this.materialCharges,
      otherCharges: data.otherCharges.present
          ? data.otherCharges.value
          : this.otherCharges,
      discount: data.discount.present ? data.discount.value : this.discount,
      finalAmount: data.finalAmount.present
          ? data.finalAmount.value
          : this.finalAmount,
      advancePayment: data.advancePayment.present
          ? data.advancePayment.value
          : this.advancePayment,
      remainingAmount: data.remainingAmount.present
          ? data.remainingAmount.value
          : this.remainingAmount,
      jobStatus: data.jobStatus.present ? data.jobStatus.value : this.jobStatus,
      receivedDate: data.receivedDate.present
          ? data.receivedDate.value
          : this.receivedDate,
      expectedDeliveryDate: data.expectedDeliveryDate.present
          ? data.expectedDeliveryDate.value
          : this.expectedDeliveryDate,
      deliveryDate: data.deliveryDate.present
          ? data.deliveryDate.value
          : this.deliveryDate,
      warrantyInfo: data.warrantyInfo.present
          ? data.warrantyInfo.value
          : this.warrantyInfo,
      notes: data.notes.present ? data.notes.value : this.notes,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepairJob(')
          ..write('id: $id, ')
          ..write('jobNumber: $jobNumber, ')
          ..write('customerId: $customerId, ')
          ..write('customerNameSnapshot: $customerNameSnapshot, ')
          ..write('customerMobileSnapshot: $customerMobileSnapshot, ')
          ..write('motorType: $motorType, ')
          ..write('motorBrand: $motorBrand, ')
          ..write('motorHp: $motorHp, ')
          ..write('motorPhase: $motorPhase, ')
          ..write('motorVoltage: $motorVoltage, ')
          ..write('motorSerialNumber: $motorSerialNumber, ')
          ..write('problemDescription: $problemDescription, ')
          ..write('workDescription: $workDescription, ')
          ..write('labourCharges: $labourCharges, ')
          ..write('materialCharges: $materialCharges, ')
          ..write('otherCharges: $otherCharges, ')
          ..write('discount: $discount, ')
          ..write('finalAmount: $finalAmount, ')
          ..write('advancePayment: $advancePayment, ')
          ..write('remainingAmount: $remainingAmount, ')
          ..write('jobStatus: $jobStatus, ')
          ..write('receivedDate: $receivedDate, ')
          ..write('expectedDeliveryDate: $expectedDeliveryDate, ')
          ..write('deliveryDate: $deliveryDate, ')
          ..write('warrantyInfo: $warrantyInfo, ')
          ..write('notes: $notes, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    jobNumber,
    customerId,
    customerNameSnapshot,
    customerMobileSnapshot,
    motorType,
    motorBrand,
    motorHp,
    motorPhase,
    motorVoltage,
    motorSerialNumber,
    problemDescription,
    workDescription,
    labourCharges,
    materialCharges,
    otherCharges,
    discount,
    finalAmount,
    advancePayment,
    remainingAmount,
    jobStatus,
    receivedDate,
    expectedDeliveryDate,
    deliveryDate,
    warrantyInfo,
    notes,
    isDeleted,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepairJob &&
          other.id == this.id &&
          other.jobNumber == this.jobNumber &&
          other.customerId == this.customerId &&
          other.customerNameSnapshot == this.customerNameSnapshot &&
          other.customerMobileSnapshot == this.customerMobileSnapshot &&
          other.motorType == this.motorType &&
          other.motorBrand == this.motorBrand &&
          other.motorHp == this.motorHp &&
          other.motorPhase == this.motorPhase &&
          other.motorVoltage == this.motorVoltage &&
          other.motorSerialNumber == this.motorSerialNumber &&
          other.problemDescription == this.problemDescription &&
          other.workDescription == this.workDescription &&
          other.labourCharges == this.labourCharges &&
          other.materialCharges == this.materialCharges &&
          other.otherCharges == this.otherCharges &&
          other.discount == this.discount &&
          other.finalAmount == this.finalAmount &&
          other.advancePayment == this.advancePayment &&
          other.remainingAmount == this.remainingAmount &&
          other.jobStatus == this.jobStatus &&
          other.receivedDate == this.receivedDate &&
          other.expectedDeliveryDate == this.expectedDeliveryDate &&
          other.deliveryDate == this.deliveryDate &&
          other.warrantyInfo == this.warrantyInfo &&
          other.notes == this.notes &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RepairJobsCompanion extends UpdateCompanion<RepairJob> {
  final Value<int> id;
  final Value<String> jobNumber;
  final Value<int> customerId;
  final Value<String?> customerNameSnapshot;
  final Value<String?> customerMobileSnapshot;
  final Value<String> motorType;
  final Value<String> motorBrand;
  final Value<String> motorHp;
  final Value<String> motorPhase;
  final Value<String?> motorVoltage;
  final Value<String?> motorSerialNumber;
  final Value<String> problemDescription;
  final Value<String?> workDescription;
  final Value<double> labourCharges;
  final Value<double> materialCharges;
  final Value<double> otherCharges;
  final Value<double> discount;
  final Value<double> finalAmount;
  final Value<double> advancePayment;
  final Value<double> remainingAmount;
  final Value<String> jobStatus;
  final Value<DateTime> receivedDate;
  final Value<DateTime?> expectedDeliveryDate;
  final Value<DateTime?> deliveryDate;
  final Value<String?> warrantyInfo;
  final Value<String?> notes;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const RepairJobsCompanion({
    this.id = const Value.absent(),
    this.jobNumber = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerNameSnapshot = const Value.absent(),
    this.customerMobileSnapshot = const Value.absent(),
    this.motorType = const Value.absent(),
    this.motorBrand = const Value.absent(),
    this.motorHp = const Value.absent(),
    this.motorPhase = const Value.absent(),
    this.motorVoltage = const Value.absent(),
    this.motorSerialNumber = const Value.absent(),
    this.problemDescription = const Value.absent(),
    this.workDescription = const Value.absent(),
    this.labourCharges = const Value.absent(),
    this.materialCharges = const Value.absent(),
    this.otherCharges = const Value.absent(),
    this.discount = const Value.absent(),
    this.finalAmount = const Value.absent(),
    this.advancePayment = const Value.absent(),
    this.remainingAmount = const Value.absent(),
    this.jobStatus = const Value.absent(),
    this.receivedDate = const Value.absent(),
    this.expectedDeliveryDate = const Value.absent(),
    this.deliveryDate = const Value.absent(),
    this.warrantyInfo = const Value.absent(),
    this.notes = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RepairJobsCompanion.insert({
    this.id = const Value.absent(),
    required String jobNumber,
    required int customerId,
    this.customerNameSnapshot = const Value.absent(),
    this.customerMobileSnapshot = const Value.absent(),
    required String motorType,
    required String motorBrand,
    required String motorHp,
    required String motorPhase,
    this.motorVoltage = const Value.absent(),
    this.motorSerialNumber = const Value.absent(),
    required String problemDescription,
    this.workDescription = const Value.absent(),
    this.labourCharges = const Value.absent(),
    this.materialCharges = const Value.absent(),
    this.otherCharges = const Value.absent(),
    this.discount = const Value.absent(),
    this.finalAmount = const Value.absent(),
    this.advancePayment = const Value.absent(),
    this.remainingAmount = const Value.absent(),
    this.jobStatus = const Value.absent(),
    this.receivedDate = const Value.absent(),
    this.expectedDeliveryDate = const Value.absent(),
    this.deliveryDate = const Value.absent(),
    this.warrantyInfo = const Value.absent(),
    this.notes = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : jobNumber = Value(jobNumber),
       customerId = Value(customerId),
       motorType = Value(motorType),
       motorBrand = Value(motorBrand),
       motorHp = Value(motorHp),
       motorPhase = Value(motorPhase),
       problemDescription = Value(problemDescription);
  static Insertable<RepairJob> custom({
    Expression<int>? id,
    Expression<String>? jobNumber,
    Expression<int>? customerId,
    Expression<String>? customerNameSnapshot,
    Expression<String>? customerMobileSnapshot,
    Expression<String>? motorType,
    Expression<String>? motorBrand,
    Expression<String>? motorHp,
    Expression<String>? motorPhase,
    Expression<String>? motorVoltage,
    Expression<String>? motorSerialNumber,
    Expression<String>? problemDescription,
    Expression<String>? workDescription,
    Expression<double>? labourCharges,
    Expression<double>? materialCharges,
    Expression<double>? otherCharges,
    Expression<double>? discount,
    Expression<double>? finalAmount,
    Expression<double>? advancePayment,
    Expression<double>? remainingAmount,
    Expression<String>? jobStatus,
    Expression<DateTime>? receivedDate,
    Expression<DateTime>? expectedDeliveryDate,
    Expression<DateTime>? deliveryDate,
    Expression<String>? warrantyInfo,
    Expression<String>? notes,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jobNumber != null) 'job_number': jobNumber,
      if (customerId != null) 'customer_id': customerId,
      if (customerNameSnapshot != null)
        'customer_name_snapshot': customerNameSnapshot,
      if (customerMobileSnapshot != null)
        'customer_mobile_snapshot': customerMobileSnapshot,
      if (motorType != null) 'motor_type': motorType,
      if (motorBrand != null) 'motor_brand': motorBrand,
      if (motorHp != null) 'motor_hp': motorHp,
      if (motorPhase != null) 'motor_phase': motorPhase,
      if (motorVoltage != null) 'motor_voltage': motorVoltage,
      if (motorSerialNumber != null) 'motor_serial_number': motorSerialNumber,
      if (problemDescription != null) 'problem_description': problemDescription,
      if (workDescription != null) 'work_description': workDescription,
      if (labourCharges != null) 'labour_charges': labourCharges,
      if (materialCharges != null) 'material_charges': materialCharges,
      if (otherCharges != null) 'other_charges': otherCharges,
      if (discount != null) 'discount': discount,
      if (finalAmount != null) 'final_amount': finalAmount,
      if (advancePayment != null) 'advance_payment': advancePayment,
      if (remainingAmount != null) 'remaining_amount': remainingAmount,
      if (jobStatus != null) 'job_status': jobStatus,
      if (receivedDate != null) 'received_date': receivedDate,
      if (expectedDeliveryDate != null)
        'expected_delivery_date': expectedDeliveryDate,
      if (deliveryDate != null) 'delivery_date': deliveryDate,
      if (warrantyInfo != null) 'warranty_info': warrantyInfo,
      if (notes != null) 'notes': notes,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RepairJobsCompanion copyWith({
    Value<int>? id,
    Value<String>? jobNumber,
    Value<int>? customerId,
    Value<String?>? customerNameSnapshot,
    Value<String?>? customerMobileSnapshot,
    Value<String>? motorType,
    Value<String>? motorBrand,
    Value<String>? motorHp,
    Value<String>? motorPhase,
    Value<String?>? motorVoltage,
    Value<String?>? motorSerialNumber,
    Value<String>? problemDescription,
    Value<String?>? workDescription,
    Value<double>? labourCharges,
    Value<double>? materialCharges,
    Value<double>? otherCharges,
    Value<double>? discount,
    Value<double>? finalAmount,
    Value<double>? advancePayment,
    Value<double>? remainingAmount,
    Value<String>? jobStatus,
    Value<DateTime>? receivedDate,
    Value<DateTime?>? expectedDeliveryDate,
    Value<DateTime?>? deliveryDate,
    Value<String?>? warrantyInfo,
    Value<String?>? notes,
    Value<bool>? isDeleted,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return RepairJobsCompanion(
      id: id ?? this.id,
      jobNumber: jobNumber ?? this.jobNumber,
      customerId: customerId ?? this.customerId,
      customerNameSnapshot: customerNameSnapshot ?? this.customerNameSnapshot,
      customerMobileSnapshot:
          customerMobileSnapshot ?? this.customerMobileSnapshot,
      motorType: motorType ?? this.motorType,
      motorBrand: motorBrand ?? this.motorBrand,
      motorHp: motorHp ?? this.motorHp,
      motorPhase: motorPhase ?? this.motorPhase,
      motorVoltage: motorVoltage ?? this.motorVoltage,
      motorSerialNumber: motorSerialNumber ?? this.motorSerialNumber,
      problemDescription: problemDescription ?? this.problemDescription,
      workDescription: workDescription ?? this.workDescription,
      labourCharges: labourCharges ?? this.labourCharges,
      materialCharges: materialCharges ?? this.materialCharges,
      otherCharges: otherCharges ?? this.otherCharges,
      discount: discount ?? this.discount,
      finalAmount: finalAmount ?? this.finalAmount,
      advancePayment: advancePayment ?? this.advancePayment,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      jobStatus: jobStatus ?? this.jobStatus,
      receivedDate: receivedDate ?? this.receivedDate,
      expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      warrantyInfo: warrantyInfo ?? this.warrantyInfo,
      notes: notes ?? this.notes,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jobNumber.present) {
      map['job_number'] = Variable<String>(jobNumber.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (customerNameSnapshot.present) {
      map['customer_name_snapshot'] = Variable<String>(
        customerNameSnapshot.value,
      );
    }
    if (customerMobileSnapshot.present) {
      map['customer_mobile_snapshot'] = Variable<String>(
        customerMobileSnapshot.value,
      );
    }
    if (motorType.present) {
      map['motor_type'] = Variable<String>(motorType.value);
    }
    if (motorBrand.present) {
      map['motor_brand'] = Variable<String>(motorBrand.value);
    }
    if (motorHp.present) {
      map['motor_hp'] = Variable<String>(motorHp.value);
    }
    if (motorPhase.present) {
      map['motor_phase'] = Variable<String>(motorPhase.value);
    }
    if (motorVoltage.present) {
      map['motor_voltage'] = Variable<String>(motorVoltage.value);
    }
    if (motorSerialNumber.present) {
      map['motor_serial_number'] = Variable<String>(motorSerialNumber.value);
    }
    if (problemDescription.present) {
      map['problem_description'] = Variable<String>(problemDescription.value);
    }
    if (workDescription.present) {
      map['work_description'] = Variable<String>(workDescription.value);
    }
    if (labourCharges.present) {
      map['labour_charges'] = Variable<double>(labourCharges.value);
    }
    if (materialCharges.present) {
      map['material_charges'] = Variable<double>(materialCharges.value);
    }
    if (otherCharges.present) {
      map['other_charges'] = Variable<double>(otherCharges.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (finalAmount.present) {
      map['final_amount'] = Variable<double>(finalAmount.value);
    }
    if (advancePayment.present) {
      map['advance_payment'] = Variable<double>(advancePayment.value);
    }
    if (remainingAmount.present) {
      map['remaining_amount'] = Variable<double>(remainingAmount.value);
    }
    if (jobStatus.present) {
      map['job_status'] = Variable<String>(jobStatus.value);
    }
    if (receivedDate.present) {
      map['received_date'] = Variable<DateTime>(receivedDate.value);
    }
    if (expectedDeliveryDate.present) {
      map['expected_delivery_date'] = Variable<DateTime>(
        expectedDeliveryDate.value,
      );
    }
    if (deliveryDate.present) {
      map['delivery_date'] = Variable<DateTime>(deliveryDate.value);
    }
    if (warrantyInfo.present) {
      map['warranty_info'] = Variable<String>(warrantyInfo.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepairJobsCompanion(')
          ..write('id: $id, ')
          ..write('jobNumber: $jobNumber, ')
          ..write('customerId: $customerId, ')
          ..write('customerNameSnapshot: $customerNameSnapshot, ')
          ..write('customerMobileSnapshot: $customerMobileSnapshot, ')
          ..write('motorType: $motorType, ')
          ..write('motorBrand: $motorBrand, ')
          ..write('motorHp: $motorHp, ')
          ..write('motorPhase: $motorPhase, ')
          ..write('motorVoltage: $motorVoltage, ')
          ..write('motorSerialNumber: $motorSerialNumber, ')
          ..write('problemDescription: $problemDescription, ')
          ..write('workDescription: $workDescription, ')
          ..write('labourCharges: $labourCharges, ')
          ..write('materialCharges: $materialCharges, ')
          ..write('otherCharges: $otherCharges, ')
          ..write('discount: $discount, ')
          ..write('finalAmount: $finalAmount, ')
          ..write('advancePayment: $advancePayment, ')
          ..write('remainingAmount: $remainingAmount, ')
          ..write('jobStatus: $jobStatus, ')
          ..write('receivedDate: $receivedDate, ')
          ..write('expectedDeliveryDate: $expectedDeliveryDate, ')
          ..write('deliveryDate: $deliveryDate, ')
          ..write('warrantyInfo: $warrantyInfo, ')
          ..write('notes: $notes, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RepairJobPartsTable extends RepairJobParts
    with TableInfo<$RepairJobPartsTable, RepairJobPart> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepairJobPartsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _repairJobIdMeta = const VerificationMeta(
    'repairJobId',
  );
  @override
  late final GeneratedColumn<int> repairJobId = GeneratedColumn<int>(
    'repair_job_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES repair_jobs (id)',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _partNameMeta = const VerificationMeta(
    'partName',
  );
  @override
  late final GeneratedColumn<String> partName = GeneratedColumn<String>(
    'part_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
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
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _totalPriceMeta = const VerificationMeta(
    'totalPrice',
  );
  @override
  late final GeneratedColumn<double> totalPrice = GeneratedColumn<double>(
    'total_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    repairJobId,
    productId,
    partName,
    quantity,
    unitPrice,
    totalPrice,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repair_job_parts';
  @override
  VerificationContext validateIntegrity(
    Insertable<RepairJobPart> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('repair_job_id')) {
      context.handle(
        _repairJobIdMeta,
        repairJobId.isAcceptableOrUnknown(
          data['repair_job_id']!,
          _repairJobIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_repairJobIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('part_name')) {
      context.handle(
        _partNameMeta,
        partName.isAcceptableOrUnknown(data['part_name']!, _partNameMeta),
      );
    } else if (isInserting) {
      context.missing(_partNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RepairJobPart map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepairJobPart(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      repairJobId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repair_job_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      ),
      partName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_name'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_price'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RepairJobPartsTable createAlias(String alias) {
    return $RepairJobPartsTable(attachedDatabase, alias);
  }
}

class RepairJobPart extends DataClass implements Insertable<RepairJobPart> {
  final int id;
  final int repairJobId;
  final int? productId;
  final String partName;
  final double quantity;
  final double unitPrice;
  final double totalPrice;
  final DateTime createdAt;
  const RepairJobPart({
    required this.id,
    required this.repairJobId,
    this.productId,
    required this.partName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['repair_job_id'] = Variable<int>(repairJobId);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    map['part_name'] = Variable<String>(partName);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['total_price'] = Variable<double>(totalPrice);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RepairJobPartsCompanion toCompanion(bool nullToAbsent) {
    return RepairJobPartsCompanion(
      id: Value(id),
      repairJobId: Value(repairJobId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      partName: Value(partName),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      totalPrice: Value(totalPrice),
      createdAt: Value(createdAt),
    );
  }

  factory RepairJobPart.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepairJobPart(
      id: serializer.fromJson<int>(json['id']),
      repairJobId: serializer.fromJson<int>(json['repairJobId']),
      productId: serializer.fromJson<int?>(json['productId']),
      partName: serializer.fromJson<String>(json['partName']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'repairJobId': serializer.toJson<int>(repairJobId),
      'productId': serializer.toJson<int?>(productId),
      'partName': serializer.toJson<String>(partName),
      'quantity': serializer.toJson<double>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RepairJobPart copyWith({
    int? id,
    int? repairJobId,
    Value<int?> productId = const Value.absent(),
    String? partName,
    double? quantity,
    double? unitPrice,
    double? totalPrice,
    DateTime? createdAt,
  }) => RepairJobPart(
    id: id ?? this.id,
    repairJobId: repairJobId ?? this.repairJobId,
    productId: productId.present ? productId.value : this.productId,
    partName: partName ?? this.partName,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    totalPrice: totalPrice ?? this.totalPrice,
    createdAt: createdAt ?? this.createdAt,
  );
  RepairJobPart copyWithCompanion(RepairJobPartsCompanion data) {
    return RepairJobPart(
      id: data.id.present ? data.id.value : this.id,
      repairJobId: data.repairJobId.present
          ? data.repairJobId.value
          : this.repairJobId,
      productId: data.productId.present ? data.productId.value : this.productId,
      partName: data.partName.present ? data.partName.value : this.partName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepairJobPart(')
          ..write('id: $id, ')
          ..write('repairJobId: $repairJobId, ')
          ..write('productId: $productId, ')
          ..write('partName: $partName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    repairJobId,
    productId,
    partName,
    quantity,
    unitPrice,
    totalPrice,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepairJobPart &&
          other.id == this.id &&
          other.repairJobId == this.repairJobId &&
          other.productId == this.productId &&
          other.partName == this.partName &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.totalPrice == this.totalPrice &&
          other.createdAt == this.createdAt);
}

class RepairJobPartsCompanion extends UpdateCompanion<RepairJobPart> {
  final Value<int> id;
  final Value<int> repairJobId;
  final Value<int?> productId;
  final Value<String> partName;
  final Value<double> quantity;
  final Value<double> unitPrice;
  final Value<double> totalPrice;
  final Value<DateTime> createdAt;
  const RepairJobPartsCompanion({
    this.id = const Value.absent(),
    this.repairJobId = const Value.absent(),
    this.productId = const Value.absent(),
    this.partName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RepairJobPartsCompanion.insert({
    this.id = const Value.absent(),
    required int repairJobId,
    this.productId = const Value.absent(),
    required String partName,
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : repairJobId = Value(repairJobId),
       partName = Value(partName);
  static Insertable<RepairJobPart> custom({
    Expression<int>? id,
    Expression<int>? repairJobId,
    Expression<int>? productId,
    Expression<String>? partName,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? totalPrice,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (repairJobId != null) 'repair_job_id': repairJobId,
      if (productId != null) 'product_id': productId,
      if (partName != null) 'part_name': partName,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (totalPrice != null) 'total_price': totalPrice,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RepairJobPartsCompanion copyWith({
    Value<int>? id,
    Value<int>? repairJobId,
    Value<int?>? productId,
    Value<String>? partName,
    Value<double>? quantity,
    Value<double>? unitPrice,
    Value<double>? totalPrice,
    Value<DateTime>? createdAt,
  }) {
    return RepairJobPartsCompanion(
      id: id ?? this.id,
      repairJobId: repairJobId ?? this.repairJobId,
      productId: productId ?? this.productId,
      partName: partName ?? this.partName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (repairJobId.present) {
      map['repair_job_id'] = Variable<int>(repairJobId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (partName.present) {
      map['part_name'] = Variable<String>(partName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepairJobPartsCompanion(')
          ..write('id: $id, ')
          ..write('repairJobId: $repairJobId, ')
          ..write('productId: $productId, ')
          ..write('partName: $partName, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices with TableInfo<$InvoicesTable, Invoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
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
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
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
  static const VerificationMeta _customerMobileMeta = const VerificationMeta(
    'customerMobile',
  );
  @override
  late final GeneratedColumn<String> customerMobile = GeneratedColumn<String>(
    'customer_mobile',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repairJobIdMeta = const VerificationMeta(
    'repairJobId',
  );
  @override
  late final GeneratedColumn<int> repairJobId = GeneratedColumn<int>(
    'repair_job_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES repair_jobs (id)',
    ),
  );
  static const VerificationMeta _invoiceDateMeta = const VerificationMeta(
    'invoiceDate',
  );
  @override
  late final GeneratedColumn<DateTime> invoiceDate = GeneratedColumn<DateTime>(
    'invoice_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _discountMeta = const VerificationMeta(
    'discount',
  );
  @override
  late final GeneratedColumn<double> discount = GeneratedColumn<double>(
    'discount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _taxRateMeta = const VerificationMeta(
    'taxRate',
  );
  @override
  late final GeneratedColumn<double> taxRate = GeneratedColumn<double>(
    'tax_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _taxAmountMeta = const VerificationMeta(
    'taxAmount',
  );
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
    'tax_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _grandTotalMeta = const VerificationMeta(
    'grandTotal',
  );
  @override
  late final GeneratedColumn<double> grandTotal = GeneratedColumn<double>(
    'grand_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _paidAmountMeta = const VerificationMeta(
    'paidAmount',
  );
  @override
  late final GeneratedColumn<double> paidAmount = GeneratedColumn<double>(
    'paid_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _pendingAmountMeta = const VerificationMeta(
    'pendingAmount',
  );
  @override
  late final GeneratedColumn<double> pendingAmount = GeneratedColumn<double>(
    'pending_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _paymentModeMeta = const VerificationMeta(
    'paymentMode',
  );
  @override
  late final GeneratedColumn<String> paymentMode = GeneratedColumn<String>(
    'payment_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('cash'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _termsAndConditionsMeta =
      const VerificationMeta('termsAndConditions');
  @override
  late final GeneratedColumn<String> termsAndConditions =
      GeneratedColumn<String>(
        'terms_and_conditions',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isCancelledMeta = const VerificationMeta(
    'isCancelled',
  );
  @override
  late final GeneratedColumn<bool> isCancelled = GeneratedColumn<bool>(
    'is_cancelled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_cancelled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _cancellationReasonMeta =
      const VerificationMeta('cancellationReason');
  @override
  late final GeneratedColumn<String> cancellationReason =
      GeneratedColumn<String>(
        'cancellation_reason',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceNumber,
    category,
    customerId,
    customerName,
    customerMobile,
    repairJobId,
    invoiceDate,
    subtotal,
    discount,
    taxRate,
    taxAmount,
    grandTotal,
    paidAmount,
    pendingAmount,
    paymentMode,
    notes,
    termsAndConditions,
    isCancelled,
    cancellationReason,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Invoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
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
    if (data.containsKey('customer_mobile')) {
      context.handle(
        _customerMobileMeta,
        customerMobile.isAcceptableOrUnknown(
          data['customer_mobile']!,
          _customerMobileMeta,
        ),
      );
    }
    if (data.containsKey('repair_job_id')) {
      context.handle(
        _repairJobIdMeta,
        repairJobId.isAcceptableOrUnknown(
          data['repair_job_id']!,
          _repairJobIdMeta,
        ),
      );
    }
    if (data.containsKey('invoice_date')) {
      context.handle(
        _invoiceDateMeta,
        invoiceDate.isAcceptableOrUnknown(
          data['invoice_date']!,
          _invoiceDateMeta,
        ),
      );
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    }
    if (data.containsKey('discount')) {
      context.handle(
        _discountMeta,
        discount.isAcceptableOrUnknown(data['discount']!, _discountMeta),
      );
    }
    if (data.containsKey('tax_rate')) {
      context.handle(
        _taxRateMeta,
        taxRate.isAcceptableOrUnknown(data['tax_rate']!, _taxRateMeta),
      );
    }
    if (data.containsKey('tax_amount')) {
      context.handle(
        _taxAmountMeta,
        taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta),
      );
    }
    if (data.containsKey('grand_total')) {
      context.handle(
        _grandTotalMeta,
        grandTotal.isAcceptableOrUnknown(data['grand_total']!, _grandTotalMeta),
      );
    }
    if (data.containsKey('paid_amount')) {
      context.handle(
        _paidAmountMeta,
        paidAmount.isAcceptableOrUnknown(data['paid_amount']!, _paidAmountMeta),
      );
    }
    if (data.containsKey('pending_amount')) {
      context.handle(
        _pendingAmountMeta,
        pendingAmount.isAcceptableOrUnknown(
          data['pending_amount']!,
          _pendingAmountMeta,
        ),
      );
    }
    if (data.containsKey('payment_mode')) {
      context.handle(
        _paymentModeMeta,
        paymentMode.isAcceptableOrUnknown(
          data['payment_mode']!,
          _paymentModeMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('terms_and_conditions')) {
      context.handle(
        _termsAndConditionsMeta,
        termsAndConditions.isAcceptableOrUnknown(
          data['terms_and_conditions']!,
          _termsAndConditionsMeta,
        ),
      );
    }
    if (data.containsKey('is_cancelled')) {
      context.handle(
        _isCancelledMeta,
        isCancelled.isAcceptableOrUnknown(
          data['is_cancelled']!,
          _isCancelledMeta,
        ),
      );
    }
    if (data.containsKey('cancellation_reason')) {
      context.handle(
        _cancellationReasonMeta,
        cancellationReason.isAcceptableOrUnknown(
          data['cancellation_reason']!,
          _cancellationReasonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Invoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Invoice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_number'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      ),
      customerMobile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_mobile'],
      ),
      repairJobId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repair_job_id'],
      ),
      invoiceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}invoice_date'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
      discount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount'],
      )!,
      taxRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_rate'],
      )!,
      taxAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_amount'],
      )!,
      grandTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grand_total'],
      )!,
      paidAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}paid_amount'],
      )!,
      pendingAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pending_amount'],
      )!,
      paymentMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_mode'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      termsAndConditions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}terms_and_conditions'],
      ),
      isCancelled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_cancelled'],
      )!,
      cancellationReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cancellation_reason'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class Invoice extends DataClass implements Insertable<Invoice> {
  final int id;
  final String invoiceNumber;
  final String category;
  final int? customerId;
  final String? customerName;
  final String? customerMobile;
  final int? repairJobId;
  final DateTime invoiceDate;
  final double subtotal;
  final double discount;
  final double taxRate;
  final double taxAmount;
  final double grandTotal;
  final double paidAmount;
  final double pendingAmount;
  final String paymentMode;
  final String? notes;
  final String? termsAndConditions;
  final bool isCancelled;
  final String? cancellationReason;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.category,
    this.customerId,
    this.customerName,
    this.customerMobile,
    this.repairJobId,
    required this.invoiceDate,
    required this.subtotal,
    required this.discount,
    required this.taxRate,
    required this.taxAmount,
    required this.grandTotal,
    required this.paidAmount,
    required this.pendingAmount,
    required this.paymentMode,
    this.notes,
    this.termsAndConditions,
    required this.isCancelled,
    this.cancellationReason,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_number'] = Variable<String>(invoiceNumber);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    if (!nullToAbsent || customerMobile != null) {
      map['customer_mobile'] = Variable<String>(customerMobile);
    }
    if (!nullToAbsent || repairJobId != null) {
      map['repair_job_id'] = Variable<int>(repairJobId);
    }
    map['invoice_date'] = Variable<DateTime>(invoiceDate);
    map['subtotal'] = Variable<double>(subtotal);
    map['discount'] = Variable<double>(discount);
    map['tax_rate'] = Variable<double>(taxRate);
    map['tax_amount'] = Variable<double>(taxAmount);
    map['grand_total'] = Variable<double>(grandTotal);
    map['paid_amount'] = Variable<double>(paidAmount);
    map['pending_amount'] = Variable<double>(pendingAmount);
    map['payment_mode'] = Variable<String>(paymentMode);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || termsAndConditions != null) {
      map['terms_and_conditions'] = Variable<String>(termsAndConditions);
    }
    map['is_cancelled'] = Variable<bool>(isCancelled);
    if (!nullToAbsent || cancellationReason != null) {
      map['cancellation_reason'] = Variable<String>(cancellationReason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      invoiceNumber: Value(invoiceNumber),
      category: Value(category),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      customerMobile: customerMobile == null && nullToAbsent
          ? const Value.absent()
          : Value(customerMobile),
      repairJobId: repairJobId == null && nullToAbsent
          ? const Value.absent()
          : Value(repairJobId),
      invoiceDate: Value(invoiceDate),
      subtotal: Value(subtotal),
      discount: Value(discount),
      taxRate: Value(taxRate),
      taxAmount: Value(taxAmount),
      grandTotal: Value(grandTotal),
      paidAmount: Value(paidAmount),
      pendingAmount: Value(pendingAmount),
      paymentMode: Value(paymentMode),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      termsAndConditions: termsAndConditions == null && nullToAbsent
          ? const Value.absent()
          : Value(termsAndConditions),
      isCancelled: Value(isCancelled),
      cancellationReason: cancellationReason == null && nullToAbsent
          ? const Value.absent()
          : Value(cancellationReason),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Invoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Invoice(
      id: serializer.fromJson<int>(json['id']),
      invoiceNumber: serializer.fromJson<String>(json['invoiceNumber']),
      category: serializer.fromJson<String>(json['category']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      customerMobile: serializer.fromJson<String?>(json['customerMobile']),
      repairJobId: serializer.fromJson<int?>(json['repairJobId']),
      invoiceDate: serializer.fromJson<DateTime>(json['invoiceDate']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      discount: serializer.fromJson<double>(json['discount']),
      taxRate: serializer.fromJson<double>(json['taxRate']),
      taxAmount: serializer.fromJson<double>(json['taxAmount']),
      grandTotal: serializer.fromJson<double>(json['grandTotal']),
      paidAmount: serializer.fromJson<double>(json['paidAmount']),
      pendingAmount: serializer.fromJson<double>(json['pendingAmount']),
      paymentMode: serializer.fromJson<String>(json['paymentMode']),
      notes: serializer.fromJson<String?>(json['notes']),
      termsAndConditions: serializer.fromJson<String?>(
        json['termsAndConditions'],
      ),
      isCancelled: serializer.fromJson<bool>(json['isCancelled']),
      cancellationReason: serializer.fromJson<String?>(
        json['cancellationReason'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceNumber': serializer.toJson<String>(invoiceNumber),
      'category': serializer.toJson<String>(category),
      'customerId': serializer.toJson<int?>(customerId),
      'customerName': serializer.toJson<String?>(customerName),
      'customerMobile': serializer.toJson<String?>(customerMobile),
      'repairJobId': serializer.toJson<int?>(repairJobId),
      'invoiceDate': serializer.toJson<DateTime>(invoiceDate),
      'subtotal': serializer.toJson<double>(subtotal),
      'discount': serializer.toJson<double>(discount),
      'taxRate': serializer.toJson<double>(taxRate),
      'taxAmount': serializer.toJson<double>(taxAmount),
      'grandTotal': serializer.toJson<double>(grandTotal),
      'paidAmount': serializer.toJson<double>(paidAmount),
      'pendingAmount': serializer.toJson<double>(pendingAmount),
      'paymentMode': serializer.toJson<String>(paymentMode),
      'notes': serializer.toJson<String?>(notes),
      'termsAndConditions': serializer.toJson<String?>(termsAndConditions),
      'isCancelled': serializer.toJson<bool>(isCancelled),
      'cancellationReason': serializer.toJson<String?>(cancellationReason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Invoice copyWith({
    int? id,
    String? invoiceNumber,
    String? category,
    Value<int?> customerId = const Value.absent(),
    Value<String?> customerName = const Value.absent(),
    Value<String?> customerMobile = const Value.absent(),
    Value<int?> repairJobId = const Value.absent(),
    DateTime? invoiceDate,
    double? subtotal,
    double? discount,
    double? taxRate,
    double? taxAmount,
    double? grandTotal,
    double? paidAmount,
    double? pendingAmount,
    String? paymentMode,
    Value<String?> notes = const Value.absent(),
    Value<String?> termsAndConditions = const Value.absent(),
    bool? isCancelled,
    Value<String?> cancellationReason = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => Invoice(
    id: id ?? this.id,
    invoiceNumber: invoiceNumber ?? this.invoiceNumber,
    category: category ?? this.category,
    customerId: customerId.present ? customerId.value : this.customerId,
    customerName: customerName.present ? customerName.value : this.customerName,
    customerMobile: customerMobile.present
        ? customerMobile.value
        : this.customerMobile,
    repairJobId: repairJobId.present ? repairJobId.value : this.repairJobId,
    invoiceDate: invoiceDate ?? this.invoiceDate,
    subtotal: subtotal ?? this.subtotal,
    discount: discount ?? this.discount,
    taxRate: taxRate ?? this.taxRate,
    taxAmount: taxAmount ?? this.taxAmount,
    grandTotal: grandTotal ?? this.grandTotal,
    paidAmount: paidAmount ?? this.paidAmount,
    pendingAmount: pendingAmount ?? this.pendingAmount,
    paymentMode: paymentMode ?? this.paymentMode,
    notes: notes.present ? notes.value : this.notes,
    termsAndConditions: termsAndConditions.present
        ? termsAndConditions.value
        : this.termsAndConditions,
    isCancelled: isCancelled ?? this.isCancelled,
    cancellationReason: cancellationReason.present
        ? cancellationReason.value
        : this.cancellationReason,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Invoice copyWithCompanion(InvoicesCompanion data) {
    return Invoice(
      id: data.id.present ? data.id.value : this.id,
      invoiceNumber: data.invoiceNumber.present
          ? data.invoiceNumber.value
          : this.invoiceNumber,
      category: data.category.present ? data.category.value : this.category,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      customerMobile: data.customerMobile.present
          ? data.customerMobile.value
          : this.customerMobile,
      repairJobId: data.repairJobId.present
          ? data.repairJobId.value
          : this.repairJobId,
      invoiceDate: data.invoiceDate.present
          ? data.invoiceDate.value
          : this.invoiceDate,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      discount: data.discount.present ? data.discount.value : this.discount,
      taxRate: data.taxRate.present ? data.taxRate.value : this.taxRate,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      grandTotal: data.grandTotal.present
          ? data.grandTotal.value
          : this.grandTotal,
      paidAmount: data.paidAmount.present
          ? data.paidAmount.value
          : this.paidAmount,
      pendingAmount: data.pendingAmount.present
          ? data.pendingAmount.value
          : this.pendingAmount,
      paymentMode: data.paymentMode.present
          ? data.paymentMode.value
          : this.paymentMode,
      notes: data.notes.present ? data.notes.value : this.notes,
      termsAndConditions: data.termsAndConditions.present
          ? data.termsAndConditions.value
          : this.termsAndConditions,
      isCancelled: data.isCancelled.present
          ? data.isCancelled.value
          : this.isCancelled,
      cancellationReason: data.cancellationReason.present
          ? data.cancellationReason.value
          : this.cancellationReason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Invoice(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('category: $category, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('customerMobile: $customerMobile, ')
          ..write('repairJobId: $repairJobId, ')
          ..write('invoiceDate: $invoiceDate, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount: $discount, ')
          ..write('taxRate: $taxRate, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('grandTotal: $grandTotal, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('pendingAmount: $pendingAmount, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('notes: $notes, ')
          ..write('termsAndConditions: $termsAndConditions, ')
          ..write('isCancelled: $isCancelled, ')
          ..write('cancellationReason: $cancellationReason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    invoiceNumber,
    category,
    customerId,
    customerName,
    customerMobile,
    repairJobId,
    invoiceDate,
    subtotal,
    discount,
    taxRate,
    taxAmount,
    grandTotal,
    paidAmount,
    pendingAmount,
    paymentMode,
    notes,
    termsAndConditions,
    isCancelled,
    cancellationReason,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Invoice &&
          other.id == this.id &&
          other.invoiceNumber == this.invoiceNumber &&
          other.category == this.category &&
          other.customerId == this.customerId &&
          other.customerName == this.customerName &&
          other.customerMobile == this.customerMobile &&
          other.repairJobId == this.repairJobId &&
          other.invoiceDate == this.invoiceDate &&
          other.subtotal == this.subtotal &&
          other.discount == this.discount &&
          other.taxRate == this.taxRate &&
          other.taxAmount == this.taxAmount &&
          other.grandTotal == this.grandTotal &&
          other.paidAmount == this.paidAmount &&
          other.pendingAmount == this.pendingAmount &&
          other.paymentMode == this.paymentMode &&
          other.notes == this.notes &&
          other.termsAndConditions == this.termsAndConditions &&
          other.isCancelled == this.isCancelled &&
          other.cancellationReason == this.cancellationReason &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InvoicesCompanion extends UpdateCompanion<Invoice> {
  final Value<int> id;
  final Value<String> invoiceNumber;
  final Value<String> category;
  final Value<int?> customerId;
  final Value<String?> customerName;
  final Value<String?> customerMobile;
  final Value<int?> repairJobId;
  final Value<DateTime> invoiceDate;
  final Value<double> subtotal;
  final Value<double> discount;
  final Value<double> taxRate;
  final Value<double> taxAmount;
  final Value<double> grandTotal;
  final Value<double> paidAmount;
  final Value<double> pendingAmount;
  final Value<String> paymentMode;
  final Value<String?> notes;
  final Value<String?> termsAndConditions;
  final Value<bool> isCancelled;
  final Value<String?> cancellationReason;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.category = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.customerMobile = const Value.absent(),
    this.repairJobId = const Value.absent(),
    this.invoiceDate = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.discount = const Value.absent(),
    this.taxRate = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.grandTotal = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.pendingAmount = const Value.absent(),
    this.paymentMode = const Value.absent(),
    this.notes = const Value.absent(),
    this.termsAndConditions = const Value.absent(),
    this.isCancelled = const Value.absent(),
    this.cancellationReason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  InvoicesCompanion.insert({
    this.id = const Value.absent(),
    required String invoiceNumber,
    required String category,
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.customerMobile = const Value.absent(),
    this.repairJobId = const Value.absent(),
    this.invoiceDate = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.discount = const Value.absent(),
    this.taxRate = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.grandTotal = const Value.absent(),
    this.paidAmount = const Value.absent(),
    this.pendingAmount = const Value.absent(),
    this.paymentMode = const Value.absent(),
    this.notes = const Value.absent(),
    this.termsAndConditions = const Value.absent(),
    this.isCancelled = const Value.absent(),
    this.cancellationReason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : invoiceNumber = Value(invoiceNumber),
       category = Value(category);
  static Insertable<Invoice> custom({
    Expression<int>? id,
    Expression<String>? invoiceNumber,
    Expression<String>? category,
    Expression<int>? customerId,
    Expression<String>? customerName,
    Expression<String>? customerMobile,
    Expression<int>? repairJobId,
    Expression<DateTime>? invoiceDate,
    Expression<double>? subtotal,
    Expression<double>? discount,
    Expression<double>? taxRate,
    Expression<double>? taxAmount,
    Expression<double>? grandTotal,
    Expression<double>? paidAmount,
    Expression<double>? pendingAmount,
    Expression<String>? paymentMode,
    Expression<String>? notes,
    Expression<String>? termsAndConditions,
    Expression<bool>? isCancelled,
    Expression<String>? cancellationReason,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (category != null) 'category': category,
      if (customerId != null) 'customer_id': customerId,
      if (customerName != null) 'customer_name': customerName,
      if (customerMobile != null) 'customer_mobile': customerMobile,
      if (repairJobId != null) 'repair_job_id': repairJobId,
      if (invoiceDate != null) 'invoice_date': invoiceDate,
      if (subtotal != null) 'subtotal': subtotal,
      if (discount != null) 'discount': discount,
      if (taxRate != null) 'tax_rate': taxRate,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (grandTotal != null) 'grand_total': grandTotal,
      if (paidAmount != null) 'paid_amount': paidAmount,
      if (pendingAmount != null) 'pending_amount': pendingAmount,
      if (paymentMode != null) 'payment_mode': paymentMode,
      if (notes != null) 'notes': notes,
      if (termsAndConditions != null)
        'terms_and_conditions': termsAndConditions,
      if (isCancelled != null) 'is_cancelled': isCancelled,
      if (cancellationReason != null) 'cancellation_reason': cancellationReason,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  InvoicesCompanion copyWith({
    Value<int>? id,
    Value<String>? invoiceNumber,
    Value<String>? category,
    Value<int?>? customerId,
    Value<String?>? customerName,
    Value<String?>? customerMobile,
    Value<int?>? repairJobId,
    Value<DateTime>? invoiceDate,
    Value<double>? subtotal,
    Value<double>? discount,
    Value<double>? taxRate,
    Value<double>? taxAmount,
    Value<double>? grandTotal,
    Value<double>? paidAmount,
    Value<double>? pendingAmount,
    Value<String>? paymentMode,
    Value<String?>? notes,
    Value<String?>? termsAndConditions,
    Value<bool>? isCancelled,
    Value<String?>? cancellationReason,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      category: category ?? this.category,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerMobile: customerMobile ?? this.customerMobile,
      repairJobId: repairJobId ?? this.repairJobId,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      taxRate: taxRate ?? this.taxRate,
      taxAmount: taxAmount ?? this.taxAmount,
      grandTotal: grandTotal ?? this.grandTotal,
      paidAmount: paidAmount ?? this.paidAmount,
      pendingAmount: pendingAmount ?? this.pendingAmount,
      paymentMode: paymentMode ?? this.paymentMode,
      notes: notes ?? this.notes,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      isCancelled: isCancelled ?? this.isCancelled,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (customerMobile.present) {
      map['customer_mobile'] = Variable<String>(customerMobile.value);
    }
    if (repairJobId.present) {
      map['repair_job_id'] = Variable<int>(repairJobId.value);
    }
    if (invoiceDate.present) {
      map['invoice_date'] = Variable<DateTime>(invoiceDate.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (discount.present) {
      map['discount'] = Variable<double>(discount.value);
    }
    if (taxRate.present) {
      map['tax_rate'] = Variable<double>(taxRate.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (grandTotal.present) {
      map['grand_total'] = Variable<double>(grandTotal.value);
    }
    if (paidAmount.present) {
      map['paid_amount'] = Variable<double>(paidAmount.value);
    }
    if (pendingAmount.present) {
      map['pending_amount'] = Variable<double>(pendingAmount.value);
    }
    if (paymentMode.present) {
      map['payment_mode'] = Variable<String>(paymentMode.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (termsAndConditions.present) {
      map['terms_and_conditions'] = Variable<String>(termsAndConditions.value);
    }
    if (isCancelled.present) {
      map['is_cancelled'] = Variable<bool>(isCancelled.value);
    }
    if (cancellationReason.present) {
      map['cancellation_reason'] = Variable<String>(cancellationReason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('category: $category, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('customerMobile: $customerMobile, ')
          ..write('repairJobId: $repairJobId, ')
          ..write('invoiceDate: $invoiceDate, ')
          ..write('subtotal: $subtotal, ')
          ..write('discount: $discount, ')
          ..write('taxRate: $taxRate, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('grandTotal: $grandTotal, ')
          ..write('paidAmount: $paidAmount, ')
          ..write('pendingAmount: $pendingAmount, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('notes: $notes, ')
          ..write('termsAndConditions: $termsAndConditions, ')
          ..write('isCancelled: $isCancelled, ')
          ..write('cancellationReason: $cancellationReason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $InvoiceItemsTable extends InvoiceItems
    with TableInfo<$InvoiceItemsTable, InvoiceItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceItemsTable(this.attachedDatabase, [this._alias]);
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
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
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
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
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
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    productId,
    description,
    quantity,
    unitPrice,
    amount,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceItem> instance, {
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
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
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
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InvoiceItemsTable createAlias(String alias) {
    return $InvoiceItemsTable(attachedDatabase, alias);
  }
}

class InvoiceItem extends DataClass implements Insertable<InvoiceItem> {
  final int id;
  final int invoiceId;
  final int? productId;
  final String description;
  final double quantity;
  final double unitPrice;
  final double amount;
  final DateTime createdAt;
  const InvoiceItem({
    required this.id,
    required this.invoiceId,
    this.productId,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.amount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    map['description'] = Variable<String>(description);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    map['amount'] = Variable<double>(amount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InvoiceItemsCompanion toCompanion(bool nullToAbsent) {
    return InvoiceItemsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      description: Value(description),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      amount: Value(amount),
      createdAt: Value(createdAt),
    );
  }

  factory InvoiceItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceItem(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoiceId']),
      productId: serializer.fromJson<int?>(json['productId']),
      description: serializer.fromJson<String>(json['description']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      amount: serializer.fromJson<double>(json['amount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoiceId': serializer.toJson<int>(invoiceId),
      'productId': serializer.toJson<int?>(productId),
      'description': serializer.toJson<String>(description),
      'quantity': serializer.toJson<double>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'amount': serializer.toJson<double>(amount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InvoiceItem copyWith({
    int? id,
    int? invoiceId,
    Value<int?> productId = const Value.absent(),
    String? description,
    double? quantity,
    double? unitPrice,
    double? amount,
    DateTime? createdAt,
  }) => InvoiceItem(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    productId: productId.present ? productId.value : this.productId,
    description: description ?? this.description,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    amount: amount ?? this.amount,
    createdAt: createdAt ?? this.createdAt,
  );
  InvoiceItem copyWithCompanion(InvoiceItemsCompanion data) {
    return InvoiceItem(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      productId: data.productId.present ? data.productId.value : this.productId,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      amount: data.amount.present ? data.amount.value : this.amount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItem(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    productId,
    description,
    quantity,
    unitPrice,
    amount,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceItem &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.productId == this.productId &&
          other.description == this.description &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.amount == this.amount &&
          other.createdAt == this.createdAt);
}

class InvoiceItemsCompanion extends UpdateCompanion<InvoiceItem> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<int?> productId;
  final Value<String> description;
  final Value<double> quantity;
  final Value<double> unitPrice;
  final Value<double> amount;
  final Value<DateTime> createdAt;
  const InvoiceItemsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.productId = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.amount = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  InvoiceItemsCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    this.productId = const Value.absent(),
    required String description,
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.amount = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : invoiceId = Value(invoiceId),
       description = Value(description);
  static Insertable<InvoiceItem> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<int>? productId,
    Expression<String>? description,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? amount,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (productId != null) 'product_id': productId,
      if (description != null) 'description': description,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (amount != null) 'amount': amount,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  InvoiceItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? invoiceId,
    Value<int?>? productId,
    Value<String>? description,
    Value<double>? quantity,
    Value<double>? unitPrice,
    Value<double>? amount,
    Value<DateTime>? createdAt,
  }) {
    return InvoiceItemsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      productId: productId ?? this.productId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
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
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('productId: $productId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>(
    'invoice_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _repairJobIdMeta = const VerificationMeta(
    'repairJobId',
  );
  @override
  late final GeneratedColumn<int> repairJobId = GeneratedColumn<int>(
    'repair_job_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES repair_jobs (id)',
    ),
  );
  static const VerificationMeta _paymentDateMeta = const VerificationMeta(
    'paymentDate',
  );
  @override
  late final GeneratedColumn<DateTime> paymentDate = GeneratedColumn<DateTime>(
    'payment_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _amountReceivedMeta = const VerificationMeta(
    'amountReceived',
  );
  @override
  late final GeneratedColumn<double> amountReceived = GeneratedColumn<double>(
    'amount_received',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentModeMeta = const VerificationMeta(
    'paymentMode',
  );
  @override
  late final GeneratedColumn<String> paymentMode = GeneratedColumn<String>(
    'payment_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('cash'),
  );
  static const VerificationMeta _transactionReferenceMeta =
      const VerificationMeta('transactionReference');
  @override
  late final GeneratedColumn<String> transactionReference =
      GeneratedColumn<String>(
        'transaction_reference',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerId,
    invoiceId,
    repairJobId,
    paymentDate,
    amountReceived,
    paymentMode,
    transactionReference,
    notes,
    isDeleted,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Payment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    }
    if (data.containsKey('repair_job_id')) {
      context.handle(
        _repairJobIdMeta,
        repairJobId.isAcceptableOrUnknown(
          data['repair_job_id']!,
          _repairJobIdMeta,
        ),
      );
    }
    if (data.containsKey('payment_date')) {
      context.handle(
        _paymentDateMeta,
        paymentDate.isAcceptableOrUnknown(
          data['payment_date']!,
          _paymentDateMeta,
        ),
      );
    }
    if (data.containsKey('amount_received')) {
      context.handle(
        _amountReceivedMeta,
        amountReceived.isAcceptableOrUnknown(
          data['amount_received']!,
          _amountReceivedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountReceivedMeta);
    }
    if (data.containsKey('payment_mode')) {
      context.handle(
        _paymentModeMeta,
        paymentMode.isAcceptableOrUnknown(
          data['payment_mode']!,
          _paymentModeMeta,
        ),
      );
    }
    if (data.containsKey('transaction_reference')) {
      context.handle(
        _transactionReferenceMeta,
        transactionReference.isAcceptableOrUnknown(
          data['transaction_reference']!,
          _transactionReferenceMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}invoice_id'],
      ),
      repairJobId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repair_job_id'],
      ),
      paymentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}payment_date'],
      )!,
      amountReceived: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount_received'],
      )!,
      paymentMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_mode'],
      )!,
      transactionReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_reference'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  final int id;
  final int customerId;
  final int? invoiceId;
  final int? repairJobId;
  final DateTime paymentDate;
  final double amountReceived;
  final String paymentMode;
  final String? transactionReference;
  final String? notes;
  final bool isDeleted;
  final DateTime createdAt;
  const Payment({
    required this.id,
    required this.customerId,
    this.invoiceId,
    this.repairJobId,
    required this.paymentDate,
    required this.amountReceived,
    required this.paymentMode,
    this.transactionReference,
    this.notes,
    required this.isDeleted,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    if (!nullToAbsent || invoiceId != null) {
      map['invoice_id'] = Variable<int>(invoiceId);
    }
    if (!nullToAbsent || repairJobId != null) {
      map['repair_job_id'] = Variable<int>(repairJobId);
    }
    map['payment_date'] = Variable<DateTime>(paymentDate);
    map['amount_received'] = Variable<double>(amountReceived);
    map['payment_mode'] = Variable<String>(paymentMode);
    if (!nullToAbsent || transactionReference != null) {
      map['transaction_reference'] = Variable<String>(transactionReference);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      customerId: Value(customerId),
      invoiceId: invoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(invoiceId),
      repairJobId: repairJobId == null && nullToAbsent
          ? const Value.absent()
          : Value(repairJobId),
      paymentDate: Value(paymentDate),
      amountReceived: Value(amountReceived),
      paymentMode: Value(paymentMode),
      transactionReference: transactionReference == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionReference),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
    );
  }

  factory Payment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      invoiceId: serializer.fromJson<int?>(json['invoiceId']),
      repairJobId: serializer.fromJson<int?>(json['repairJobId']),
      paymentDate: serializer.fromJson<DateTime>(json['paymentDate']),
      amountReceived: serializer.fromJson<double>(json['amountReceived']),
      paymentMode: serializer.fromJson<String>(json['paymentMode']),
      transactionReference: serializer.fromJson<String?>(
        json['transactionReference'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'invoiceId': serializer.toJson<int?>(invoiceId),
      'repairJobId': serializer.toJson<int?>(repairJobId),
      'paymentDate': serializer.toJson<DateTime>(paymentDate),
      'amountReceived': serializer.toJson<double>(amountReceived),
      'paymentMode': serializer.toJson<String>(paymentMode),
      'transactionReference': serializer.toJson<String?>(transactionReference),
      'notes': serializer.toJson<String?>(notes),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Payment copyWith({
    int? id,
    int? customerId,
    Value<int?> invoiceId = const Value.absent(),
    Value<int?> repairJobId = const Value.absent(),
    DateTime? paymentDate,
    double? amountReceived,
    String? paymentMode,
    Value<String?> transactionReference = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isDeleted,
    DateTime? createdAt,
  }) => Payment(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    invoiceId: invoiceId.present ? invoiceId.value : this.invoiceId,
    repairJobId: repairJobId.present ? repairJobId.value : this.repairJobId,
    paymentDate: paymentDate ?? this.paymentDate,
    amountReceived: amountReceived ?? this.amountReceived,
    paymentMode: paymentMode ?? this.paymentMode,
    transactionReference: transactionReference.present
        ? transactionReference.value
        : this.transactionReference,
    notes: notes.present ? notes.value : this.notes,
    isDeleted: isDeleted ?? this.isDeleted,
    createdAt: createdAt ?? this.createdAt,
  );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      repairJobId: data.repairJobId.present
          ? data.repairJobId.value
          : this.repairJobId,
      paymentDate: data.paymentDate.present
          ? data.paymentDate.value
          : this.paymentDate,
      amountReceived: data.amountReceived.present
          ? data.amountReceived.value
          : this.amountReceived,
      paymentMode: data.paymentMode.present
          ? data.paymentMode.value
          : this.paymentMode,
      transactionReference: data.transactionReference.present
          ? data.transactionReference.value
          : this.transactionReference,
      notes: data.notes.present ? data.notes.value : this.notes,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('repairJobId: $repairJobId, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('amountReceived: $amountReceived, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('transactionReference: $transactionReference, ')
          ..write('notes: $notes, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    customerId,
    invoiceId,
    repairJobId,
    paymentDate,
    amountReceived,
    paymentMode,
    transactionReference,
    notes,
    isDeleted,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.invoiceId == this.invoiceId &&
          other.repairJobId == this.repairJobId &&
          other.paymentDate == this.paymentDate &&
          other.amountReceived == this.amountReceived &&
          other.paymentMode == this.paymentMode &&
          other.transactionReference == this.transactionReference &&
          other.notes == this.notes &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<int?> invoiceId;
  final Value<int?> repairJobId;
  final Value<DateTime> paymentDate;
  final Value<double> amountReceived;
  final Value<String> paymentMode;
  final Value<String?> transactionReference;
  final Value<String?> notes;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.repairJobId = const Value.absent(),
    this.paymentDate = const Value.absent(),
    this.amountReceived = const Value.absent(),
    this.paymentMode = const Value.absent(),
    this.transactionReference = const Value.absent(),
    this.notes = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    this.invoiceId = const Value.absent(),
    this.repairJobId = const Value.absent(),
    this.paymentDate = const Value.absent(),
    required double amountReceived,
    this.paymentMode = const Value.absent(),
    this.transactionReference = const Value.absent(),
    this.notes = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : customerId = Value(customerId),
       amountReceived = Value(amountReceived);
  static Insertable<Payment> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<int>? invoiceId,
    Expression<int>? repairJobId,
    Expression<DateTime>? paymentDate,
    Expression<double>? amountReceived,
    Expression<String>? paymentMode,
    Expression<String>? transactionReference,
    Expression<String>? notes,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (repairJobId != null) 'repair_job_id': repairJobId,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (amountReceived != null) 'amount_received': amountReceived,
      if (paymentMode != null) 'payment_mode': paymentMode,
      if (transactionReference != null)
        'transaction_reference': transactionReference,
      if (notes != null) 'notes': notes,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PaymentsCompanion copyWith({
    Value<int>? id,
    Value<int>? customerId,
    Value<int?>? invoiceId,
    Value<int?>? repairJobId,
    Value<DateTime>? paymentDate,
    Value<double>? amountReceived,
    Value<String>? paymentMode,
    Value<String?>? transactionReference,
    Value<String?>? notes,
    Value<bool>? isDeleted,
    Value<DateTime>? createdAt,
  }) {
    return PaymentsCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      invoiceId: invoiceId ?? this.invoiceId,
      repairJobId: repairJobId ?? this.repairJobId,
      paymentDate: paymentDate ?? this.paymentDate,
      amountReceived: amountReceived ?? this.amountReceived,
      paymentMode: paymentMode ?? this.paymentMode,
      transactionReference: transactionReference ?? this.transactionReference,
      notes: notes ?? this.notes,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (repairJobId.present) {
      map['repair_job_id'] = Variable<int>(repairJobId.value);
    }
    if (paymentDate.present) {
      map['payment_date'] = Variable<DateTime>(paymentDate.value);
    }
    if (amountReceived.present) {
      map['amount_received'] = Variable<double>(amountReceived.value);
    }
    if (paymentMode.present) {
      map['payment_mode'] = Variable<String>(paymentMode.value);
    }
    if (transactionReference.present) {
      map['transaction_reference'] = Variable<String>(
        transactionReference.value,
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('repairJobId: $repairJobId, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('amountReceived: $amountReceived, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('transactionReference: $transactionReference, ')
          ..write('notes: $notes, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $StockMovementsTable extends StockMovements
    with TableInfo<$StockMovementsTable, StockMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockMovementsTable(this.attachedDatabase, [this._alias]);
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
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _movementTypeMeta = const VerificationMeta(
    'movementType',
  );
  @override
  late final GeneratedColumn<String> movementType = GeneratedColumn<String>(
    'movement_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
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
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _referenceTypeMeta = const VerificationMeta(
    'referenceType',
  );
  @override
  late final GeneratedColumn<String> referenceType = GeneratedColumn<String>(
    'reference_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceIdMeta = const VerificationMeta(
    'referenceId',
  );
  @override
  late final GeneratedColumn<int> referenceId = GeneratedColumn<int>(
    'reference_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    movementType,
    quantity,
    unitPrice,
    referenceType,
    referenceId,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockMovement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('movement_type')) {
      context.handle(
        _movementTypeMeta,
        movementType.isAcceptableOrUnknown(
          data['movement_type']!,
          _movementTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_movementTypeMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    }
    if (data.containsKey('reference_type')) {
      context.handle(
        _referenceTypeMeta,
        referenceType.isAcceptableOrUnknown(
          data['reference_type']!,
          _referenceTypeMeta,
        ),
      );
    }
    if (data.containsKey('reference_id')) {
      context.handle(
        _referenceIdMeta,
        referenceId.isAcceptableOrUnknown(
          data['reference_id']!,
          _referenceIdMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockMovement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      movementType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}movement_type'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      referenceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_type'],
      ),
      referenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reference_id'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StockMovementsTable createAlias(String alias) {
    return $StockMovementsTable(attachedDatabase, alias);
  }
}

class StockMovement extends DataClass implements Insertable<StockMovement> {
  final int id;
  final int productId;
  final String movementType;
  final double quantity;
  final double unitPrice;
  final String? referenceType;
  final int? referenceId;
  final String? notes;
  final DateTime createdAt;
  const StockMovement({
    required this.id,
    required this.productId,
    required this.movementType,
    required this.quantity,
    required this.unitPrice,
    this.referenceType,
    this.referenceId,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['movement_type'] = Variable<String>(movementType);
    map['quantity'] = Variable<double>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    if (!nullToAbsent || referenceType != null) {
      map['reference_type'] = Variable<String>(referenceType);
    }
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<int>(referenceId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StockMovementsCompanion toCompanion(bool nullToAbsent) {
    return StockMovementsCompanion(
      id: Value(id),
      productId: Value(productId),
      movementType: Value(movementType),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      referenceType: referenceType == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceType),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory StockMovement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockMovement(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      movementType: serializer.fromJson<String>(json['movementType']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      referenceType: serializer.fromJson<String?>(json['referenceType']),
      referenceId: serializer.fromJson<int?>(json['referenceId']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'movementType': serializer.toJson<String>(movementType),
      'quantity': serializer.toJson<double>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'referenceType': serializer.toJson<String?>(referenceType),
      'referenceId': serializer.toJson<int?>(referenceId),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StockMovement copyWith({
    int? id,
    int? productId,
    String? movementType,
    double? quantity,
    double? unitPrice,
    Value<String?> referenceType = const Value.absent(),
    Value<int?> referenceId = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => StockMovement(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    movementType: movementType ?? this.movementType,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    referenceType: referenceType.present
        ? referenceType.value
        : this.referenceType,
    referenceId: referenceId.present ? referenceId.value : this.referenceId,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  StockMovement copyWithCompanion(StockMovementsCompanion data) {
    return StockMovement(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      movementType: data.movementType.present
          ? data.movementType.value
          : this.movementType,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      referenceType: data.referenceType.present
          ? data.referenceType.value
          : this.referenceType,
      referenceId: data.referenceId.present
          ? data.referenceId.value
          : this.referenceId,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockMovement(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('movementType: $movementType, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('referenceType: $referenceType, ')
          ..write('referenceId: $referenceId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    movementType,
    quantity,
    unitPrice,
    referenceType,
    referenceId,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockMovement &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.movementType == this.movementType &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.referenceType == this.referenceType &&
          other.referenceId == this.referenceId &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class StockMovementsCompanion extends UpdateCompanion<StockMovement> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String> movementType;
  final Value<double> quantity;
  final Value<double> unitPrice;
  final Value<String?> referenceType;
  final Value<int?> referenceId;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const StockMovementsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.movementType = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.referenceType = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  StockMovementsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required String movementType,
    required double quantity,
    this.unitPrice = const Value.absent(),
    this.referenceType = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : productId = Value(productId),
       movementType = Value(movementType),
       quantity = Value(quantity);
  static Insertable<StockMovement> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? movementType,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
    Expression<String>? referenceType,
    Expression<int>? referenceId,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (movementType != null) 'movement_type': movementType,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (referenceType != null) 'reference_type': referenceType,
      if (referenceId != null) 'reference_id': referenceId,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  StockMovementsCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<String>? movementType,
    Value<double>? quantity,
    Value<double>? unitPrice,
    Value<String?>? referenceType,
    Value<int?>? referenceId,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return StockMovementsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      movementType: movementType ?? this.movementType,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      referenceType: referenceType ?? this.referenceType,
      referenceId: referenceId ?? this.referenceId,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (movementType.present) {
      map['movement_type'] = Variable<String>(movementType.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (referenceType.present) {
      map['reference_type'] = Variable<String>(referenceType.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<int>(referenceId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockMovementsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('movementType: $movementType, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('referenceType: $referenceType, ')
          ..write('referenceId: $referenceId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DailyWorkLogsTable extends DailyWorkLogs
    with TableInfo<$DailyWorkLogsTable, DailyWorkLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyWorkLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _logDateMeta = const VerificationMeta(
    'logDate',
  );
  @override
  late final GeneratedColumn<DateTime> logDate = GeneratedColumn<DateTime>(
    'log_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
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
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
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
  static const VerificationMeta _repairJobIdMeta = const VerificationMeta(
    'repairJobId',
  );
  @override
  late final GeneratedColumn<int> repairJobId = GeneratedColumn<int>(
    'repair_job_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES repair_jobs (id)',
    ),
  );
  static const VerificationMeta _jobNumberMeta = const VerificationMeta(
    'jobNumber',
  );
  @override
  late final GeneratedColumn<String> jobNumber = GeneratedColumn<String>(
    'job_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _motorDetailsMeta = const VerificationMeta(
    'motorDetails',
  );
  @override
  late final GeneratedColumn<String> motorDetails = GeneratedColumn<String>(
    'motor_details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _workPerformedMeta = const VerificationMeta(
    'workPerformed',
  );
  @override
  late final GeneratedColumn<String> workPerformed = GeneratedColumn<String>(
    'work_performed',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _partsUsedMeta = const VerificationMeta(
    'partsUsed',
  );
  @override
  late final GeneratedColumn<String> partsUsed = GeneratedColumn<String>(
    'parts_used',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labourChargesMeta = const VerificationMeta(
    'labourCharges',
  );
  @override
  late final GeneratedColumn<double> labourCharges = GeneratedColumn<double>(
    'labour_charges',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _paymentReceivedMeta = const VerificationMeta(
    'paymentReceived',
  );
  @override
  late final GeneratedColumn<double> paymentReceived = GeneratedColumn<double>(
    'payment_received',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _pendingAmountMeta = const VerificationMeta(
    'pendingAmount',
  );
  @override
  late final GeneratedColumn<double> pendingAmount = GeneratedColumn<double>(
    'pending_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _workStatusMeta = const VerificationMeta(
    'workStatus',
  );
  @override
  late final GeneratedColumn<String> workStatus = GeneratedColumn<String>(
    'work_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    logDate,
    customerId,
    customerName,
    repairJobId,
    jobNumber,
    motorDetails,
    workPerformed,
    partsUsed,
    labourCharges,
    paymentReceived,
    pendingAmount,
    workStatus,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_work_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyWorkLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('log_date')) {
      context.handle(
        _logDateMeta,
        logDate.isAcceptableOrUnknown(data['log_date']!, _logDateMeta),
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
    if (data.containsKey('repair_job_id')) {
      context.handle(
        _repairJobIdMeta,
        repairJobId.isAcceptableOrUnknown(
          data['repair_job_id']!,
          _repairJobIdMeta,
        ),
      );
    }
    if (data.containsKey('job_number')) {
      context.handle(
        _jobNumberMeta,
        jobNumber.isAcceptableOrUnknown(data['job_number']!, _jobNumberMeta),
      );
    }
    if (data.containsKey('motor_details')) {
      context.handle(
        _motorDetailsMeta,
        motorDetails.isAcceptableOrUnknown(
          data['motor_details']!,
          _motorDetailsMeta,
        ),
      );
    }
    if (data.containsKey('work_performed')) {
      context.handle(
        _workPerformedMeta,
        workPerformed.isAcceptableOrUnknown(
          data['work_performed']!,
          _workPerformedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workPerformedMeta);
    }
    if (data.containsKey('parts_used')) {
      context.handle(
        _partsUsedMeta,
        partsUsed.isAcceptableOrUnknown(data['parts_used']!, _partsUsedMeta),
      );
    }
    if (data.containsKey('labour_charges')) {
      context.handle(
        _labourChargesMeta,
        labourCharges.isAcceptableOrUnknown(
          data['labour_charges']!,
          _labourChargesMeta,
        ),
      );
    }
    if (data.containsKey('payment_received')) {
      context.handle(
        _paymentReceivedMeta,
        paymentReceived.isAcceptableOrUnknown(
          data['payment_received']!,
          _paymentReceivedMeta,
        ),
      );
    }
    if (data.containsKey('pending_amount')) {
      context.handle(
        _pendingAmountMeta,
        pendingAmount.isAcceptableOrUnknown(
          data['pending_amount']!,
          _pendingAmountMeta,
        ),
      );
    }
    if (data.containsKey('work_status')) {
      context.handle(
        _workStatusMeta,
        workStatus.isAcceptableOrUnknown(data['work_status']!, _workStatusMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyWorkLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyWorkLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      logDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}log_date'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}customer_id'],
      ),
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      ),
      repairJobId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repair_job_id'],
      ),
      jobNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_number'],
      ),
      motorDetails: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motor_details'],
      ),
      workPerformed: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_performed'],
      )!,
      partsUsed: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parts_used'],
      ),
      labourCharges: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}labour_charges'],
      )!,
      paymentReceived: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}payment_received'],
      )!,
      pendingAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pending_amount'],
      )!,
      workStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_status'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $DailyWorkLogsTable createAlias(String alias) {
    return $DailyWorkLogsTable(attachedDatabase, alias);
  }
}

class DailyWorkLog extends DataClass implements Insertable<DailyWorkLog> {
  final int id;
  final DateTime logDate;
  final int? customerId;
  final String? customerName;
  final int? repairJobId;
  final String? jobNumber;
  final String? motorDetails;
  final String workPerformed;
  final String? partsUsed;
  final double labourCharges;
  final double paymentReceived;
  final double pendingAmount;
  final String? workStatus;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const DailyWorkLog({
    required this.id,
    required this.logDate,
    this.customerId,
    this.customerName,
    this.repairJobId,
    this.jobNumber,
    this.motorDetails,
    required this.workPerformed,
    this.partsUsed,
    required this.labourCharges,
    required this.paymentReceived,
    required this.pendingAmount,
    this.workStatus,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['log_date'] = Variable<DateTime>(logDate);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    if (!nullToAbsent || repairJobId != null) {
      map['repair_job_id'] = Variable<int>(repairJobId);
    }
    if (!nullToAbsent || jobNumber != null) {
      map['job_number'] = Variable<String>(jobNumber);
    }
    if (!nullToAbsent || motorDetails != null) {
      map['motor_details'] = Variable<String>(motorDetails);
    }
    map['work_performed'] = Variable<String>(workPerformed);
    if (!nullToAbsent || partsUsed != null) {
      map['parts_used'] = Variable<String>(partsUsed);
    }
    map['labour_charges'] = Variable<double>(labourCharges);
    map['payment_received'] = Variable<double>(paymentReceived);
    map['pending_amount'] = Variable<double>(pendingAmount);
    if (!nullToAbsent || workStatus != null) {
      map['work_status'] = Variable<String>(workStatus);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  DailyWorkLogsCompanion toCompanion(bool nullToAbsent) {
    return DailyWorkLogsCompanion(
      id: Value(id),
      logDate: Value(logDate),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      repairJobId: repairJobId == null && nullToAbsent
          ? const Value.absent()
          : Value(repairJobId),
      jobNumber: jobNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(jobNumber),
      motorDetails: motorDetails == null && nullToAbsent
          ? const Value.absent()
          : Value(motorDetails),
      workPerformed: Value(workPerformed),
      partsUsed: partsUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(partsUsed),
      labourCharges: Value(labourCharges),
      paymentReceived: Value(paymentReceived),
      pendingAmount: Value(pendingAmount),
      workStatus: workStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(workStatus),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory DailyWorkLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyWorkLog(
      id: serializer.fromJson<int>(json['id']),
      logDate: serializer.fromJson<DateTime>(json['logDate']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      repairJobId: serializer.fromJson<int?>(json['repairJobId']),
      jobNumber: serializer.fromJson<String?>(json['jobNumber']),
      motorDetails: serializer.fromJson<String?>(json['motorDetails']),
      workPerformed: serializer.fromJson<String>(json['workPerformed']),
      partsUsed: serializer.fromJson<String?>(json['partsUsed']),
      labourCharges: serializer.fromJson<double>(json['labourCharges']),
      paymentReceived: serializer.fromJson<double>(json['paymentReceived']),
      pendingAmount: serializer.fromJson<double>(json['pendingAmount']),
      workStatus: serializer.fromJson<String?>(json['workStatus']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'logDate': serializer.toJson<DateTime>(logDate),
      'customerId': serializer.toJson<int?>(customerId),
      'customerName': serializer.toJson<String?>(customerName),
      'repairJobId': serializer.toJson<int?>(repairJobId),
      'jobNumber': serializer.toJson<String?>(jobNumber),
      'motorDetails': serializer.toJson<String?>(motorDetails),
      'workPerformed': serializer.toJson<String>(workPerformed),
      'partsUsed': serializer.toJson<String?>(partsUsed),
      'labourCharges': serializer.toJson<double>(labourCharges),
      'paymentReceived': serializer.toJson<double>(paymentReceived),
      'pendingAmount': serializer.toJson<double>(pendingAmount),
      'workStatus': serializer.toJson<String?>(workStatus),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  DailyWorkLog copyWith({
    int? id,
    DateTime? logDate,
    Value<int?> customerId = const Value.absent(),
    Value<String?> customerName = const Value.absent(),
    Value<int?> repairJobId = const Value.absent(),
    Value<String?> jobNumber = const Value.absent(),
    Value<String?> motorDetails = const Value.absent(),
    String? workPerformed,
    Value<String?> partsUsed = const Value.absent(),
    double? labourCharges,
    double? paymentReceived,
    double? pendingAmount,
    Value<String?> workStatus = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => DailyWorkLog(
    id: id ?? this.id,
    logDate: logDate ?? this.logDate,
    customerId: customerId.present ? customerId.value : this.customerId,
    customerName: customerName.present ? customerName.value : this.customerName,
    repairJobId: repairJobId.present ? repairJobId.value : this.repairJobId,
    jobNumber: jobNumber.present ? jobNumber.value : this.jobNumber,
    motorDetails: motorDetails.present ? motorDetails.value : this.motorDetails,
    workPerformed: workPerformed ?? this.workPerformed,
    partsUsed: partsUsed.present ? partsUsed.value : this.partsUsed,
    labourCharges: labourCharges ?? this.labourCharges,
    paymentReceived: paymentReceived ?? this.paymentReceived,
    pendingAmount: pendingAmount ?? this.pendingAmount,
    workStatus: workStatus.present ? workStatus.value : this.workStatus,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  DailyWorkLog copyWithCompanion(DailyWorkLogsCompanion data) {
    return DailyWorkLog(
      id: data.id.present ? data.id.value : this.id,
      logDate: data.logDate.present ? data.logDate.value : this.logDate,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      repairJobId: data.repairJobId.present
          ? data.repairJobId.value
          : this.repairJobId,
      jobNumber: data.jobNumber.present ? data.jobNumber.value : this.jobNumber,
      motorDetails: data.motorDetails.present
          ? data.motorDetails.value
          : this.motorDetails,
      workPerformed: data.workPerformed.present
          ? data.workPerformed.value
          : this.workPerformed,
      partsUsed: data.partsUsed.present ? data.partsUsed.value : this.partsUsed,
      labourCharges: data.labourCharges.present
          ? data.labourCharges.value
          : this.labourCharges,
      paymentReceived: data.paymentReceived.present
          ? data.paymentReceived.value
          : this.paymentReceived,
      pendingAmount: data.pendingAmount.present
          ? data.pendingAmount.value
          : this.pendingAmount,
      workStatus: data.workStatus.present
          ? data.workStatus.value
          : this.workStatus,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyWorkLog(')
          ..write('id: $id, ')
          ..write('logDate: $logDate, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('repairJobId: $repairJobId, ')
          ..write('jobNumber: $jobNumber, ')
          ..write('motorDetails: $motorDetails, ')
          ..write('workPerformed: $workPerformed, ')
          ..write('partsUsed: $partsUsed, ')
          ..write('labourCharges: $labourCharges, ')
          ..write('paymentReceived: $paymentReceived, ')
          ..write('pendingAmount: $pendingAmount, ')
          ..write('workStatus: $workStatus, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    logDate,
    customerId,
    customerName,
    repairJobId,
    jobNumber,
    motorDetails,
    workPerformed,
    partsUsed,
    labourCharges,
    paymentReceived,
    pendingAmount,
    workStatus,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyWorkLog &&
          other.id == this.id &&
          other.logDate == this.logDate &&
          other.customerId == this.customerId &&
          other.customerName == this.customerName &&
          other.repairJobId == this.repairJobId &&
          other.jobNumber == this.jobNumber &&
          other.motorDetails == this.motorDetails &&
          other.workPerformed == this.workPerformed &&
          other.partsUsed == this.partsUsed &&
          other.labourCharges == this.labourCharges &&
          other.paymentReceived == this.paymentReceived &&
          other.pendingAmount == this.pendingAmount &&
          other.workStatus == this.workStatus &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DailyWorkLogsCompanion extends UpdateCompanion<DailyWorkLog> {
  final Value<int> id;
  final Value<DateTime> logDate;
  final Value<int?> customerId;
  final Value<String?> customerName;
  final Value<int?> repairJobId;
  final Value<String?> jobNumber;
  final Value<String?> motorDetails;
  final Value<String> workPerformed;
  final Value<String?> partsUsed;
  final Value<double> labourCharges;
  final Value<double> paymentReceived;
  final Value<double> pendingAmount;
  final Value<String?> workStatus;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const DailyWorkLogsCompanion({
    this.id = const Value.absent(),
    this.logDate = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.repairJobId = const Value.absent(),
    this.jobNumber = const Value.absent(),
    this.motorDetails = const Value.absent(),
    this.workPerformed = const Value.absent(),
    this.partsUsed = const Value.absent(),
    this.labourCharges = const Value.absent(),
    this.paymentReceived = const Value.absent(),
    this.pendingAmount = const Value.absent(),
    this.workStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DailyWorkLogsCompanion.insert({
    this.id = const Value.absent(),
    this.logDate = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.repairJobId = const Value.absent(),
    this.jobNumber = const Value.absent(),
    this.motorDetails = const Value.absent(),
    required String workPerformed,
    this.partsUsed = const Value.absent(),
    this.labourCharges = const Value.absent(),
    this.paymentReceived = const Value.absent(),
    this.pendingAmount = const Value.absent(),
    this.workStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : workPerformed = Value(workPerformed);
  static Insertable<DailyWorkLog> custom({
    Expression<int>? id,
    Expression<DateTime>? logDate,
    Expression<int>? customerId,
    Expression<String>? customerName,
    Expression<int>? repairJobId,
    Expression<String>? jobNumber,
    Expression<String>? motorDetails,
    Expression<String>? workPerformed,
    Expression<String>? partsUsed,
    Expression<double>? labourCharges,
    Expression<double>? paymentReceived,
    Expression<double>? pendingAmount,
    Expression<String>? workStatus,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (logDate != null) 'log_date': logDate,
      if (customerId != null) 'customer_id': customerId,
      if (customerName != null) 'customer_name': customerName,
      if (repairJobId != null) 'repair_job_id': repairJobId,
      if (jobNumber != null) 'job_number': jobNumber,
      if (motorDetails != null) 'motor_details': motorDetails,
      if (workPerformed != null) 'work_performed': workPerformed,
      if (partsUsed != null) 'parts_used': partsUsed,
      if (labourCharges != null) 'labour_charges': labourCharges,
      if (paymentReceived != null) 'payment_received': paymentReceived,
      if (pendingAmount != null) 'pending_amount': pendingAmount,
      if (workStatus != null) 'work_status': workStatus,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DailyWorkLogsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? logDate,
    Value<int?>? customerId,
    Value<String?>? customerName,
    Value<int?>? repairJobId,
    Value<String?>? jobNumber,
    Value<String?>? motorDetails,
    Value<String>? workPerformed,
    Value<String?>? partsUsed,
    Value<double>? labourCharges,
    Value<double>? paymentReceived,
    Value<double>? pendingAmount,
    Value<String?>? workStatus,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
  }) {
    return DailyWorkLogsCompanion(
      id: id ?? this.id,
      logDate: logDate ?? this.logDate,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      repairJobId: repairJobId ?? this.repairJobId,
      jobNumber: jobNumber ?? this.jobNumber,
      motorDetails: motorDetails ?? this.motorDetails,
      workPerformed: workPerformed ?? this.workPerformed,
      partsUsed: partsUsed ?? this.partsUsed,
      labourCharges: labourCharges ?? this.labourCharges,
      paymentReceived: paymentReceived ?? this.paymentReceived,
      pendingAmount: pendingAmount ?? this.pendingAmount,
      workStatus: workStatus ?? this.workStatus,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (logDate.present) {
      map['log_date'] = Variable<DateTime>(logDate.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (repairJobId.present) {
      map['repair_job_id'] = Variable<int>(repairJobId.value);
    }
    if (jobNumber.present) {
      map['job_number'] = Variable<String>(jobNumber.value);
    }
    if (motorDetails.present) {
      map['motor_details'] = Variable<String>(motorDetails.value);
    }
    if (workPerformed.present) {
      map['work_performed'] = Variable<String>(workPerformed.value);
    }
    if (partsUsed.present) {
      map['parts_used'] = Variable<String>(partsUsed.value);
    }
    if (labourCharges.present) {
      map['labour_charges'] = Variable<double>(labourCharges.value);
    }
    if (paymentReceived.present) {
      map['payment_received'] = Variable<double>(paymentReceived.value);
    }
    if (pendingAmount.present) {
      map['pending_amount'] = Variable<double>(pendingAmount.value);
    }
    if (workStatus.present) {
      map['work_status'] = Variable<String>(workStatus.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyWorkLogsCompanion(')
          ..write('id: $id, ')
          ..write('logDate: $logDate, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('repairJobId: $repairJobId, ')
          ..write('jobNumber: $jobNumber, ')
          ..write('motorDetails: $motorDetails, ')
          ..write('workPerformed: $workPerformed, ')
          ..write('partsUsed: $partsUsed, ')
          ..write('labourCharges: $labourCharges, ')
          ..write('paymentReceived: $paymentReceived, ')
          ..write('pendingAmount: $pendingAmount, ')
          ..write('workStatus: $workStatus, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BusinessSettingsTable extends BusinessSettings
    with TableInfo<$BusinessSettingsTable, BusinessSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BusinessSettingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _shopNameMeta = const VerificationMeta(
    'shopName',
  );
  @override
  late final GeneratedColumn<String> shopName = GeneratedColumn<String>(
    'shop_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('प्रताप मोटर रिवाइंडिंग अँड सेल्स'),
  );
  static const VerificationMeta _ownerNameMeta = const VerificationMeta(
    'ownerName',
  );
  @override
  late final GeneratedColumn<String> ownerName = GeneratedColumn<String>(
    'owner_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('प्रोप्राईटर'),
  );
  static const VerificationMeta _shopAddressMeta = const VerificationMeta(
    'shopAddress',
  );
  @override
  late final GeneratedColumn<String> shopAddress = GeneratedColumn<String>(
    'shop_address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('फाकटे, तालुका शिरूर, जिल्हा पुणे'),
  );
  static const VerificationMeta _mobileNumberMeta = const VerificationMeta(
    'mobileNumber',
  );
  @override
  late final GeneratedColumn<String> mobileNumber = GeneratedColumn<String>(
    'mobile_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _alternateMobileMeta = const VerificationMeta(
    'alternateMobile',
  );
  @override
  late final GeneratedColumn<String> alternateMobile = GeneratedColumn<String>(
    'alternate_mobile',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gstinMeta = const VerificationMeta('gstin');
  @override
  late final GeneratedColumn<String> gstin = GeneratedColumn<String>(
    'gstin',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _invoicePrefixMeta = const VerificationMeta(
    'invoicePrefix',
  );
  @override
  late final GeneratedColumn<String> invoicePrefix = GeneratedColumn<String>(
    'invoice_prefix',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('INV-'),
  );
  static const VerificationMeta _jobPrefixMeta = const VerificationMeta(
    'jobPrefix',
  );
  @override
  late final GeneratedColumn<String> jobPrefix = GeneratedColumn<String>(
    'job_prefix',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('JOB-'),
  );
  static const VerificationMeta _defaultTaxRateMeta = const VerificationMeta(
    'defaultTaxRate',
  );
  @override
  late final GeneratedColumn<double> defaultTaxRate = GeneratedColumn<double>(
    'default_tax_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _isGstEnabledMeta = const VerificationMeta(
    'isGstEnabled',
  );
  @override
  late final GeneratedColumn<bool> isGstEnabled = GeneratedColumn<bool>(
    'is_gst_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_gst_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('₹'),
  );
  static const VerificationMeta _defaultLanguageMeta = const VerificationMeta(
    'defaultLanguage',
  );
  @override
  late final GeneratedColumn<String> defaultLanguage = GeneratedColumn<String>(
    'default_language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('mr_en'),
  );
  static const VerificationMeta _pdfFooterMeta = const VerificationMeta(
    'pdfFooter',
  );
  @override
  late final GeneratedColumn<String> pdfFooter = GeneratedColumn<String>(
    'pdf_footer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _warrantyTermsMeta = const VerificationMeta(
    'warrantyTerms',
  );
  @override
  late final GeneratedColumn<String> warrantyTerms = GeneratedColumn<String>(
    'warranty_terms',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentInstructionsMeta =
      const VerificationMeta('paymentInstructions');
  @override
  late final GeneratedColumn<String> paymentInstructions =
      GeneratedColumn<String>(
        'payment_instructions',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _autoBackupEnabledMeta = const VerificationMeta(
    'autoBackupEnabled',
  );
  @override
  late final GeneratedColumn<bool> autoBackupEnabled = GeneratedColumn<bool>(
    'auto_backup_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_backup_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _backupScheduleTimeMeta =
      const VerificationMeta('backupScheduleTime');
  @override
  late final GeneratedColumn<String> backupScheduleTime =
      GeneratedColumn<String>(
        'backup_schedule_time',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('22:00'),
      );
  static const VerificationMeta _backupRetentionCountMeta =
      const VerificationMeta('backupRetentionCount');
  @override
  late final GeneratedColumn<int> backupRetentionCount = GeneratedColumn<int>(
    'backup_retention_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(7),
  );
  static const VerificationMeta _lastBackupTimestampMeta =
      const VerificationMeta('lastBackupTimestamp');
  @override
  late final GeneratedColumn<DateTime> lastBackupTimestamp =
      GeneratedColumn<DateTime>(
        'last_backup_timestamp',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastBackupStatusMeta = const VerificationMeta(
    'lastBackupStatus',
  );
  @override
  late final GeneratedColumn<String> lastBackupStatus = GeneratedColumn<String>(
    'last_backup_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopName,
    ownerName,
    shopAddress,
    mobileNumber,
    alternateMobile,
    gstin,
    invoicePrefix,
    jobPrefix,
    defaultTaxRate,
    isGstEnabled,
    currency,
    defaultLanguage,
    pdfFooter,
    warrantyTerms,
    paymentInstructions,
    autoBackupEnabled,
    backupScheduleTime,
    backupRetentionCount,
    lastBackupTimestamp,
    lastBackupStatus,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'business_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<BusinessSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('shop_name')) {
      context.handle(
        _shopNameMeta,
        shopName.isAcceptableOrUnknown(data['shop_name']!, _shopNameMeta),
      );
    }
    if (data.containsKey('owner_name')) {
      context.handle(
        _ownerNameMeta,
        ownerName.isAcceptableOrUnknown(data['owner_name']!, _ownerNameMeta),
      );
    }
    if (data.containsKey('shop_address')) {
      context.handle(
        _shopAddressMeta,
        shopAddress.isAcceptableOrUnknown(
          data['shop_address']!,
          _shopAddressMeta,
        ),
      );
    }
    if (data.containsKey('mobile_number')) {
      context.handle(
        _mobileNumberMeta,
        mobileNumber.isAcceptableOrUnknown(
          data['mobile_number']!,
          _mobileNumberMeta,
        ),
      );
    }
    if (data.containsKey('alternate_mobile')) {
      context.handle(
        _alternateMobileMeta,
        alternateMobile.isAcceptableOrUnknown(
          data['alternate_mobile']!,
          _alternateMobileMeta,
        ),
      );
    }
    if (data.containsKey('gstin')) {
      context.handle(
        _gstinMeta,
        gstin.isAcceptableOrUnknown(data['gstin']!, _gstinMeta),
      );
    }
    if (data.containsKey('invoice_prefix')) {
      context.handle(
        _invoicePrefixMeta,
        invoicePrefix.isAcceptableOrUnknown(
          data['invoice_prefix']!,
          _invoicePrefixMeta,
        ),
      );
    }
    if (data.containsKey('job_prefix')) {
      context.handle(
        _jobPrefixMeta,
        jobPrefix.isAcceptableOrUnknown(data['job_prefix']!, _jobPrefixMeta),
      );
    }
    if (data.containsKey('default_tax_rate')) {
      context.handle(
        _defaultTaxRateMeta,
        defaultTaxRate.isAcceptableOrUnknown(
          data['default_tax_rate']!,
          _defaultTaxRateMeta,
        ),
      );
    }
    if (data.containsKey('is_gst_enabled')) {
      context.handle(
        _isGstEnabledMeta,
        isGstEnabled.isAcceptableOrUnknown(
          data['is_gst_enabled']!,
          _isGstEnabledMeta,
        ),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('default_language')) {
      context.handle(
        _defaultLanguageMeta,
        defaultLanguage.isAcceptableOrUnknown(
          data['default_language']!,
          _defaultLanguageMeta,
        ),
      );
    }
    if (data.containsKey('pdf_footer')) {
      context.handle(
        _pdfFooterMeta,
        pdfFooter.isAcceptableOrUnknown(data['pdf_footer']!, _pdfFooterMeta),
      );
    }
    if (data.containsKey('warranty_terms')) {
      context.handle(
        _warrantyTermsMeta,
        warrantyTerms.isAcceptableOrUnknown(
          data['warranty_terms']!,
          _warrantyTermsMeta,
        ),
      );
    }
    if (data.containsKey('payment_instructions')) {
      context.handle(
        _paymentInstructionsMeta,
        paymentInstructions.isAcceptableOrUnknown(
          data['payment_instructions']!,
          _paymentInstructionsMeta,
        ),
      );
    }
    if (data.containsKey('auto_backup_enabled')) {
      context.handle(
        _autoBackupEnabledMeta,
        autoBackupEnabled.isAcceptableOrUnknown(
          data['auto_backup_enabled']!,
          _autoBackupEnabledMeta,
        ),
      );
    }
    if (data.containsKey('backup_schedule_time')) {
      context.handle(
        _backupScheduleTimeMeta,
        backupScheduleTime.isAcceptableOrUnknown(
          data['backup_schedule_time']!,
          _backupScheduleTimeMeta,
        ),
      );
    }
    if (data.containsKey('backup_retention_count')) {
      context.handle(
        _backupRetentionCountMeta,
        backupRetentionCount.isAcceptableOrUnknown(
          data['backup_retention_count']!,
          _backupRetentionCountMeta,
        ),
      );
    }
    if (data.containsKey('last_backup_timestamp')) {
      context.handle(
        _lastBackupTimestampMeta,
        lastBackupTimestamp.isAcceptableOrUnknown(
          data['last_backup_timestamp']!,
          _lastBackupTimestampMeta,
        ),
      );
    }
    if (data.containsKey('last_backup_status')) {
      context.handle(
        _lastBackupStatusMeta,
        lastBackupStatus.isAcceptableOrUnknown(
          data['last_backup_status']!,
          _lastBackupStatusMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BusinessSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BusinessSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      shopName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_name'],
      )!,
      ownerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_name'],
      )!,
      shopAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_address'],
      )!,
      mobileNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mobile_number'],
      )!,
      alternateMobile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alternate_mobile'],
      ),
      gstin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gstin'],
      ),
      invoicePrefix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_prefix'],
      )!,
      jobPrefix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_prefix'],
      )!,
      defaultTaxRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_tax_rate'],
      )!,
      isGstEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_gst_enabled'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      defaultLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_language'],
      )!,
      pdfFooter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_footer'],
      ),
      warrantyTerms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}warranty_terms'],
      ),
      paymentInstructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_instructions'],
      ),
      autoBackupEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_backup_enabled'],
      )!,
      backupScheduleTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}backup_schedule_time'],
      )!,
      backupRetentionCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}backup_retention_count'],
      )!,
      lastBackupTimestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_backup_timestamp'],
      ),
      lastBackupStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_backup_status'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $BusinessSettingsTable createAlias(String alias) {
    return $BusinessSettingsTable(attachedDatabase, alias);
  }
}

class BusinessSetting extends DataClass implements Insertable<BusinessSetting> {
  final int id;
  final String shopName;
  final String ownerName;
  final String shopAddress;
  final String mobileNumber;
  final String? alternateMobile;
  final String? gstin;
  final String invoicePrefix;
  final String jobPrefix;
  final double defaultTaxRate;
  final bool isGstEnabled;
  final String currency;
  final String defaultLanguage;
  final String? pdfFooter;
  final String? warrantyTerms;
  final String? paymentInstructions;
  final bool autoBackupEnabled;
  final String backupScheduleTime;
  final int backupRetentionCount;
  final DateTime? lastBackupTimestamp;
  final String? lastBackupStatus;
  final DateTime? updatedAt;
  const BusinessSetting({
    required this.id,
    required this.shopName,
    required this.ownerName,
    required this.shopAddress,
    required this.mobileNumber,
    this.alternateMobile,
    this.gstin,
    required this.invoicePrefix,
    required this.jobPrefix,
    required this.defaultTaxRate,
    required this.isGstEnabled,
    required this.currency,
    required this.defaultLanguage,
    this.pdfFooter,
    this.warrantyTerms,
    this.paymentInstructions,
    required this.autoBackupEnabled,
    required this.backupScheduleTime,
    required this.backupRetentionCount,
    this.lastBackupTimestamp,
    this.lastBackupStatus,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['shop_name'] = Variable<String>(shopName);
    map['owner_name'] = Variable<String>(ownerName);
    map['shop_address'] = Variable<String>(shopAddress);
    map['mobile_number'] = Variable<String>(mobileNumber);
    if (!nullToAbsent || alternateMobile != null) {
      map['alternate_mobile'] = Variable<String>(alternateMobile);
    }
    if (!nullToAbsent || gstin != null) {
      map['gstin'] = Variable<String>(gstin);
    }
    map['invoice_prefix'] = Variable<String>(invoicePrefix);
    map['job_prefix'] = Variable<String>(jobPrefix);
    map['default_tax_rate'] = Variable<double>(defaultTaxRate);
    map['is_gst_enabled'] = Variable<bool>(isGstEnabled);
    map['currency'] = Variable<String>(currency);
    map['default_language'] = Variable<String>(defaultLanguage);
    if (!nullToAbsent || pdfFooter != null) {
      map['pdf_footer'] = Variable<String>(pdfFooter);
    }
    if (!nullToAbsent || warrantyTerms != null) {
      map['warranty_terms'] = Variable<String>(warrantyTerms);
    }
    if (!nullToAbsent || paymentInstructions != null) {
      map['payment_instructions'] = Variable<String>(paymentInstructions);
    }
    map['auto_backup_enabled'] = Variable<bool>(autoBackupEnabled);
    map['backup_schedule_time'] = Variable<String>(backupScheduleTime);
    map['backup_retention_count'] = Variable<int>(backupRetentionCount);
    if (!nullToAbsent || lastBackupTimestamp != null) {
      map['last_backup_timestamp'] = Variable<DateTime>(lastBackupTimestamp);
    }
    if (!nullToAbsent || lastBackupStatus != null) {
      map['last_backup_status'] = Variable<String>(lastBackupStatus);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  BusinessSettingsCompanion toCompanion(bool nullToAbsent) {
    return BusinessSettingsCompanion(
      id: Value(id),
      shopName: Value(shopName),
      ownerName: Value(ownerName),
      shopAddress: Value(shopAddress),
      mobileNumber: Value(mobileNumber),
      alternateMobile: alternateMobile == null && nullToAbsent
          ? const Value.absent()
          : Value(alternateMobile),
      gstin: gstin == null && nullToAbsent
          ? const Value.absent()
          : Value(gstin),
      invoicePrefix: Value(invoicePrefix),
      jobPrefix: Value(jobPrefix),
      defaultTaxRate: Value(defaultTaxRate),
      isGstEnabled: Value(isGstEnabled),
      currency: Value(currency),
      defaultLanguage: Value(defaultLanguage),
      pdfFooter: pdfFooter == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfFooter),
      warrantyTerms: warrantyTerms == null && nullToAbsent
          ? const Value.absent()
          : Value(warrantyTerms),
      paymentInstructions: paymentInstructions == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentInstructions),
      autoBackupEnabled: Value(autoBackupEnabled),
      backupScheduleTime: Value(backupScheduleTime),
      backupRetentionCount: Value(backupRetentionCount),
      lastBackupTimestamp: lastBackupTimestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBackupTimestamp),
      lastBackupStatus: lastBackupStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBackupStatus),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory BusinessSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BusinessSetting(
      id: serializer.fromJson<int>(json['id']),
      shopName: serializer.fromJson<String>(json['shopName']),
      ownerName: serializer.fromJson<String>(json['ownerName']),
      shopAddress: serializer.fromJson<String>(json['shopAddress']),
      mobileNumber: serializer.fromJson<String>(json['mobileNumber']),
      alternateMobile: serializer.fromJson<String?>(json['alternateMobile']),
      gstin: serializer.fromJson<String?>(json['gstin']),
      invoicePrefix: serializer.fromJson<String>(json['invoicePrefix']),
      jobPrefix: serializer.fromJson<String>(json['jobPrefix']),
      defaultTaxRate: serializer.fromJson<double>(json['defaultTaxRate']),
      isGstEnabled: serializer.fromJson<bool>(json['isGstEnabled']),
      currency: serializer.fromJson<String>(json['currency']),
      defaultLanguage: serializer.fromJson<String>(json['defaultLanguage']),
      pdfFooter: serializer.fromJson<String?>(json['pdfFooter']),
      warrantyTerms: serializer.fromJson<String?>(json['warrantyTerms']),
      paymentInstructions: serializer.fromJson<String?>(
        json['paymentInstructions'],
      ),
      autoBackupEnabled: serializer.fromJson<bool>(json['autoBackupEnabled']),
      backupScheduleTime: serializer.fromJson<String>(
        json['backupScheduleTime'],
      ),
      backupRetentionCount: serializer.fromJson<int>(
        json['backupRetentionCount'],
      ),
      lastBackupTimestamp: serializer.fromJson<DateTime?>(
        json['lastBackupTimestamp'],
      ),
      lastBackupStatus: serializer.fromJson<String?>(json['lastBackupStatus']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'shopName': serializer.toJson<String>(shopName),
      'ownerName': serializer.toJson<String>(ownerName),
      'shopAddress': serializer.toJson<String>(shopAddress),
      'mobileNumber': serializer.toJson<String>(mobileNumber),
      'alternateMobile': serializer.toJson<String?>(alternateMobile),
      'gstin': serializer.toJson<String?>(gstin),
      'invoicePrefix': serializer.toJson<String>(invoicePrefix),
      'jobPrefix': serializer.toJson<String>(jobPrefix),
      'defaultTaxRate': serializer.toJson<double>(defaultTaxRate),
      'isGstEnabled': serializer.toJson<bool>(isGstEnabled),
      'currency': serializer.toJson<String>(currency),
      'defaultLanguage': serializer.toJson<String>(defaultLanguage),
      'pdfFooter': serializer.toJson<String?>(pdfFooter),
      'warrantyTerms': serializer.toJson<String?>(warrantyTerms),
      'paymentInstructions': serializer.toJson<String?>(paymentInstructions),
      'autoBackupEnabled': serializer.toJson<bool>(autoBackupEnabled),
      'backupScheduleTime': serializer.toJson<String>(backupScheduleTime),
      'backupRetentionCount': serializer.toJson<int>(backupRetentionCount),
      'lastBackupTimestamp': serializer.toJson<DateTime?>(lastBackupTimestamp),
      'lastBackupStatus': serializer.toJson<String?>(lastBackupStatus),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  BusinessSetting copyWith({
    int? id,
    String? shopName,
    String? ownerName,
    String? shopAddress,
    String? mobileNumber,
    Value<String?> alternateMobile = const Value.absent(),
    Value<String?> gstin = const Value.absent(),
    String? invoicePrefix,
    String? jobPrefix,
    double? defaultTaxRate,
    bool? isGstEnabled,
    String? currency,
    String? defaultLanguage,
    Value<String?> pdfFooter = const Value.absent(),
    Value<String?> warrantyTerms = const Value.absent(),
    Value<String?> paymentInstructions = const Value.absent(),
    bool? autoBackupEnabled,
    String? backupScheduleTime,
    int? backupRetentionCount,
    Value<DateTime?> lastBackupTimestamp = const Value.absent(),
    Value<String?> lastBackupStatus = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => BusinessSetting(
    id: id ?? this.id,
    shopName: shopName ?? this.shopName,
    ownerName: ownerName ?? this.ownerName,
    shopAddress: shopAddress ?? this.shopAddress,
    mobileNumber: mobileNumber ?? this.mobileNumber,
    alternateMobile: alternateMobile.present
        ? alternateMobile.value
        : this.alternateMobile,
    gstin: gstin.present ? gstin.value : this.gstin,
    invoicePrefix: invoicePrefix ?? this.invoicePrefix,
    jobPrefix: jobPrefix ?? this.jobPrefix,
    defaultTaxRate: defaultTaxRate ?? this.defaultTaxRate,
    isGstEnabled: isGstEnabled ?? this.isGstEnabled,
    currency: currency ?? this.currency,
    defaultLanguage: defaultLanguage ?? this.defaultLanguage,
    pdfFooter: pdfFooter.present ? pdfFooter.value : this.pdfFooter,
    warrantyTerms: warrantyTerms.present
        ? warrantyTerms.value
        : this.warrantyTerms,
    paymentInstructions: paymentInstructions.present
        ? paymentInstructions.value
        : this.paymentInstructions,
    autoBackupEnabled: autoBackupEnabled ?? this.autoBackupEnabled,
    backupScheduleTime: backupScheduleTime ?? this.backupScheduleTime,
    backupRetentionCount: backupRetentionCount ?? this.backupRetentionCount,
    lastBackupTimestamp: lastBackupTimestamp.present
        ? lastBackupTimestamp.value
        : this.lastBackupTimestamp,
    lastBackupStatus: lastBackupStatus.present
        ? lastBackupStatus.value
        : this.lastBackupStatus,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  BusinessSetting copyWithCompanion(BusinessSettingsCompanion data) {
    return BusinessSetting(
      id: data.id.present ? data.id.value : this.id,
      shopName: data.shopName.present ? data.shopName.value : this.shopName,
      ownerName: data.ownerName.present ? data.ownerName.value : this.ownerName,
      shopAddress: data.shopAddress.present
          ? data.shopAddress.value
          : this.shopAddress,
      mobileNumber: data.mobileNumber.present
          ? data.mobileNumber.value
          : this.mobileNumber,
      alternateMobile: data.alternateMobile.present
          ? data.alternateMobile.value
          : this.alternateMobile,
      gstin: data.gstin.present ? data.gstin.value : this.gstin,
      invoicePrefix: data.invoicePrefix.present
          ? data.invoicePrefix.value
          : this.invoicePrefix,
      jobPrefix: data.jobPrefix.present ? data.jobPrefix.value : this.jobPrefix,
      defaultTaxRate: data.defaultTaxRate.present
          ? data.defaultTaxRate.value
          : this.defaultTaxRate,
      isGstEnabled: data.isGstEnabled.present
          ? data.isGstEnabled.value
          : this.isGstEnabled,
      currency: data.currency.present ? data.currency.value : this.currency,
      defaultLanguage: data.defaultLanguage.present
          ? data.defaultLanguage.value
          : this.defaultLanguage,
      pdfFooter: data.pdfFooter.present ? data.pdfFooter.value : this.pdfFooter,
      warrantyTerms: data.warrantyTerms.present
          ? data.warrantyTerms.value
          : this.warrantyTerms,
      paymentInstructions: data.paymentInstructions.present
          ? data.paymentInstructions.value
          : this.paymentInstructions,
      autoBackupEnabled: data.autoBackupEnabled.present
          ? data.autoBackupEnabled.value
          : this.autoBackupEnabled,
      backupScheduleTime: data.backupScheduleTime.present
          ? data.backupScheduleTime.value
          : this.backupScheduleTime,
      backupRetentionCount: data.backupRetentionCount.present
          ? data.backupRetentionCount.value
          : this.backupRetentionCount,
      lastBackupTimestamp: data.lastBackupTimestamp.present
          ? data.lastBackupTimestamp.value
          : this.lastBackupTimestamp,
      lastBackupStatus: data.lastBackupStatus.present
          ? data.lastBackupStatus.value
          : this.lastBackupStatus,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BusinessSetting(')
          ..write('id: $id, ')
          ..write('shopName: $shopName, ')
          ..write('ownerName: $ownerName, ')
          ..write('shopAddress: $shopAddress, ')
          ..write('mobileNumber: $mobileNumber, ')
          ..write('alternateMobile: $alternateMobile, ')
          ..write('gstin: $gstin, ')
          ..write('invoicePrefix: $invoicePrefix, ')
          ..write('jobPrefix: $jobPrefix, ')
          ..write('defaultTaxRate: $defaultTaxRate, ')
          ..write('isGstEnabled: $isGstEnabled, ')
          ..write('currency: $currency, ')
          ..write('defaultLanguage: $defaultLanguage, ')
          ..write('pdfFooter: $pdfFooter, ')
          ..write('warrantyTerms: $warrantyTerms, ')
          ..write('paymentInstructions: $paymentInstructions, ')
          ..write('autoBackupEnabled: $autoBackupEnabled, ')
          ..write('backupScheduleTime: $backupScheduleTime, ')
          ..write('backupRetentionCount: $backupRetentionCount, ')
          ..write('lastBackupTimestamp: $lastBackupTimestamp, ')
          ..write('lastBackupStatus: $lastBackupStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    shopName,
    ownerName,
    shopAddress,
    mobileNumber,
    alternateMobile,
    gstin,
    invoicePrefix,
    jobPrefix,
    defaultTaxRate,
    isGstEnabled,
    currency,
    defaultLanguage,
    pdfFooter,
    warrantyTerms,
    paymentInstructions,
    autoBackupEnabled,
    backupScheduleTime,
    backupRetentionCount,
    lastBackupTimestamp,
    lastBackupStatus,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BusinessSetting &&
          other.id == this.id &&
          other.shopName == this.shopName &&
          other.ownerName == this.ownerName &&
          other.shopAddress == this.shopAddress &&
          other.mobileNumber == this.mobileNumber &&
          other.alternateMobile == this.alternateMobile &&
          other.gstin == this.gstin &&
          other.invoicePrefix == this.invoicePrefix &&
          other.jobPrefix == this.jobPrefix &&
          other.defaultTaxRate == this.defaultTaxRate &&
          other.isGstEnabled == this.isGstEnabled &&
          other.currency == this.currency &&
          other.defaultLanguage == this.defaultLanguage &&
          other.pdfFooter == this.pdfFooter &&
          other.warrantyTerms == this.warrantyTerms &&
          other.paymentInstructions == this.paymentInstructions &&
          other.autoBackupEnabled == this.autoBackupEnabled &&
          other.backupScheduleTime == this.backupScheduleTime &&
          other.backupRetentionCount == this.backupRetentionCount &&
          other.lastBackupTimestamp == this.lastBackupTimestamp &&
          other.lastBackupStatus == this.lastBackupStatus &&
          other.updatedAt == this.updatedAt);
}

class BusinessSettingsCompanion extends UpdateCompanion<BusinessSetting> {
  final Value<int> id;
  final Value<String> shopName;
  final Value<String> ownerName;
  final Value<String> shopAddress;
  final Value<String> mobileNumber;
  final Value<String?> alternateMobile;
  final Value<String?> gstin;
  final Value<String> invoicePrefix;
  final Value<String> jobPrefix;
  final Value<double> defaultTaxRate;
  final Value<bool> isGstEnabled;
  final Value<String> currency;
  final Value<String> defaultLanguage;
  final Value<String?> pdfFooter;
  final Value<String?> warrantyTerms;
  final Value<String?> paymentInstructions;
  final Value<bool> autoBackupEnabled;
  final Value<String> backupScheduleTime;
  final Value<int> backupRetentionCount;
  final Value<DateTime?> lastBackupTimestamp;
  final Value<String?> lastBackupStatus;
  final Value<DateTime?> updatedAt;
  const BusinessSettingsCompanion({
    this.id = const Value.absent(),
    this.shopName = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.shopAddress = const Value.absent(),
    this.mobileNumber = const Value.absent(),
    this.alternateMobile = const Value.absent(),
    this.gstin = const Value.absent(),
    this.invoicePrefix = const Value.absent(),
    this.jobPrefix = const Value.absent(),
    this.defaultTaxRate = const Value.absent(),
    this.isGstEnabled = const Value.absent(),
    this.currency = const Value.absent(),
    this.defaultLanguage = const Value.absent(),
    this.pdfFooter = const Value.absent(),
    this.warrantyTerms = const Value.absent(),
    this.paymentInstructions = const Value.absent(),
    this.autoBackupEnabled = const Value.absent(),
    this.backupScheduleTime = const Value.absent(),
    this.backupRetentionCount = const Value.absent(),
    this.lastBackupTimestamp = const Value.absent(),
    this.lastBackupStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BusinessSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.shopName = const Value.absent(),
    this.ownerName = const Value.absent(),
    this.shopAddress = const Value.absent(),
    this.mobileNumber = const Value.absent(),
    this.alternateMobile = const Value.absent(),
    this.gstin = const Value.absent(),
    this.invoicePrefix = const Value.absent(),
    this.jobPrefix = const Value.absent(),
    this.defaultTaxRate = const Value.absent(),
    this.isGstEnabled = const Value.absent(),
    this.currency = const Value.absent(),
    this.defaultLanguage = const Value.absent(),
    this.pdfFooter = const Value.absent(),
    this.warrantyTerms = const Value.absent(),
    this.paymentInstructions = const Value.absent(),
    this.autoBackupEnabled = const Value.absent(),
    this.backupScheduleTime = const Value.absent(),
    this.backupRetentionCount = const Value.absent(),
    this.lastBackupTimestamp = const Value.absent(),
    this.lastBackupStatus = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<BusinessSetting> custom({
    Expression<int>? id,
    Expression<String>? shopName,
    Expression<String>? ownerName,
    Expression<String>? shopAddress,
    Expression<String>? mobileNumber,
    Expression<String>? alternateMobile,
    Expression<String>? gstin,
    Expression<String>? invoicePrefix,
    Expression<String>? jobPrefix,
    Expression<double>? defaultTaxRate,
    Expression<bool>? isGstEnabled,
    Expression<String>? currency,
    Expression<String>? defaultLanguage,
    Expression<String>? pdfFooter,
    Expression<String>? warrantyTerms,
    Expression<String>? paymentInstructions,
    Expression<bool>? autoBackupEnabled,
    Expression<String>? backupScheduleTime,
    Expression<int>? backupRetentionCount,
    Expression<DateTime>? lastBackupTimestamp,
    Expression<String>? lastBackupStatus,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopName != null) 'shop_name': shopName,
      if (ownerName != null) 'owner_name': ownerName,
      if (shopAddress != null) 'shop_address': shopAddress,
      if (mobileNumber != null) 'mobile_number': mobileNumber,
      if (alternateMobile != null) 'alternate_mobile': alternateMobile,
      if (gstin != null) 'gstin': gstin,
      if (invoicePrefix != null) 'invoice_prefix': invoicePrefix,
      if (jobPrefix != null) 'job_prefix': jobPrefix,
      if (defaultTaxRate != null) 'default_tax_rate': defaultTaxRate,
      if (isGstEnabled != null) 'is_gst_enabled': isGstEnabled,
      if (currency != null) 'currency': currency,
      if (defaultLanguage != null) 'default_language': defaultLanguage,
      if (pdfFooter != null) 'pdf_footer': pdfFooter,
      if (warrantyTerms != null) 'warranty_terms': warrantyTerms,
      if (paymentInstructions != null)
        'payment_instructions': paymentInstructions,
      if (autoBackupEnabled != null) 'auto_backup_enabled': autoBackupEnabled,
      if (backupScheduleTime != null)
        'backup_schedule_time': backupScheduleTime,
      if (backupRetentionCount != null)
        'backup_retention_count': backupRetentionCount,
      if (lastBackupTimestamp != null)
        'last_backup_timestamp': lastBackupTimestamp,
      if (lastBackupStatus != null) 'last_backup_status': lastBackupStatus,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BusinessSettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? shopName,
    Value<String>? ownerName,
    Value<String>? shopAddress,
    Value<String>? mobileNumber,
    Value<String?>? alternateMobile,
    Value<String?>? gstin,
    Value<String>? invoicePrefix,
    Value<String>? jobPrefix,
    Value<double>? defaultTaxRate,
    Value<bool>? isGstEnabled,
    Value<String>? currency,
    Value<String>? defaultLanguage,
    Value<String?>? pdfFooter,
    Value<String?>? warrantyTerms,
    Value<String?>? paymentInstructions,
    Value<bool>? autoBackupEnabled,
    Value<String>? backupScheduleTime,
    Value<int>? backupRetentionCount,
    Value<DateTime?>? lastBackupTimestamp,
    Value<String?>? lastBackupStatus,
    Value<DateTime?>? updatedAt,
  }) {
    return BusinessSettingsCompanion(
      id: id ?? this.id,
      shopName: shopName ?? this.shopName,
      ownerName: ownerName ?? this.ownerName,
      shopAddress: shopAddress ?? this.shopAddress,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      alternateMobile: alternateMobile ?? this.alternateMobile,
      gstin: gstin ?? this.gstin,
      invoicePrefix: invoicePrefix ?? this.invoicePrefix,
      jobPrefix: jobPrefix ?? this.jobPrefix,
      defaultTaxRate: defaultTaxRate ?? this.defaultTaxRate,
      isGstEnabled: isGstEnabled ?? this.isGstEnabled,
      currency: currency ?? this.currency,
      defaultLanguage: defaultLanguage ?? this.defaultLanguage,
      pdfFooter: pdfFooter ?? this.pdfFooter,
      warrantyTerms: warrantyTerms ?? this.warrantyTerms,
      paymentInstructions: paymentInstructions ?? this.paymentInstructions,
      autoBackupEnabled: autoBackupEnabled ?? this.autoBackupEnabled,
      backupScheduleTime: backupScheduleTime ?? this.backupScheduleTime,
      backupRetentionCount: backupRetentionCount ?? this.backupRetentionCount,
      lastBackupTimestamp: lastBackupTimestamp ?? this.lastBackupTimestamp,
      lastBackupStatus: lastBackupStatus ?? this.lastBackupStatus,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (shopName.present) {
      map['shop_name'] = Variable<String>(shopName.value);
    }
    if (ownerName.present) {
      map['owner_name'] = Variable<String>(ownerName.value);
    }
    if (shopAddress.present) {
      map['shop_address'] = Variable<String>(shopAddress.value);
    }
    if (mobileNumber.present) {
      map['mobile_number'] = Variable<String>(mobileNumber.value);
    }
    if (alternateMobile.present) {
      map['alternate_mobile'] = Variable<String>(alternateMobile.value);
    }
    if (gstin.present) {
      map['gstin'] = Variable<String>(gstin.value);
    }
    if (invoicePrefix.present) {
      map['invoice_prefix'] = Variable<String>(invoicePrefix.value);
    }
    if (jobPrefix.present) {
      map['job_prefix'] = Variable<String>(jobPrefix.value);
    }
    if (defaultTaxRate.present) {
      map['default_tax_rate'] = Variable<double>(defaultTaxRate.value);
    }
    if (isGstEnabled.present) {
      map['is_gst_enabled'] = Variable<bool>(isGstEnabled.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (defaultLanguage.present) {
      map['default_language'] = Variable<String>(defaultLanguage.value);
    }
    if (pdfFooter.present) {
      map['pdf_footer'] = Variable<String>(pdfFooter.value);
    }
    if (warrantyTerms.present) {
      map['warranty_terms'] = Variable<String>(warrantyTerms.value);
    }
    if (paymentInstructions.present) {
      map['payment_instructions'] = Variable<String>(paymentInstructions.value);
    }
    if (autoBackupEnabled.present) {
      map['auto_backup_enabled'] = Variable<bool>(autoBackupEnabled.value);
    }
    if (backupScheduleTime.present) {
      map['backup_schedule_time'] = Variable<String>(backupScheduleTime.value);
    }
    if (backupRetentionCount.present) {
      map['backup_retention_count'] = Variable<int>(backupRetentionCount.value);
    }
    if (lastBackupTimestamp.present) {
      map['last_backup_timestamp'] = Variable<DateTime>(
        lastBackupTimestamp.value,
      );
    }
    if (lastBackupStatus.present) {
      map['last_backup_status'] = Variable<String>(lastBackupStatus.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BusinessSettingsCompanion(')
          ..write('id: $id, ')
          ..write('shopName: $shopName, ')
          ..write('ownerName: $ownerName, ')
          ..write('shopAddress: $shopAddress, ')
          ..write('mobileNumber: $mobileNumber, ')
          ..write('alternateMobile: $alternateMobile, ')
          ..write('gstin: $gstin, ')
          ..write('invoicePrefix: $invoicePrefix, ')
          ..write('jobPrefix: $jobPrefix, ')
          ..write('defaultTaxRate: $defaultTaxRate, ')
          ..write('isGstEnabled: $isGstEnabled, ')
          ..write('currency: $currency, ')
          ..write('defaultLanguage: $defaultLanguage, ')
          ..write('pdfFooter: $pdfFooter, ')
          ..write('warrantyTerms: $warrantyTerms, ')
          ..write('paymentInstructions: $paymentInstructions, ')
          ..write('autoBackupEnabled: $autoBackupEnabled, ')
          ..write('backupScheduleTime: $backupScheduleTime, ')
          ..write('backupRetentionCount: $backupRetentionCount, ')
          ..write('lastBackupTimestamp: $lastBackupTimestamp, ')
          ..write('lastBackupStatus: $lastBackupStatus, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BackupHistoriesTable extends BackupHistories
    with TableInfo<$BackupHistoriesTable, BackupHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackupHistoriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _backupDateMeta = const VerificationMeta(
    'backupDate',
  );
  @override
  late final GeneratedColumn<DateTime> backupDate = GeneratedColumn<DateTime>(
    'backup_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileSizeMeta = const VerificationMeta(
    'fileSize',
  );
  @override
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
    'file_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _driveFileIdMeta = const VerificationMeta(
    'driveFileId',
  );
  @override
  late final GeneratedColumn<String> driveFileId = GeneratedColumn<String>(
    'drive_file_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _backupTypeMeta = const VerificationMeta(
    'backupType',
  );
  @override
  late final GeneratedColumn<String> backupType = GeneratedColumn<String>(
    'backup_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    backupDate,
    fileName,
    fileSize,
    driveFileId,
    backupType,
    status,
    errorMessage,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'backup_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<BackupHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('backup_date')) {
      context.handle(
        _backupDateMeta,
        backupDate.isAcceptableOrUnknown(data['backup_date']!, _backupDateMeta),
      );
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('file_size')) {
      context.handle(
        _fileSizeMeta,
        fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_fileSizeMeta);
    }
    if (data.containsKey('drive_file_id')) {
      context.handle(
        _driveFileIdMeta,
        driveFileId.isAcceptableOrUnknown(
          data['drive_file_id']!,
          _driveFileIdMeta,
        ),
      );
    }
    if (data.containsKey('backup_type')) {
      context.handle(
        _backupTypeMeta,
        backupType.isAcceptableOrUnknown(data['backup_type']!, _backupTypeMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BackupHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackupHistory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      backupDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}backup_date'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      fileSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size'],
      )!,
      driveFileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}drive_file_id'],
      ),
      backupType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}backup_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BackupHistoriesTable createAlias(String alias) {
    return $BackupHistoriesTable(attachedDatabase, alias);
  }
}

class BackupHistory extends DataClass implements Insertable<BackupHistory> {
  final int id;
  final DateTime backupDate;
  final String fileName;
  final int fileSize;
  final String? driveFileId;
  final String backupType;
  final String status;
  final String? errorMessage;
  final DateTime createdAt;
  const BackupHistory({
    required this.id,
    required this.backupDate,
    required this.fileName,
    required this.fileSize,
    this.driveFileId,
    required this.backupType,
    required this.status,
    this.errorMessage,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['backup_date'] = Variable<DateTime>(backupDate);
    map['file_name'] = Variable<String>(fileName);
    map['file_size'] = Variable<int>(fileSize);
    if (!nullToAbsent || driveFileId != null) {
      map['drive_file_id'] = Variable<String>(driveFileId);
    }
    map['backup_type'] = Variable<String>(backupType);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BackupHistoriesCompanion toCompanion(bool nullToAbsent) {
    return BackupHistoriesCompanion(
      id: Value(id),
      backupDate: Value(backupDate),
      fileName: Value(fileName),
      fileSize: Value(fileSize),
      driveFileId: driveFileId == null && nullToAbsent
          ? const Value.absent()
          : Value(driveFileId),
      backupType: Value(backupType),
      status: Value(status),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      createdAt: Value(createdAt),
    );
  }

  factory BackupHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackupHistory(
      id: serializer.fromJson<int>(json['id']),
      backupDate: serializer.fromJson<DateTime>(json['backupDate']),
      fileName: serializer.fromJson<String>(json['fileName']),
      fileSize: serializer.fromJson<int>(json['fileSize']),
      driveFileId: serializer.fromJson<String?>(json['driveFileId']),
      backupType: serializer.fromJson<String>(json['backupType']),
      status: serializer.fromJson<String>(json['status']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'backupDate': serializer.toJson<DateTime>(backupDate),
      'fileName': serializer.toJson<String>(fileName),
      'fileSize': serializer.toJson<int>(fileSize),
      'driveFileId': serializer.toJson<String?>(driveFileId),
      'backupType': serializer.toJson<String>(backupType),
      'status': serializer.toJson<String>(status),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BackupHistory copyWith({
    int? id,
    DateTime? backupDate,
    String? fileName,
    int? fileSize,
    Value<String?> driveFileId = const Value.absent(),
    String? backupType,
    String? status,
    Value<String?> errorMessage = const Value.absent(),
    DateTime? createdAt,
  }) => BackupHistory(
    id: id ?? this.id,
    backupDate: backupDate ?? this.backupDate,
    fileName: fileName ?? this.fileName,
    fileSize: fileSize ?? this.fileSize,
    driveFileId: driveFileId.present ? driveFileId.value : this.driveFileId,
    backupType: backupType ?? this.backupType,
    status: status ?? this.status,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    createdAt: createdAt ?? this.createdAt,
  );
  BackupHistory copyWithCompanion(BackupHistoriesCompanion data) {
    return BackupHistory(
      id: data.id.present ? data.id.value : this.id,
      backupDate: data.backupDate.present
          ? data.backupDate.value
          : this.backupDate,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      driveFileId: data.driveFileId.present
          ? data.driveFileId.value
          : this.driveFileId,
      backupType: data.backupType.present
          ? data.backupType.value
          : this.backupType,
      status: data.status.present ? data.status.value : this.status,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackupHistory(')
          ..write('id: $id, ')
          ..write('backupDate: $backupDate, ')
          ..write('fileName: $fileName, ')
          ..write('fileSize: $fileSize, ')
          ..write('driveFileId: $driveFileId, ')
          ..write('backupType: $backupType, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    backupDate,
    fileName,
    fileSize,
    driveFileId,
    backupType,
    status,
    errorMessage,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackupHistory &&
          other.id == this.id &&
          other.backupDate == this.backupDate &&
          other.fileName == this.fileName &&
          other.fileSize == this.fileSize &&
          other.driveFileId == this.driveFileId &&
          other.backupType == this.backupType &&
          other.status == this.status &&
          other.errorMessage == this.errorMessage &&
          other.createdAt == this.createdAt);
}

class BackupHistoriesCompanion extends UpdateCompanion<BackupHistory> {
  final Value<int> id;
  final Value<DateTime> backupDate;
  final Value<String> fileName;
  final Value<int> fileSize;
  final Value<String?> driveFileId;
  final Value<String> backupType;
  final Value<String> status;
  final Value<String?> errorMessage;
  final Value<DateTime> createdAt;
  const BackupHistoriesCompanion({
    this.id = const Value.absent(),
    this.backupDate = const Value.absent(),
    this.fileName = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.driveFileId = const Value.absent(),
    this.backupType = const Value.absent(),
    this.status = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BackupHistoriesCompanion.insert({
    this.id = const Value.absent(),
    this.backupDate = const Value.absent(),
    required String fileName,
    required int fileSize,
    this.driveFileId = const Value.absent(),
    this.backupType = const Value.absent(),
    required String status,
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : fileName = Value(fileName),
       fileSize = Value(fileSize),
       status = Value(status);
  static Insertable<BackupHistory> custom({
    Expression<int>? id,
    Expression<DateTime>? backupDate,
    Expression<String>? fileName,
    Expression<int>? fileSize,
    Expression<String>? driveFileId,
    Expression<String>? backupType,
    Expression<String>? status,
    Expression<String>? errorMessage,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (backupDate != null) 'backup_date': backupDate,
      if (fileName != null) 'file_name': fileName,
      if (fileSize != null) 'file_size': fileSize,
      if (driveFileId != null) 'drive_file_id': driveFileId,
      if (backupType != null) 'backup_type': backupType,
      if (status != null) 'status': status,
      if (errorMessage != null) 'error_message': errorMessage,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BackupHistoriesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? backupDate,
    Value<String>? fileName,
    Value<int>? fileSize,
    Value<String?>? driveFileId,
    Value<String>? backupType,
    Value<String>? status,
    Value<String?>? errorMessage,
    Value<DateTime>? createdAt,
  }) {
    return BackupHistoriesCompanion(
      id: id ?? this.id,
      backupDate: backupDate ?? this.backupDate,
      fileName: fileName ?? this.fileName,
      fileSize: fileSize ?? this.fileSize,
      driveFileId: driveFileId ?? this.driveFileId,
      backupType: backupType ?? this.backupType,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (backupDate.present) {
      map['backup_date'] = Variable<DateTime>(backupDate.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    if (driveFileId.present) {
      map['drive_file_id'] = Variable<String>(driveFileId.value);
    }
    if (backupType.present) {
      map['backup_type'] = Variable<String>(backupType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackupHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('backupDate: $backupDate, ')
          ..write('fileName: $fileName, ')
          ..write('fileSize: $fileSize, ')
          ..write('driveFileId: $driveFileId, ')
          ..write('backupType: $backupType, ')
          ..write('status: $status, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $JobStatusHistoriesTable extends JobStatusHistories
    with TableInfo<$JobStatusHistoriesTable, JobStatusHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobStatusHistoriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _repairJobIdMeta = const VerificationMeta(
    'repairJobId',
  );
  @override
  late final GeneratedColumn<int> repairJobId = GeneratedColumn<int>(
    'repair_job_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES repair_jobs (id)',
    ),
  );
  static const VerificationMeta _fromStatusMeta = const VerificationMeta(
    'fromStatus',
  );
  @override
  late final GeneratedColumn<String> fromStatus = GeneratedColumn<String>(
    'from_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _toStatusMeta = const VerificationMeta(
    'toStatus',
  );
  @override
  late final GeneratedColumn<String> toStatus = GeneratedColumn<String>(
    'to_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _changedAtMeta = const VerificationMeta(
    'changedAt',
  );
  @override
  late final GeneratedColumn<DateTime> changedAt = GeneratedColumn<DateTime>(
    'changed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    repairJobId,
    fromStatus,
    toStatus,
    notes,
    changedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'job_status_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<JobStatusHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('repair_job_id')) {
      context.handle(
        _repairJobIdMeta,
        repairJobId.isAcceptableOrUnknown(
          data['repair_job_id']!,
          _repairJobIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_repairJobIdMeta);
    }
    if (data.containsKey('from_status')) {
      context.handle(
        _fromStatusMeta,
        fromStatus.isAcceptableOrUnknown(data['from_status']!, _fromStatusMeta),
      );
    }
    if (data.containsKey('to_status')) {
      context.handle(
        _toStatusMeta,
        toStatus.isAcceptableOrUnknown(data['to_status']!, _toStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_toStatusMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('changed_at')) {
      context.handle(
        _changedAtMeta,
        changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JobStatusHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobStatusHistory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      repairJobId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repair_job_id'],
      )!,
      fromStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_status'],
      ),
      toStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      changedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}changed_at'],
      )!,
    );
  }

  @override
  $JobStatusHistoriesTable createAlias(String alias) {
    return $JobStatusHistoriesTable(attachedDatabase, alias);
  }
}

class JobStatusHistory extends DataClass
    implements Insertable<JobStatusHistory> {
  final int id;
  final int repairJobId;
  final String? fromStatus;
  final String toStatus;
  final String? notes;
  final DateTime changedAt;
  const JobStatusHistory({
    required this.id,
    required this.repairJobId,
    this.fromStatus,
    required this.toStatus,
    this.notes,
    required this.changedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['repair_job_id'] = Variable<int>(repairJobId);
    if (!nullToAbsent || fromStatus != null) {
      map['from_status'] = Variable<String>(fromStatus);
    }
    map['to_status'] = Variable<String>(toStatus);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['changed_at'] = Variable<DateTime>(changedAt);
    return map;
  }

  JobStatusHistoriesCompanion toCompanion(bool nullToAbsent) {
    return JobStatusHistoriesCompanion(
      id: Value(id),
      repairJobId: Value(repairJobId),
      fromStatus: fromStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(fromStatus),
      toStatus: Value(toStatus),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      changedAt: Value(changedAt),
    );
  }

  factory JobStatusHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JobStatusHistory(
      id: serializer.fromJson<int>(json['id']),
      repairJobId: serializer.fromJson<int>(json['repairJobId']),
      fromStatus: serializer.fromJson<String?>(json['fromStatus']),
      toStatus: serializer.fromJson<String>(json['toStatus']),
      notes: serializer.fromJson<String?>(json['notes']),
      changedAt: serializer.fromJson<DateTime>(json['changedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'repairJobId': serializer.toJson<int>(repairJobId),
      'fromStatus': serializer.toJson<String?>(fromStatus),
      'toStatus': serializer.toJson<String>(toStatus),
      'notes': serializer.toJson<String?>(notes),
      'changedAt': serializer.toJson<DateTime>(changedAt),
    };
  }

  JobStatusHistory copyWith({
    int? id,
    int? repairJobId,
    Value<String?> fromStatus = const Value.absent(),
    String? toStatus,
    Value<String?> notes = const Value.absent(),
    DateTime? changedAt,
  }) => JobStatusHistory(
    id: id ?? this.id,
    repairJobId: repairJobId ?? this.repairJobId,
    fromStatus: fromStatus.present ? fromStatus.value : this.fromStatus,
    toStatus: toStatus ?? this.toStatus,
    notes: notes.present ? notes.value : this.notes,
    changedAt: changedAt ?? this.changedAt,
  );
  JobStatusHistory copyWithCompanion(JobStatusHistoriesCompanion data) {
    return JobStatusHistory(
      id: data.id.present ? data.id.value : this.id,
      repairJobId: data.repairJobId.present
          ? data.repairJobId.value
          : this.repairJobId,
      fromStatus: data.fromStatus.present
          ? data.fromStatus.value
          : this.fromStatus,
      toStatus: data.toStatus.present ? data.toStatus.value : this.toStatus,
      notes: data.notes.present ? data.notes.value : this.notes,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JobStatusHistory(')
          ..write('id: $id, ')
          ..write('repairJobId: $repairJobId, ')
          ..write('fromStatus: $fromStatus, ')
          ..write('toStatus: $toStatus, ')
          ..write('notes: $notes, ')
          ..write('changedAt: $changedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, repairJobId, fromStatus, toStatus, notes, changedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobStatusHistory &&
          other.id == this.id &&
          other.repairJobId == this.repairJobId &&
          other.fromStatus == this.fromStatus &&
          other.toStatus == this.toStatus &&
          other.notes == this.notes &&
          other.changedAt == this.changedAt);
}

class JobStatusHistoriesCompanion extends UpdateCompanion<JobStatusHistory> {
  final Value<int> id;
  final Value<int> repairJobId;
  final Value<String?> fromStatus;
  final Value<String> toStatus;
  final Value<String?> notes;
  final Value<DateTime> changedAt;
  const JobStatusHistoriesCompanion({
    this.id = const Value.absent(),
    this.repairJobId = const Value.absent(),
    this.fromStatus = const Value.absent(),
    this.toStatus = const Value.absent(),
    this.notes = const Value.absent(),
    this.changedAt = const Value.absent(),
  });
  JobStatusHistoriesCompanion.insert({
    this.id = const Value.absent(),
    required int repairJobId,
    this.fromStatus = const Value.absent(),
    required String toStatus,
    this.notes = const Value.absent(),
    this.changedAt = const Value.absent(),
  }) : repairJobId = Value(repairJobId),
       toStatus = Value(toStatus);
  static Insertable<JobStatusHistory> custom({
    Expression<int>? id,
    Expression<int>? repairJobId,
    Expression<String>? fromStatus,
    Expression<String>? toStatus,
    Expression<String>? notes,
    Expression<DateTime>? changedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (repairJobId != null) 'repair_job_id': repairJobId,
      if (fromStatus != null) 'from_status': fromStatus,
      if (toStatus != null) 'to_status': toStatus,
      if (notes != null) 'notes': notes,
      if (changedAt != null) 'changed_at': changedAt,
    });
  }

  JobStatusHistoriesCompanion copyWith({
    Value<int>? id,
    Value<int>? repairJobId,
    Value<String?>? fromStatus,
    Value<String>? toStatus,
    Value<String?>? notes,
    Value<DateTime>? changedAt,
  }) {
    return JobStatusHistoriesCompanion(
      id: id ?? this.id,
      repairJobId: repairJobId ?? this.repairJobId,
      fromStatus: fromStatus ?? this.fromStatus,
      toStatus: toStatus ?? this.toStatus,
      notes: notes ?? this.notes,
      changedAt: changedAt ?? this.changedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (repairJobId.present) {
      map['repair_job_id'] = Variable<int>(repairJobId.value);
    }
    if (fromStatus.present) {
      map['from_status'] = Variable<String>(fromStatus.value);
    }
    if (toStatus.present) {
      map['to_status'] = Variable<String>(toStatus.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<DateTime>(changedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobStatusHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('repairJobId: $repairJobId, ')
          ..write('fromStatus: $fromStatus, ')
          ..write('toStatus: $toStatus, ')
          ..write('notes: $notes, ')
          ..write('changedAt: $changedAt')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _expenseDateMeta = const VerificationMeta(
    'expenseDate',
  );
  @override
  late final GeneratedColumn<DateTime> expenseDate = GeneratedColumn<DateTime>(
    'expense_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
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
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentModeMeta = const VerificationMeta(
    'paymentMode',
  );
  @override
  late final GeneratedColumn<String> paymentMode = GeneratedColumn<String>(
    'payment_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('cash'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    expenseDate,
    category,
    amount,
    paymentMode,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('expense_date')) {
      context.handle(
        _expenseDateMeta,
        expenseDate.isAcceptableOrUnknown(
          data['expense_date']!,
          _expenseDateMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_mode')) {
      context.handle(
        _paymentModeMeta,
        paymentMode.isAcceptableOrUnknown(
          data['payment_mode']!,
          _paymentModeMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      expenseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expense_date'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      paymentMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_mode'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final DateTime expenseDate;
  final String category;
  final double amount;
  final String paymentMode;
  final String? notes;
  final DateTime createdAt;
  const Expense({
    required this.id,
    required this.expenseDate,
    required this.category,
    required this.amount,
    required this.paymentMode,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['expense_date'] = Variable<DateTime>(expenseDate);
    map['category'] = Variable<String>(category);
    map['amount'] = Variable<double>(amount);
    map['payment_mode'] = Variable<String>(paymentMode);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      expenseDate: Value(expenseDate),
      category: Value(category),
      amount: Value(amount),
      paymentMode: Value(paymentMode),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      expenseDate: serializer.fromJson<DateTime>(json['expenseDate']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentMode: serializer.fromJson<String>(json['paymentMode']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'expenseDate': serializer.toJson<DateTime>(expenseDate),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<double>(amount),
      'paymentMode': serializer.toJson<String>(paymentMode),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Expense copyWith({
    int? id,
    DateTime? expenseDate,
    String? category,
    double? amount,
    String? paymentMode,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => Expense(
    id: id ?? this.id,
    expenseDate: expenseDate ?? this.expenseDate,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    paymentMode: paymentMode ?? this.paymentMode,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      expenseDate: data.expenseDate.present
          ? data.expenseDate.value
          : this.expenseDate,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentMode: data.paymentMode.present
          ? data.paymentMode.value
          : this.paymentMode,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    expenseDate,
    category,
    amount,
    paymentMode,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.expenseDate == this.expenseDate &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.paymentMode == this.paymentMode &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<DateTime> expenseDate;
  final Value<String> category;
  final Value<double> amount;
  final Value<String> paymentMode;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.expenseDate = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentMode = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    this.expenseDate = const Value.absent(),
    required String category,
    required double amount,
    this.paymentMode = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : category = Value(category),
       amount = Value(amount);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<DateTime>? expenseDate,
    Expression<String>? category,
    Expression<double>? amount,
    Expression<String>? paymentMode,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (expenseDate != null) 'expense_date': expenseDate,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (paymentMode != null) 'payment_mode': paymentMode,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExpensesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? expenseDate,
    Value<String>? category,
    Value<double>? amount,
    Value<String>? paymentMode,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      expenseDate: expenseDate ?? this.expenseDate,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      paymentMode: paymentMode ?? this.paymentMode,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (expenseDate.present) {
      map['expense_date'] = Variable<DateTime>(expenseDate.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentMode.present) {
      map['payment_mode'] = Variable<String>(paymentMode.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('expenseDate: $expenseDate, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTable extends AuditLogs
    with TableInfo<$AuditLogsTable, AuditLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetEntityMeta = const VerificationMeta(
    'targetEntity',
  );
  @override
  late final GeneratedColumn<String> targetEntity = GeneratedColumn<String>(
    'target_entity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<int> entityId = GeneratedColumn<int>(
    'entity_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    action,
    targetEntity,
    entityId,
    details,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('target_entity')) {
      context.handle(
        _targetEntityMeta,
        targetEntity.isAcceptableOrUnknown(
          data['target_entity']!,
          _targetEntityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetEntityMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      targetEntity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_entity'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entity_id'],
      ),
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditLog extends DataClass implements Insertable<AuditLog> {
  final int id;
  final String action;
  final String targetEntity;
  final int? entityId;
  final String? details;
  final DateTime createdAt;
  const AuditLog({
    required this.id,
    required this.action,
    required this.targetEntity,
    this.entityId,
    this.details,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['action'] = Variable<String>(action);
    map['target_entity'] = Variable<String>(targetEntity);
    if (!nullToAbsent || entityId != null) {
      map['entity_id'] = Variable<int>(entityId);
    }
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String>(details);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      action: Value(action),
      targetEntity: Value(targetEntity),
      entityId: entityId == null && nullToAbsent
          ? const Value.absent()
          : Value(entityId),
      details: details == null && nullToAbsent
          ? const Value.absent()
          : Value(details),
      createdAt: Value(createdAt),
    );
  }

  factory AuditLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLog(
      id: serializer.fromJson<int>(json['id']),
      action: serializer.fromJson<String>(json['action']),
      targetEntity: serializer.fromJson<String>(json['targetEntity']),
      entityId: serializer.fromJson<int?>(json['entityId']),
      details: serializer.fromJson<String?>(json['details']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'action': serializer.toJson<String>(action),
      'targetEntity': serializer.toJson<String>(targetEntity),
      'entityId': serializer.toJson<int?>(entityId),
      'details': serializer.toJson<String?>(details),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AuditLog copyWith({
    int? id,
    String? action,
    String? targetEntity,
    Value<int?> entityId = const Value.absent(),
    Value<String?> details = const Value.absent(),
    DateTime? createdAt,
  }) => AuditLog(
    id: id ?? this.id,
    action: action ?? this.action,
    targetEntity: targetEntity ?? this.targetEntity,
    entityId: entityId.present ? entityId.value : this.entityId,
    details: details.present ? details.value : this.details,
    createdAt: createdAt ?? this.createdAt,
  );
  AuditLog copyWithCompanion(AuditLogsCompanion data) {
    return AuditLog(
      id: data.id.present ? data.id.value : this.id,
      action: data.action.present ? data.action.value : this.action,
      targetEntity: data.targetEntity.present
          ? data.targetEntity.value
          : this.targetEntity,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      details: data.details.present ? data.details.value : this.details,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLog(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('targetEntity: $targetEntity, ')
          ..write('entityId: $entityId, ')
          ..write('details: $details, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, action, targetEntity, entityId, details, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLog &&
          other.id == this.id &&
          other.action == this.action &&
          other.targetEntity == this.targetEntity &&
          other.entityId == this.entityId &&
          other.details == this.details &&
          other.createdAt == this.createdAt);
}

class AuditLogsCompanion extends UpdateCompanion<AuditLog> {
  final Value<int> id;
  final Value<String> action;
  final Value<String> targetEntity;
  final Value<int?> entityId;
  final Value<String?> details;
  final Value<DateTime> createdAt;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.action = const Value.absent(),
    this.targetEntity = const Value.absent(),
    this.entityId = const Value.absent(),
    this.details = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    this.id = const Value.absent(),
    required String action,
    required String targetEntity,
    this.entityId = const Value.absent(),
    this.details = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : action = Value(action),
       targetEntity = Value(targetEntity);
  static Insertable<AuditLog> custom({
    Expression<int>? id,
    Expression<String>? action,
    Expression<String>? targetEntity,
    Expression<int>? entityId,
    Expression<String>? details,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (action != null) 'action': action,
      if (targetEntity != null) 'target_entity': targetEntity,
      if (entityId != null) 'entity_id': entityId,
      if (details != null) 'details': details,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AuditLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? action,
    Value<String>? targetEntity,
    Value<int?>? entityId,
    Value<String?>? details,
    Value<DateTime>? createdAt,
  }) {
    return AuditLogsCompanion(
      id: id ?? this.id,
      action: action ?? this.action,
      targetEntity: targetEntity ?? this.targetEntity,
      entityId: entityId ?? this.entityId,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (targetEntity.present) {
      map['target_entity'] = Variable<String>(targetEntity.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<int>(entityId.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('action: $action, ')
          ..write('targetEntity: $targetEntity, ')
          ..write('entityId: $entityId, ')
          ..write('details: $details, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $ProductCategoriesTable productCategories =
      $ProductCategoriesTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $RepairJobsTable repairJobs = $RepairJobsTable(this);
  late final $RepairJobPartsTable repairJobParts = $RepairJobPartsTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $InvoiceItemsTable invoiceItems = $InvoiceItemsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $StockMovementsTable stockMovements = $StockMovementsTable(this);
  late final $DailyWorkLogsTable dailyWorkLogs = $DailyWorkLogsTable(this);
  late final $BusinessSettingsTable businessSettings = $BusinessSettingsTable(
    this,
  );
  late final $BackupHistoriesTable backupHistories = $BackupHistoriesTable(
    this,
  );
  late final $JobStatusHistoriesTable jobStatusHistories =
      $JobStatusHistoriesTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    customers,
    productCategories,
    products,
    repairJobs,
    repairJobParts,
    invoices,
    invoiceItems,
    payments,
    stockMovements,
    dailyWorkLogs,
    businessSettings,
    backupHistories,
    jobStatusHistories,
    expenses,
    auditLogs,
  ];
}

typedef $$CustomersTableCreateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      required String name,
      required String mobile,
      Value<String?> alternateMobile,
      Value<String?> address,
      Value<String?> villageCity,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<bool> isDeleted,
    });
typedef $$CustomersTableUpdateCompanionBuilder =
    CustomersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> mobile,
      Value<String?> alternateMobile,
      Value<String?> address,
      Value<String?> villageCity,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<bool> isDeleted,
    });

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RepairJobsTable, List<RepairJob>>
  _repairJobsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.repairJobs,
    aliasName: $_aliasNameGenerator(db.customers.id, db.repairJobs.customerId),
  );

  $$RepairJobsTableProcessedTableManager get repairJobsRefs {
    final manager = $$RepairJobsTableTableManager(
      $_db,
      $_db.repairJobs,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_repairJobsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: $_aliasNameGenerator(db.customers.id, db.invoices.customerId),
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: $_aliasNameGenerator(db.customers.id, db.payments.customerId),
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DailyWorkLogsTable, List<DailyWorkLog>>
  _dailyWorkLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dailyWorkLogs,
    aliasName: $_aliasNameGenerator(
      db.customers.id,
      db.dailyWorkLogs.customerId,
    ),
  );

  $$DailyWorkLogsTableProcessedTableManager get dailyWorkLogsRefs {
    final manager = $$DailyWorkLogsTableTableManager(
      $_db,
      $_db.dailyWorkLogs,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dailyWorkLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
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

  ColumnFilters<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alternateMobile => $composableBuilder(
    column: $table.alternateMobile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get villageCity => $composableBuilder(
    column: $table.villageCity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> repairJobsRefs(
    Expression<bool> Function($$RepairJobsTableFilterComposer f) f,
  ) {
    final $$RepairJobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableFilterComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> dailyWorkLogsRefs(
    Expression<bool> Function($$DailyWorkLogsTableFilterComposer f) f,
  ) {
    final $$DailyWorkLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyWorkLogs,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyWorkLogsTableFilterComposer(
            $db: $db,
            $table: $db.dailyWorkLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
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

  ColumnOrderings<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alternateMobile => $composableBuilder(
    column: $table.alternateMobile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get villageCity => $composableBuilder(
    column: $table.villageCity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
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

  GeneratedColumn<String> get mobile =>
      $composableBuilder(column: $table.mobile, builder: (column) => column);

  GeneratedColumn<String> get alternateMobile => $composableBuilder(
    column: $table.alternateMobile,
    builder: (column) => column,
  );

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get villageCity => $composableBuilder(
    column: $table.villageCity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  Expression<T> repairJobsRefs<T extends Object>(
    Expression<T> Function($$RepairJobsTableAnnotationComposer a) f,
  ) {
    final $$RepairJobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableAnnotationComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> dailyWorkLogsRefs<T extends Object>(
    Expression<T> Function($$DailyWorkLogsTableAnnotationComposer a) f,
  ) {
    final $$DailyWorkLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyWorkLogs,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyWorkLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyWorkLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, $$CustomersTableReferences),
          Customer,
          PrefetchHooks Function({
            bool repairJobsRefs,
            bool invoicesRefs,
            bool paymentsRefs,
            bool dailyWorkLogsRefs,
          })
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> mobile = const Value.absent(),
                Value<String?> alternateMobile = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> villageCity = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                name: name,
                mobile: mobile,
                alternateMobile: alternateMobile,
                address: address,
                villageCity: villageCity,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String mobile,
                Value<String?> alternateMobile = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> villageCity = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                name: name,
                mobile: mobile,
                alternateMobile: alternateMobile,
                address: address,
                villageCity: villageCity,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                repairJobsRefs = false,
                invoicesRefs = false,
                paymentsRefs = false,
                dailyWorkLogsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (repairJobsRefs) db.repairJobs,
                    if (invoicesRefs) db.invoices,
                    if (paymentsRefs) db.payments,
                    if (dailyWorkLogsRefs) db.dailyWorkLogs,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (repairJobsRefs)
                        await $_getPrefetchedData(
                          currentTable: table,
                          referencedTable: $$CustomersTableReferences
                              ._repairJobsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).repairJobsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoicesRefs)
                        await $_getPrefetchedData(
                          currentTable: table,
                          referencedTable: $$CustomersTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentsRefs)
                        await $_getPrefetchedData(
                          currentTable: table,
                          referencedTable: $$CustomersTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (dailyWorkLogsRefs)
                        await $_getPrefetchedData(
                          currentTable: table,
                          referencedTable: $$CustomersTableReferences
                              ._dailyWorkLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CustomersTableReferences(
                                db,
                                table,
                                p0,
                              ).dailyWorkLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.customerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, $$CustomersTableReferences),
      Customer,
      PrefetchHooks Function({
        bool repairJobsRefs,
        bool invoicesRefs,
        bool paymentsRefs,
        bool dailyWorkLogsRefs,
      })
    >;
typedef $$ProductCategoriesTableCreateCompanionBuilder =
    ProductCategoriesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      Value<DateTime> createdAt,
    });
typedef $$ProductCategoriesTableUpdateCompanionBuilder =
    ProductCategoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<DateTime> createdAt,
    });

final class $$ProductCategoriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProductCategoriesTable,
          ProductCategory
        > {
  $$ProductCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ProductsTable, List<Product>> _productsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.products,
    aliasName: $_aliasNameGenerator(
      db.productCategories.id,
      db.products.categoryId,
    ),
  );

  $$ProductsTableProcessedTableManager get productsRefs {
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductCategoriesTable> {
  $$ProductCategoriesTableFilterComposer({
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

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productsRefs(
    Expression<bool> Function($$ProductsTableFilterComposer f) f,
  ) {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductCategoriesTable> {
  $$ProductCategoriesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductCategoriesTable> {
  $$ProductCategoriesTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> productsRefs<T extends Object>(
    Expression<T> Function($$ProductsTableAnnotationComposer a) f,
  ) {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductCategoriesTable,
          ProductCategory,
          $$ProductCategoriesTableFilterComposer,
          $$ProductCategoriesTableOrderingComposer,
          $$ProductCategoriesTableAnnotationComposer,
          $$ProductCategoriesTableCreateCompanionBuilder,
          $$ProductCategoriesTableUpdateCompanionBuilder,
          (ProductCategory, $$ProductCategoriesTableReferences),
          ProductCategory,
          PrefetchHooks Function({bool productsRefs})
        > {
  $$ProductCategoriesTableTableManager(
    _$AppDatabase db,
    $ProductCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductCategoriesCompanion(
                id: id,
                name: name,
                description: description,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ProductCategoriesCompanion.insert(
                id: id,
                name: name,
                description: description,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (productsRefs) db.products],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productsRefs)
                    await $_getPrefetchedData(
                      currentTable: table,
                      referencedTable: $$ProductCategoriesTableReferences
                          ._productsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ProductCategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).productsRefs,
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

typedef $$ProductCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductCategoriesTable,
      ProductCategory,
      $$ProductCategoriesTableFilterComposer,
      $$ProductCategoriesTableOrderingComposer,
      $$ProductCategoriesTableAnnotationComposer,
      $$ProductCategoriesTableCreateCompanionBuilder,
      $$ProductCategoriesTableUpdateCompanionBuilder,
      (ProductCategory, $$ProductCategoriesTableReferences),
      ProductCategory,
      PrefetchHooks Function({bool productsRefs})
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      required String name,
      Value<int?> categoryId,
      Value<String?> brand,
      Value<String?> modelNumber,
      Value<String?> hp,
      Value<String?> description,
      Value<double> purchasePrice,
      Value<double> sellingPrice,
      Value<double> currentStock,
      Value<double> minimumStockLevel,
      Value<String> unit,
      Value<bool> isDeleted,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int?> categoryId,
      Value<String?> brand,
      Value<String?> modelNumber,
      Value<String?> hp,
      Value<String?> description,
      Value<double> purchasePrice,
      Value<double> sellingPrice,
      Value<double> currentStock,
      Value<double> minimumStockLevel,
      Value<String> unit,
      Value<bool> isDeleted,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductCategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.productCategories.createAlias(
        $_aliasNameGenerator(db.products.categoryId, db.productCategories.id),
      );

  $$ProductCategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$ProductCategoriesTableTableManager(
      $_db,
      $_db.productCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RepairJobPartsTable, List<RepairJobPart>>
  _repairJobPartsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.repairJobParts,
    aliasName: $_aliasNameGenerator(
      db.products.id,
      db.repairJobParts.productId,
    ),
  );

  $$RepairJobPartsTableProcessedTableManager get repairJobPartsRefs {
    final manager = $$RepairJobPartsTableTableManager(
      $_db,
      $_db.repairJobParts,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_repairJobPartsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoiceItemsTable, List<InvoiceItem>>
  _invoiceItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoiceItems,
    aliasName: $_aliasNameGenerator(db.products.id, db.invoiceItems.productId),
  );

  $$InvoiceItemsTableProcessedTableManager get invoiceItemsRefs {
    final manager = $$InvoiceItemsTableTableManager(
      $_db,
      $_db.invoiceItems,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoiceItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StockMovementsTable, List<StockMovement>>
  _stockMovementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.stockMovements,
    aliasName: $_aliasNameGenerator(
      db.products.id,
      db.stockMovements.productId,
    ),
  );

  $$StockMovementsTableProcessedTableManager get stockMovementsRefs {
    final manager = $$StockMovementsTableTableManager(
      $_db,
      $_db.stockMovements,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockMovementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
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

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelNumber => $composableBuilder(
    column: $table.modelNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hp => $composableBuilder(
    column: $table.hp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get minimumStockLevel => $composableBuilder(
    column: $table.minimumStockLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductCategoriesTableFilterComposer get categoryId {
    final $$ProductCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.productCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.productCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> repairJobPartsRefs(
    Expression<bool> Function($$RepairJobPartsTableFilterComposer f) f,
  ) {
    final $$RepairJobPartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairJobParts,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobPartsTableFilterComposer(
            $db: $db,
            $table: $db.repairJobParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoiceItemsRefs(
    Expression<bool> Function($$InvoiceItemsTableFilterComposer f) f,
  ) {
    final $$InvoiceItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableFilterComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> stockMovementsRefs(
    Expression<bool> Function($$StockMovementsTableFilterComposer f) f,
  ) {
    final $$StockMovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovements,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockMovementsTableFilterComposer(
            $db: $db,
            $table: $db.stockMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
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

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelNumber => $composableBuilder(
    column: $table.modelNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hp => $composableBuilder(
    column: $table.hp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get minimumStockLevel => $composableBuilder(
    column: $table.minimumStockLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductCategoriesTableOrderingComposer get categoryId {
    final $$ProductCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.productCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.productCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
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

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get modelNumber => $composableBuilder(
    column: $table.modelNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hp =>
      $composableBuilder(column: $table.hp, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sellingPrice => $composableBuilder(
    column: $table.sellingPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get currentStock => $composableBuilder(
    column: $table.currentStock,
    builder: (column) => column,
  );

  GeneratedColumn<double> get minimumStockLevel => $composableBuilder(
    column: $table.minimumStockLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ProductCategoriesTableAnnotationComposer get categoryId {
    final $$ProductCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.productCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.productCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> repairJobPartsRefs<T extends Object>(
    Expression<T> Function($$RepairJobPartsTableAnnotationComposer a) f,
  ) {
    final $$RepairJobPartsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairJobParts,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobPartsTableAnnotationComposer(
            $db: $db,
            $table: $db.repairJobParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoiceItemsRefs<T extends Object>(
    Expression<T> Function($$InvoiceItemsTableAnnotationComposer a) f,
  ) {
    final $$InvoiceItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> stockMovementsRefs<T extends Object>(
    Expression<T> Function($$StockMovementsTableAnnotationComposer a) f,
  ) {
    final $$StockMovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockMovements,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockMovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.stockMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({
            bool categoryId,
            bool repairJobPartsRefs,
            bool invoiceItemsRefs,
            bool stockMovementsRefs,
          })
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> modelNumber = const Value.absent(),
                Value<String?> hp = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> purchasePrice = const Value.absent(),
                Value<double> sellingPrice = const Value.absent(),
                Value<double> currentStock = const Value.absent(),
                Value<double> minimumStockLevel = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                name: name,
                categoryId: categoryId,
                brand: brand,
                modelNumber: modelNumber,
                hp: hp,
                description: description,
                purchasePrice: purchasePrice,
                sellingPrice: sellingPrice,
                currentStock: currentStock,
                minimumStockLevel: minimumStockLevel,
                unit: unit,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int?> categoryId = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> modelNumber = const Value.absent(),
                Value<String?> hp = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> purchasePrice = const Value.absent(),
                Value<double> sellingPrice = const Value.absent(),
                Value<double> currentStock = const Value.absent(),
                Value<double> minimumStockLevel = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                name: name,
                categoryId: categoryId,
                brand: brand,
                modelNumber: modelNumber,
                hp: hp,
                description: description,
                purchasePrice: purchasePrice,
                sellingPrice: sellingPrice,
                currentStock: currentStock,
                minimumStockLevel: minimumStockLevel,
                unit: unit,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                repairJobPartsRefs = false,
                invoiceItemsRefs = false,
                stockMovementsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (repairJobPartsRefs) db.repairJobParts,
                    if (invoiceItemsRefs) db.invoiceItems,
                    if (stockMovementsRefs) db.stockMovements,
                  ],
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
                                    referencedTable: $$ProductsTableReferences
                                        ._categoryIdTable(db),
                                    referencedColumn: $$ProductsTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (repairJobPartsRefs)
                        await $_getPrefetchedData(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._repairJobPartsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).repairJobPartsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoiceItemsRefs)
                        await $_getPrefetchedData(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._invoiceItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).invoiceItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (stockMovementsRefs)
                        await $_getPrefetchedData(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._stockMovementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).stockMovementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({
        bool categoryId,
        bool repairJobPartsRefs,
        bool invoiceItemsRefs,
        bool stockMovementsRefs,
      })
    >;
typedef $$RepairJobsTableCreateCompanionBuilder =
    RepairJobsCompanion Function({
      Value<int> id,
      required String jobNumber,
      required int customerId,
      Value<String?> customerNameSnapshot,
      Value<String?> customerMobileSnapshot,
      required String motorType,
      required String motorBrand,
      required String motorHp,
      required String motorPhase,
      Value<String?> motorVoltage,
      Value<String?> motorSerialNumber,
      required String problemDescription,
      Value<String?> workDescription,
      Value<double> labourCharges,
      Value<double> materialCharges,
      Value<double> otherCharges,
      Value<double> discount,
      Value<double> finalAmount,
      Value<double> advancePayment,
      Value<double> remainingAmount,
      Value<String> jobStatus,
      Value<DateTime> receivedDate,
      Value<DateTime?> expectedDeliveryDate,
      Value<DateTime?> deliveryDate,
      Value<String?> warrantyInfo,
      Value<String?> notes,
      Value<bool> isDeleted,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$RepairJobsTableUpdateCompanionBuilder =
    RepairJobsCompanion Function({
      Value<int> id,
      Value<String> jobNumber,
      Value<int> customerId,
      Value<String?> customerNameSnapshot,
      Value<String?> customerMobileSnapshot,
      Value<String> motorType,
      Value<String> motorBrand,
      Value<String> motorHp,
      Value<String> motorPhase,
      Value<String?> motorVoltage,
      Value<String?> motorSerialNumber,
      Value<String> problemDescription,
      Value<String?> workDescription,
      Value<double> labourCharges,
      Value<double> materialCharges,
      Value<double> otherCharges,
      Value<double> discount,
      Value<double> finalAmount,
      Value<double> advancePayment,
      Value<double> remainingAmount,
      Value<String> jobStatus,
      Value<DateTime> receivedDate,
      Value<DateTime?> expectedDeliveryDate,
      Value<DateTime?> deliveryDate,
      Value<String?> warrantyInfo,
      Value<String?> notes,
      Value<bool> isDeleted,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

final class $$RepairJobsTableReferences
    extends BaseReferences<_$AppDatabase, $RepairJobsTable, RepairJob> {
  $$RepairJobsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
        $_aliasNameGenerator(db.repairJobs.customerId, db.customers.id),
      );

  $$CustomersTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<int>('customer_id')!;

    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RepairJobPartsTable, List<RepairJobPart>>
  _repairJobPartsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.repairJobParts,
    aliasName: $_aliasNameGenerator(
      db.repairJobs.id,
      db.repairJobParts.repairJobId,
    ),
  );

  $$RepairJobPartsTableProcessedTableManager get repairJobPartsRefs {
    final manager = $$RepairJobPartsTableTableManager(
      $_db,
      $_db.repairJobParts,
    ).filter((f) => f.repairJobId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_repairJobPartsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<Invoice>> _invoicesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: $_aliasNameGenerator(db.repairJobs.id, db.invoices.repairJobId),
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.repairJobId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: $_aliasNameGenerator(db.repairJobs.id, db.payments.repairJobId),
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.repairJobId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DailyWorkLogsTable, List<DailyWorkLog>>
  _dailyWorkLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dailyWorkLogs,
    aliasName: $_aliasNameGenerator(
      db.repairJobs.id,
      db.dailyWorkLogs.repairJobId,
    ),
  );

  $$DailyWorkLogsTableProcessedTableManager get dailyWorkLogsRefs {
    final manager = $$DailyWorkLogsTableTableManager(
      $_db,
      $_db.dailyWorkLogs,
    ).filter((f) => f.repairJobId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dailyWorkLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$JobStatusHistoriesTable, List<JobStatusHistory>>
  _jobStatusHistoriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.jobStatusHistories,
        aliasName: $_aliasNameGenerator(
          db.repairJobs.id,
          db.jobStatusHistories.repairJobId,
        ),
      );

  $$JobStatusHistoriesTableProcessedTableManager get jobStatusHistoriesRefs {
    final manager = $$JobStatusHistoriesTableTableManager(
      $_db,
      $_db.jobStatusHistories,
    ).filter((f) => f.repairJobId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _jobStatusHistoriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RepairJobsTableFilterComposer
    extends Composer<_$AppDatabase, $RepairJobsTable> {
  $$RepairJobsTableFilterComposer({
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

  ColumnFilters<String> get jobNumber => $composableBuilder(
    column: $table.jobNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerNameSnapshot => $composableBuilder(
    column: $table.customerNameSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerMobileSnapshot => $composableBuilder(
    column: $table.customerMobileSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motorType => $composableBuilder(
    column: $table.motorType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motorBrand => $composableBuilder(
    column: $table.motorBrand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motorHp => $composableBuilder(
    column: $table.motorHp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motorPhase => $composableBuilder(
    column: $table.motorPhase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motorVoltage => $composableBuilder(
    column: $table.motorVoltage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motorSerialNumber => $composableBuilder(
    column: $table.motorSerialNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get problemDescription => $composableBuilder(
    column: $table.problemDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workDescription => $composableBuilder(
    column: $table.workDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get labourCharges => $composableBuilder(
    column: $table.labourCharges,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get materialCharges => $composableBuilder(
    column: $table.materialCharges,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get otherCharges => $composableBuilder(
    column: $table.otherCharges,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get finalAmount => $composableBuilder(
    column: $table.finalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get advancePayment => $composableBuilder(
    column: $table.advancePayment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get remainingAmount => $composableBuilder(
    column: $table.remainingAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jobStatus => $composableBuilder(
    column: $table.jobStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receivedDate => $composableBuilder(
    column: $table.receivedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expectedDeliveryDate => $composableBuilder(
    column: $table.expectedDeliveryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deliveryDate => $composableBuilder(
    column: $table.deliveryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warrantyInfo => $composableBuilder(
    column: $table.warrantyInfo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> repairJobPartsRefs(
    Expression<bool> Function($$RepairJobPartsTableFilterComposer f) f,
  ) {
    final $$RepairJobPartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairJobParts,
      getReferencedColumn: (t) => t.repairJobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobPartsTableFilterComposer(
            $db: $db,
            $table: $db.repairJobParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.repairJobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.repairJobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> dailyWorkLogsRefs(
    Expression<bool> Function($$DailyWorkLogsTableFilterComposer f) f,
  ) {
    final $$DailyWorkLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyWorkLogs,
      getReferencedColumn: (t) => t.repairJobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyWorkLogsTableFilterComposer(
            $db: $db,
            $table: $db.dailyWorkLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> jobStatusHistoriesRefs(
    Expression<bool> Function($$JobStatusHistoriesTableFilterComposer f) f,
  ) {
    final $$JobStatusHistoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.jobStatusHistories,
      getReferencedColumn: (t) => t.repairJobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobStatusHistoriesTableFilterComposer(
            $db: $db,
            $table: $db.jobStatusHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RepairJobsTableOrderingComposer
    extends Composer<_$AppDatabase, $RepairJobsTable> {
  $$RepairJobsTableOrderingComposer({
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

  ColumnOrderings<String> get jobNumber => $composableBuilder(
    column: $table.jobNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerNameSnapshot => $composableBuilder(
    column: $table.customerNameSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerMobileSnapshot => $composableBuilder(
    column: $table.customerMobileSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motorType => $composableBuilder(
    column: $table.motorType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motorBrand => $composableBuilder(
    column: $table.motorBrand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motorHp => $composableBuilder(
    column: $table.motorHp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motorPhase => $composableBuilder(
    column: $table.motorPhase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motorVoltage => $composableBuilder(
    column: $table.motorVoltage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motorSerialNumber => $composableBuilder(
    column: $table.motorSerialNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get problemDescription => $composableBuilder(
    column: $table.problemDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workDescription => $composableBuilder(
    column: $table.workDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get labourCharges => $composableBuilder(
    column: $table.labourCharges,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get materialCharges => $composableBuilder(
    column: $table.materialCharges,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get otherCharges => $composableBuilder(
    column: $table.otherCharges,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get finalAmount => $composableBuilder(
    column: $table.finalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get advancePayment => $composableBuilder(
    column: $table.advancePayment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get remainingAmount => $composableBuilder(
    column: $table.remainingAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jobStatus => $composableBuilder(
    column: $table.jobStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedDate => $composableBuilder(
    column: $table.receivedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expectedDeliveryDate => $composableBuilder(
    column: $table.expectedDeliveryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deliveryDate => $composableBuilder(
    column: $table.deliveryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warrantyInfo => $composableBuilder(
    column: $table.warrantyInfo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairJobsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepairJobsTable> {
  $$RepairJobsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get jobNumber =>
      $composableBuilder(column: $table.jobNumber, builder: (column) => column);

  GeneratedColumn<String> get customerNameSnapshot => $composableBuilder(
    column: $table.customerNameSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerMobileSnapshot => $composableBuilder(
    column: $table.customerMobileSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get motorType =>
      $composableBuilder(column: $table.motorType, builder: (column) => column);

  GeneratedColumn<String> get motorBrand => $composableBuilder(
    column: $table.motorBrand,
    builder: (column) => column,
  );

  GeneratedColumn<String> get motorHp =>
      $composableBuilder(column: $table.motorHp, builder: (column) => column);

  GeneratedColumn<String> get motorPhase => $composableBuilder(
    column: $table.motorPhase,
    builder: (column) => column,
  );

  GeneratedColumn<String> get motorVoltage => $composableBuilder(
    column: $table.motorVoltage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get motorSerialNumber => $composableBuilder(
    column: $table.motorSerialNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get problemDescription => $composableBuilder(
    column: $table.problemDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workDescription => $composableBuilder(
    column: $table.workDescription,
    builder: (column) => column,
  );

  GeneratedColumn<double> get labourCharges => $composableBuilder(
    column: $table.labourCharges,
    builder: (column) => column,
  );

  GeneratedColumn<double> get materialCharges => $composableBuilder(
    column: $table.materialCharges,
    builder: (column) => column,
  );

  GeneratedColumn<double> get otherCharges => $composableBuilder(
    column: $table.otherCharges,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get finalAmount => $composableBuilder(
    column: $table.finalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get advancePayment => $composableBuilder(
    column: $table.advancePayment,
    builder: (column) => column,
  );

  GeneratedColumn<double> get remainingAmount => $composableBuilder(
    column: $table.remainingAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get jobStatus =>
      $composableBuilder(column: $table.jobStatus, builder: (column) => column);

  GeneratedColumn<DateTime> get receivedDate => $composableBuilder(
    column: $table.receivedDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expectedDeliveryDate => $composableBuilder(
    column: $table.expectedDeliveryDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deliveryDate => $composableBuilder(
    column: $table.deliveryDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get warrantyInfo => $composableBuilder(
    column: $table.warrantyInfo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> repairJobPartsRefs<T extends Object>(
    Expression<T> Function($$RepairJobPartsTableAnnotationComposer a) f,
  ) {
    final $$RepairJobPartsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairJobParts,
      getReferencedColumn: (t) => t.repairJobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobPartsTableAnnotationComposer(
            $db: $db,
            $table: $db.repairJobParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.repairJobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.repairJobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> dailyWorkLogsRefs<T extends Object>(
    Expression<T> Function($$DailyWorkLogsTableAnnotationComposer a) f,
  ) {
    final $$DailyWorkLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyWorkLogs,
      getReferencedColumn: (t) => t.repairJobId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyWorkLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyWorkLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> jobStatusHistoriesRefs<T extends Object>(
    Expression<T> Function($$JobStatusHistoriesTableAnnotationComposer a) f,
  ) {
    final $$JobStatusHistoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.jobStatusHistories,
          getReferencedColumn: (t) => t.repairJobId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$JobStatusHistoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.jobStatusHistories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RepairJobsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RepairJobsTable,
          RepairJob,
          $$RepairJobsTableFilterComposer,
          $$RepairJobsTableOrderingComposer,
          $$RepairJobsTableAnnotationComposer,
          $$RepairJobsTableCreateCompanionBuilder,
          $$RepairJobsTableUpdateCompanionBuilder,
          (RepairJob, $$RepairJobsTableReferences),
          RepairJob,
          PrefetchHooks Function({
            bool customerId,
            bool repairJobPartsRefs,
            bool invoicesRefs,
            bool paymentsRefs,
            bool dailyWorkLogsRefs,
            bool jobStatusHistoriesRefs,
          })
        > {
  $$RepairJobsTableTableManager(_$AppDatabase db, $RepairJobsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepairJobsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepairJobsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepairJobsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> jobNumber = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<String?> customerNameSnapshot = const Value.absent(),
                Value<String?> customerMobileSnapshot = const Value.absent(),
                Value<String> motorType = const Value.absent(),
                Value<String> motorBrand = const Value.absent(),
                Value<String> motorHp = const Value.absent(),
                Value<String> motorPhase = const Value.absent(),
                Value<String?> motorVoltage = const Value.absent(),
                Value<String?> motorSerialNumber = const Value.absent(),
                Value<String> problemDescription = const Value.absent(),
                Value<String?> workDescription = const Value.absent(),
                Value<double> labourCharges = const Value.absent(),
                Value<double> materialCharges = const Value.absent(),
                Value<double> otherCharges = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> finalAmount = const Value.absent(),
                Value<double> advancePayment = const Value.absent(),
                Value<double> remainingAmount = const Value.absent(),
                Value<String> jobStatus = const Value.absent(),
                Value<DateTime> receivedDate = const Value.absent(),
                Value<DateTime?> expectedDeliveryDate = const Value.absent(),
                Value<DateTime?> deliveryDate = const Value.absent(),
                Value<String?> warrantyInfo = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => RepairJobsCompanion(
                id: id,
                jobNumber: jobNumber,
                customerId: customerId,
                customerNameSnapshot: customerNameSnapshot,
                customerMobileSnapshot: customerMobileSnapshot,
                motorType: motorType,
                motorBrand: motorBrand,
                motorHp: motorHp,
                motorPhase: motorPhase,
                motorVoltage: motorVoltage,
                motorSerialNumber: motorSerialNumber,
                problemDescription: problemDescription,
                workDescription: workDescription,
                labourCharges: labourCharges,
                materialCharges: materialCharges,
                otherCharges: otherCharges,
                discount: discount,
                finalAmount: finalAmount,
                advancePayment: advancePayment,
                remainingAmount: remainingAmount,
                jobStatus: jobStatus,
                receivedDate: receivedDate,
                expectedDeliveryDate: expectedDeliveryDate,
                deliveryDate: deliveryDate,
                warrantyInfo: warrantyInfo,
                notes: notes,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String jobNumber,
                required int customerId,
                Value<String?> customerNameSnapshot = const Value.absent(),
                Value<String?> customerMobileSnapshot = const Value.absent(),
                required String motorType,
                required String motorBrand,
                required String motorHp,
                required String motorPhase,
                Value<String?> motorVoltage = const Value.absent(),
                Value<String?> motorSerialNumber = const Value.absent(),
                required String problemDescription,
                Value<String?> workDescription = const Value.absent(),
                Value<double> labourCharges = const Value.absent(),
                Value<double> materialCharges = const Value.absent(),
                Value<double> otherCharges = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> finalAmount = const Value.absent(),
                Value<double> advancePayment = const Value.absent(),
                Value<double> remainingAmount = const Value.absent(),
                Value<String> jobStatus = const Value.absent(),
                Value<DateTime> receivedDate = const Value.absent(),
                Value<DateTime?> expectedDeliveryDate = const Value.absent(),
                Value<DateTime?> deliveryDate = const Value.absent(),
                Value<String?> warrantyInfo = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => RepairJobsCompanion.insert(
                id: id,
                jobNumber: jobNumber,
                customerId: customerId,
                customerNameSnapshot: customerNameSnapshot,
                customerMobileSnapshot: customerMobileSnapshot,
                motorType: motorType,
                motorBrand: motorBrand,
                motorHp: motorHp,
                motorPhase: motorPhase,
                motorVoltage: motorVoltage,
                motorSerialNumber: motorSerialNumber,
                problemDescription: problemDescription,
                workDescription: workDescription,
                labourCharges: labourCharges,
                materialCharges: materialCharges,
                otherCharges: otherCharges,
                discount: discount,
                finalAmount: finalAmount,
                advancePayment: advancePayment,
                remainingAmount: remainingAmount,
                jobStatus: jobStatus,
                receivedDate: receivedDate,
                expectedDeliveryDate: expectedDeliveryDate,
                deliveryDate: deliveryDate,
                warrantyInfo: warrantyInfo,
                notes: notes,
                isDeleted: isDeleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RepairJobsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                customerId = false,
                repairJobPartsRefs = false,
                invoicesRefs = false,
                paymentsRefs = false,
                dailyWorkLogsRefs = false,
                jobStatusHistoriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (repairJobPartsRefs) db.repairJobParts,
                    if (invoicesRefs) db.invoices,
                    if (paymentsRefs) db.payments,
                    if (dailyWorkLogsRefs) db.dailyWorkLogs,
                    if (jobStatusHistoriesRefs) db.jobStatusHistories,
                  ],
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
                        if (customerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.customerId,
                                    referencedTable: $$RepairJobsTableReferences
                                        ._customerIdTable(db),
                                    referencedColumn:
                                        $$RepairJobsTableReferences
                                            ._customerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (repairJobPartsRefs)
                        await $_getPrefetchedData(
                          currentTable: table,
                          referencedTable: $$RepairJobsTableReferences
                              ._repairJobPartsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RepairJobsTableReferences(
                                db,
                                table,
                                p0,
                              ).repairJobPartsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.repairJobId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (invoicesRefs)
                        await $_getPrefetchedData(
                          currentTable: table,
                          referencedTable: $$RepairJobsTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RepairJobsTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.repairJobId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentsRefs)
                        await $_getPrefetchedData(
                          currentTable: table,
                          referencedTable: $$RepairJobsTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RepairJobsTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.repairJobId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (dailyWorkLogsRefs)
                        await $_getPrefetchedData(
                          currentTable: table,
                          referencedTable: $$RepairJobsTableReferences
                              ._dailyWorkLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RepairJobsTableReferences(
                                db,
                                table,
                                p0,
                              ).dailyWorkLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.repairJobId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (jobStatusHistoriesRefs)
                        await $_getPrefetchedData(
                          currentTable: table,
                          referencedTable: $$RepairJobsTableReferences
                              ._jobStatusHistoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RepairJobsTableReferences(
                                db,
                                table,
                                p0,
                              ).jobStatusHistoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.repairJobId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RepairJobsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RepairJobsTable,
      RepairJob,
      $$RepairJobsTableFilterComposer,
      $$RepairJobsTableOrderingComposer,
      $$RepairJobsTableAnnotationComposer,
      $$RepairJobsTableCreateCompanionBuilder,
      $$RepairJobsTableUpdateCompanionBuilder,
      (RepairJob, $$RepairJobsTableReferences),
      RepairJob,
      PrefetchHooks Function({
        bool customerId,
        bool repairJobPartsRefs,
        bool invoicesRefs,
        bool paymentsRefs,
        bool dailyWorkLogsRefs,
        bool jobStatusHistoriesRefs,
      })
    >;
typedef $$RepairJobPartsTableCreateCompanionBuilder =
    RepairJobPartsCompanion Function({
      Value<int> id,
      required int repairJobId,
      Value<int?> productId,
      required String partName,
      Value<double> quantity,
      Value<double> unitPrice,
      Value<double> totalPrice,
      Value<DateTime> createdAt,
    });
typedef $$RepairJobPartsTableUpdateCompanionBuilder =
    RepairJobPartsCompanion Function({
      Value<int> id,
      Value<int> repairJobId,
      Value<int?> productId,
      Value<String> partName,
      Value<double> quantity,
      Value<double> unitPrice,
      Value<double> totalPrice,
      Value<DateTime> createdAt,
    });

final class $$RepairJobPartsTableReferences
    extends BaseReferences<_$AppDatabase, $RepairJobPartsTable, RepairJobPart> {
  $$RepairJobPartsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RepairJobsTable _repairJobIdTable(_$AppDatabase db) =>
      db.repairJobs.createAlias(
        $_aliasNameGenerator(db.repairJobParts.repairJobId, db.repairJobs.id),
      );

  $$RepairJobsTableProcessedTableManager get repairJobId {
    final $_column = $_itemColumn<int>('repair_job_id')!;

    final manager = $$RepairJobsTableTableManager(
      $_db,
      $_db.repairJobs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_repairJobIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.repairJobParts.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager? get productId {
    final $_column = $_itemColumn<int>('product_id');
    if ($_column == null) return null;
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RepairJobPartsTableFilterComposer
    extends Composer<_$AppDatabase, $RepairJobPartsTable> {
  $$RepairJobPartsTableFilterComposer({
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

  ColumnFilters<String> get partName => $composableBuilder(
    column: $table.partName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RepairJobsTableFilterComposer get repairJobId {
    final $$RepairJobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairJobId,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableFilterComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairJobPartsTableOrderingComposer
    extends Composer<_$AppDatabase, $RepairJobPartsTable> {
  $$RepairJobPartsTableOrderingComposer({
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

  ColumnOrderings<String> get partName => $composableBuilder(
    column: $table.partName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RepairJobsTableOrderingComposer get repairJobId {
    final $$RepairJobsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairJobId,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableOrderingComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairJobPartsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepairJobPartsTable> {
  $$RepairJobPartsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get partName =>
      $composableBuilder(column: $table.partName, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$RepairJobsTableAnnotationComposer get repairJobId {
    final $$RepairJobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairJobId,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableAnnotationComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairJobPartsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RepairJobPartsTable,
          RepairJobPart,
          $$RepairJobPartsTableFilterComposer,
          $$RepairJobPartsTableOrderingComposer,
          $$RepairJobPartsTableAnnotationComposer,
          $$RepairJobPartsTableCreateCompanionBuilder,
          $$RepairJobPartsTableUpdateCompanionBuilder,
          (RepairJobPart, $$RepairJobPartsTableReferences),
          RepairJobPart,
          PrefetchHooks Function({bool repairJobId, bool productId})
        > {
  $$RepairJobPartsTableTableManager(
    _$AppDatabase db,
    $RepairJobPartsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepairJobPartsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepairJobPartsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepairJobPartsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> repairJobId = const Value.absent(),
                Value<int?> productId = const Value.absent(),
                Value<String> partName = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RepairJobPartsCompanion(
                id: id,
                repairJobId: repairJobId,
                productId: productId,
                partName: partName,
                quantity: quantity,
                unitPrice: unitPrice,
                totalPrice: totalPrice,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int repairJobId,
                Value<int?> productId = const Value.absent(),
                required String partName,
                Value<double> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RepairJobPartsCompanion.insert(
                id: id,
                repairJobId: repairJobId,
                productId: productId,
                partName: partName,
                quantity: quantity,
                unitPrice: unitPrice,
                totalPrice: totalPrice,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RepairJobPartsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({repairJobId = false, productId = false}) {
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
                    if (repairJobId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.repairJobId,
                                referencedTable: $$RepairJobPartsTableReferences
                                    ._repairJobIdTable(db),
                                referencedColumn:
                                    $$RepairJobPartsTableReferences
                                        ._repairJobIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$RepairJobPartsTableReferences
                                    ._productIdTable(db),
                                referencedColumn:
                                    $$RepairJobPartsTableReferences
                                        ._productIdTable(db)
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

typedef $$RepairJobPartsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RepairJobPartsTable,
      RepairJobPart,
      $$RepairJobPartsTableFilterComposer,
      $$RepairJobPartsTableOrderingComposer,
      $$RepairJobPartsTableAnnotationComposer,
      $$RepairJobPartsTableCreateCompanionBuilder,
      $$RepairJobPartsTableUpdateCompanionBuilder,
      (RepairJobPart, $$RepairJobPartsTableReferences),
      RepairJobPart,
      PrefetchHooks Function({bool repairJobId, bool productId})
    >;
typedef $$InvoicesTableCreateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      required String invoiceNumber,
      required String category,
      Value<int?> customerId,
      Value<String?> customerName,
      Value<String?> customerMobile,
      Value<int?> repairJobId,
      Value<DateTime> invoiceDate,
      Value<double> subtotal,
      Value<double> discount,
      Value<double> taxRate,
      Value<double> taxAmount,
      Value<double> grandTotal,
      Value<double> paidAmount,
      Value<double> pendingAmount,
      Value<String> paymentMode,
      Value<String?> notes,
      Value<String?> termsAndConditions,
      Value<bool> isCancelled,
      Value<String?> cancellationReason,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$InvoicesTableUpdateCompanionBuilder =
    InvoicesCompanion Function({
      Value<int> id,
      Value<String> invoiceNumber,
      Value<String> category,
      Value<int?> customerId,
      Value<String?> customerName,
      Value<String?> customerMobile,
      Value<int?> repairJobId,
      Value<DateTime> invoiceDate,
      Value<double> subtotal,
      Value<double> discount,
      Value<double> taxRate,
      Value<double> taxAmount,
      Value<double> grandTotal,
      Value<double> paidAmount,
      Value<double> pendingAmount,
      Value<String> paymentMode,
      Value<String?> notes,
      Value<String?> termsAndConditions,
      Value<bool> isCancelled,
      Value<String?> cancellationReason,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

final class $$InvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoicesTable, Invoice> {
  $$InvoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
        $_aliasNameGenerator(db.invoices.customerId, db.customers.id),
      );

  $$CustomersTableProcessedTableManager? get customerId {
    final $_column = $_itemColumn<int>('customer_id');
    if ($_column == null) return null;
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RepairJobsTable _repairJobIdTable(_$AppDatabase db) =>
      db.repairJobs.createAlias(
        $_aliasNameGenerator(db.invoices.repairJobId, db.repairJobs.id),
      );

  $$RepairJobsTableProcessedTableManager? get repairJobId {
    final $_column = $_itemColumn<int>('repair_job_id');
    if ($_column == null) return null;
    final manager = $$RepairJobsTableTableManager(
      $_db,
      $_db.repairJobs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_repairJobIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$InvoiceItemsTable, List<InvoiceItem>>
  _invoiceItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoiceItems,
    aliasName: $_aliasNameGenerator(db.invoices.id, db.invoiceItems.invoiceId),
  );

  $$InvoiceItemsTableProcessedTableManager get invoiceItemsRefs {
    final manager = $$InvoiceItemsTableTableManager(
      $_db,
      $_db.invoiceItems,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoiceItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: $_aliasNameGenerator(db.invoices.id, db.payments.invoiceId),
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
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

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerMobile => $composableBuilder(
    column: $table.customerMobile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get invoiceDate => $composableBuilder(
    column: $table.invoiceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxRate => $composableBuilder(
    column: $table.taxRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grandTotal => $composableBuilder(
    column: $table.grandTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pendingAmount => $composableBuilder(
    column: $table.pendingAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get termsAndConditions => $composableBuilder(
    column: $table.termsAndConditions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCancelled => $composableBuilder(
    column: $table.isCancelled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cancellationReason => $composableBuilder(
    column: $table.cancellationReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RepairJobsTableFilterComposer get repairJobId {
    final $$RepairJobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairJobId,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableFilterComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> invoiceItemsRefs(
    Expression<bool> Function($$InvoiceItemsTableFilterComposer f) f,
  ) {
    final $$InvoiceItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableFilterComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
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

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerMobile => $composableBuilder(
    column: $table.customerMobile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get invoiceDate => $composableBuilder(
    column: $table.invoiceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discount => $composableBuilder(
    column: $table.discount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxRate => $composableBuilder(
    column: $table.taxRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grandTotal => $composableBuilder(
    column: $table.grandTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pendingAmount => $composableBuilder(
    column: $table.pendingAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get termsAndConditions => $composableBuilder(
    column: $table.termsAndConditions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCancelled => $composableBuilder(
    column: $table.isCancelled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cancellationReason => $composableBuilder(
    column: $table.cancellationReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RepairJobsTableOrderingComposer get repairJobId {
    final $$RepairJobsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairJobId,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableOrderingComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
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

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerMobile => $composableBuilder(
    column: $table.customerMobile,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get invoiceDate => $composableBuilder(
    column: $table.invoiceDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get discount =>
      $composableBuilder(column: $table.discount, builder: (column) => column);

  GeneratedColumn<double> get taxRate =>
      $composableBuilder(column: $table.taxRate, builder: (column) => column);

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<double> get grandTotal => $composableBuilder(
    column: $table.grandTotal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get paidAmount => $composableBuilder(
    column: $table.paidAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pendingAmount => $composableBuilder(
    column: $table.pendingAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get termsAndConditions => $composableBuilder(
    column: $table.termsAndConditions,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCancelled => $composableBuilder(
    column: $table.isCancelled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cancellationReason => $composableBuilder(
    column: $table.cancellationReason,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RepairJobsTableAnnotationComposer get repairJobId {
    final $$RepairJobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairJobId,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableAnnotationComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> invoiceItemsRefs<T extends Object>(
    Expression<T> Function($$InvoiceItemsTableAnnotationComposer a) f,
  ) {
    final $$InvoiceItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTable,
          Invoice,
          $$InvoicesTableFilterComposer,
          $$InvoicesTableOrderingComposer,
          $$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (Invoice, $$InvoicesTableReferences),
          Invoice,
          PrefetchHooks Function({
            bool customerId,
            bool repairJobId,
            bool invoiceItemsRefs,
            bool paymentsRefs,
          })
        > {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> invoiceNumber = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<String?> customerMobile = const Value.absent(),
                Value<int?> repairJobId = const Value.absent(),
                Value<DateTime> invoiceDate = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> taxRate = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<double> grandTotal = const Value.absent(),
                Value<double> paidAmount = const Value.absent(),
                Value<double> pendingAmount = const Value.absent(),
                Value<String> paymentMode = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> termsAndConditions = const Value.absent(),
                Value<bool> isCancelled = const Value.absent(),
                Value<String?> cancellationReason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                invoiceNumber: invoiceNumber,
                category: category,
                customerId: customerId,
                customerName: customerName,
                customerMobile: customerMobile,
                repairJobId: repairJobId,
                invoiceDate: invoiceDate,
                subtotal: subtotal,
                discount: discount,
                taxRate: taxRate,
                taxAmount: taxAmount,
                grandTotal: grandTotal,
                paidAmount: paidAmount,
                pendingAmount: pendingAmount,
                paymentMode: paymentMode,
                notes: notes,
                termsAndConditions: termsAndConditions,
                isCancelled: isCancelled,
                cancellationReason: cancellationReason,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String invoiceNumber,
                required String category,
                Value<int?> customerId = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<String?> customerMobile = const Value.absent(),
                Value<int?> repairJobId = const Value.absent(),
                Value<DateTime> invoiceDate = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> discount = const Value.absent(),
                Value<double> taxRate = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<double> grandTotal = const Value.absent(),
                Value<double> paidAmount = const Value.absent(),
                Value<double> pendingAmount = const Value.absent(),
                Value<String> paymentMode = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> termsAndConditions = const Value.absent(),
                Value<bool> isCancelled = const Value.absent(),
                Value<String?> cancellationReason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => InvoicesCompanion.insert(
                id: id,
                invoiceNumber: invoiceNumber,
                category: category,
                customerId: customerId,
                customerName: customerName,
                customerMobile: customerMobile,
                repairJobId: repairJobId,
                invoiceDate: invoiceDate,
                subtotal: subtotal,
                discount: discount,
                taxRate: taxRate,
                taxAmount: taxAmount,
                grandTotal: grandTotal,
                paidAmount: paidAmount,
                pendingAmount: pendingAmount,
                paymentMode: paymentMode,
                notes: notes,
                termsAndConditions: termsAndConditions,
                isCancelled: isCancelled,
                cancellationReason: cancellationReason,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                customerId = false,
                repairJobId = false,
                invoiceItemsRefs = false,
                paymentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (invoiceItemsRefs) db.invoiceItems,
                    if (paymentsRefs) db.payments,
                  ],
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
                        if (customerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.customerId,
                                    referencedTable: $$InvoicesTableReferences
                                        ._customerIdTable(db),
                                    referencedColumn: $$InvoicesTableReferences
                                        ._customerIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (repairJobId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.repairJobId,
                                    referencedTable: $$InvoicesTableReferences
                                        ._repairJobIdTable(db),
                                    referencedColumn: $$InvoicesTableReferences
                                        ._repairJobIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (invoiceItemsRefs)
                        await $_getPrefetchedData(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._invoiceItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).invoiceItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (paymentsRefs)
                        await $_getPrefetchedData(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.invoiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTable,
      Invoice,
      $$InvoicesTableFilterComposer,
      $$InvoicesTableOrderingComposer,
      $$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (Invoice, $$InvoicesTableReferences),
      Invoice,
      PrefetchHooks Function({
        bool customerId,
        bool repairJobId,
        bool invoiceItemsRefs,
        bool paymentsRefs,
      })
    >;
typedef $$InvoiceItemsTableCreateCompanionBuilder =
    InvoiceItemsCompanion Function({
      Value<int> id,
      required int invoiceId,
      Value<int?> productId,
      required String description,
      Value<double> quantity,
      Value<double> unitPrice,
      Value<double> amount,
      Value<DateTime> createdAt,
    });
typedef $$InvoiceItemsTableUpdateCompanionBuilder =
    InvoiceItemsCompanion Function({
      Value<int> id,
      Value<int> invoiceId,
      Value<int?> productId,
      Value<String> description,
      Value<double> quantity,
      Value<double> unitPrice,
      Value<double> amount,
      Value<DateTime> createdAt,
    });

final class $$InvoiceItemsTableReferences
    extends BaseReferences<_$AppDatabase, $InvoiceItemsTable, InvoiceItem> {
  $$InvoiceItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias(
        $_aliasNameGenerator(db.invoiceItems.invoiceId, db.invoices.id),
      );

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.invoiceItems.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager? get productId {
    final $_column = $_itemColumn<int>('product_id');
    if ($_column == null) return null;
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InvoiceItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoiceItemsTable,
          InvoiceItem,
          $$InvoiceItemsTableFilterComposer,
          $$InvoiceItemsTableOrderingComposer,
          $$InvoiceItemsTableAnnotationComposer,
          $$InvoiceItemsTableCreateCompanionBuilder,
          $$InvoiceItemsTableUpdateCompanionBuilder,
          (InvoiceItem, $$InvoiceItemsTableReferences),
          InvoiceItem,
          PrefetchHooks Function({bool invoiceId, bool productId})
        > {
  $$InvoiceItemsTableTableManager(_$AppDatabase db, $InvoiceItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> invoiceId = const Value.absent(),
                Value<int?> productId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InvoiceItemsCompanion(
                id: id,
                invoiceId: invoiceId,
                productId: productId,
                description: description,
                quantity: quantity,
                unitPrice: unitPrice,
                amount: amount,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int invoiceId,
                Value<int?> productId = const Value.absent(),
                required String description,
                Value<double> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => InvoiceItemsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                productId: productId,
                description: description,
                quantity: quantity,
                unitPrice: unitPrice,
                amount: amount,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvoiceItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceId = false, productId = false}) {
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
                    if (invoiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.invoiceId,
                                referencedTable: $$InvoiceItemsTableReferences
                                    ._invoiceIdTable(db),
                                referencedColumn: $$InvoiceItemsTableReferences
                                    ._invoiceIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$InvoiceItemsTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$InvoiceItemsTableReferences
                                    ._productIdTable(db)
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

typedef $$InvoiceItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoiceItemsTable,
      InvoiceItem,
      $$InvoiceItemsTableFilterComposer,
      $$InvoiceItemsTableOrderingComposer,
      $$InvoiceItemsTableAnnotationComposer,
      $$InvoiceItemsTableCreateCompanionBuilder,
      $$InvoiceItemsTableUpdateCompanionBuilder,
      (InvoiceItem, $$InvoiceItemsTableReferences),
      InvoiceItem,
      PrefetchHooks Function({bool invoiceId, bool productId})
    >;
typedef $$PaymentsTableCreateCompanionBuilder =
    PaymentsCompanion Function({
      Value<int> id,
      required int customerId,
      Value<int?> invoiceId,
      Value<int?> repairJobId,
      Value<DateTime> paymentDate,
      required double amountReceived,
      Value<String> paymentMode,
      Value<String?> transactionReference,
      Value<String?> notes,
      Value<bool> isDeleted,
      Value<DateTime> createdAt,
    });
typedef $$PaymentsTableUpdateCompanionBuilder =
    PaymentsCompanion Function({
      Value<int> id,
      Value<int> customerId,
      Value<int?> invoiceId,
      Value<int?> repairJobId,
      Value<DateTime> paymentDate,
      Value<double> amountReceived,
      Value<String> paymentMode,
      Value<String?> transactionReference,
      Value<String?> notes,
      Value<bool> isDeleted,
      Value<DateTime> createdAt,
    });

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, Payment> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
        $_aliasNameGenerator(db.payments.customerId, db.customers.id),
      );

  $$CustomersTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<int>('customer_id')!;

    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) => db.invoices
      .createAlias($_aliasNameGenerator(db.payments.invoiceId, db.invoices.id));

  $$InvoicesTableProcessedTableManager? get invoiceId {
    final $_column = $_itemColumn<int>('invoice_id');
    if ($_column == null) return null;
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RepairJobsTable _repairJobIdTable(_$AppDatabase db) =>
      db.repairJobs.createAlias(
        $_aliasNameGenerator(db.payments.repairJobId, db.repairJobs.id),
      );

  $$RepairJobsTableProcessedTableManager? get repairJobId {
    final $_column = $_itemColumn<int>('repair_job_id');
    if ($_column == null) return null;
    final manager = $$RepairJobsTableTableManager(
      $_db,
      $_db.repairJobs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_repairJobIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
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

  ColumnFilters<DateTime> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amountReceived => $composableBuilder(
    column: $table.amountReceived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionReference => $composableBuilder(
    column: $table.transactionReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RepairJobsTableFilterComposer get repairJobId {
    final $$RepairJobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairJobId,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableFilterComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amountReceived => $composableBuilder(
    column: $table.amountReceived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionReference => $composableBuilder(
    column: $table.transactionReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RepairJobsTableOrderingComposer get repairJobId {
    final $$RepairJobsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairJobId,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableOrderingComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get paymentDate => $composableBuilder(
    column: $table.paymentDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amountReceived => $composableBuilder(
    column: $table.amountReceived,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transactionReference => $composableBuilder(
    column: $table.transactionReference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RepairJobsTableAnnotationComposer get repairJobId {
    final $$RepairJobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairJobId,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableAnnotationComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          Payment,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (Payment, $$PaymentsTableReferences),
          Payment,
          PrefetchHooks Function({
            bool customerId,
            bool invoiceId,
            bool repairJobId,
          })
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<int?> invoiceId = const Value.absent(),
                Value<int?> repairJobId = const Value.absent(),
                Value<DateTime> paymentDate = const Value.absent(),
                Value<double> amountReceived = const Value.absent(),
                Value<String> paymentMode = const Value.absent(),
                Value<String?> transactionReference = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PaymentsCompanion(
                id: id,
                customerId: customerId,
                invoiceId: invoiceId,
                repairJobId: repairJobId,
                paymentDate: paymentDate,
                amountReceived: amountReceived,
                paymentMode: paymentMode,
                transactionReference: transactionReference,
                notes: notes,
                isDeleted: isDeleted,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int customerId,
                Value<int?> invoiceId = const Value.absent(),
                Value<int?> repairJobId = const Value.absent(),
                Value<DateTime> paymentDate = const Value.absent(),
                required double amountReceived,
                Value<String> paymentMode = const Value.absent(),
                Value<String?> transactionReference = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PaymentsCompanion.insert(
                id: id,
                customerId: customerId,
                invoiceId: invoiceId,
                repairJobId: repairJobId,
                paymentDate: paymentDate,
                amountReceived: amountReceived,
                paymentMode: paymentMode,
                transactionReference: transactionReference,
                notes: notes,
                isDeleted: isDeleted,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({customerId = false, invoiceId = false, repairJobId = false}) {
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
                        if (customerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.customerId,
                                    referencedTable: $$PaymentsTableReferences
                                        ._customerIdTable(db),
                                    referencedColumn: $$PaymentsTableReferences
                                        ._customerIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (invoiceId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.invoiceId,
                                    referencedTable: $$PaymentsTableReferences
                                        ._invoiceIdTable(db),
                                    referencedColumn: $$PaymentsTableReferences
                                        ._invoiceIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (repairJobId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.repairJobId,
                                    referencedTable: $$PaymentsTableReferences
                                        ._repairJobIdTable(db),
                                    referencedColumn: $$PaymentsTableReferences
                                        ._repairJobIdTable(db)
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

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      Payment,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (Payment, $$PaymentsTableReferences),
      Payment,
      PrefetchHooks Function({
        bool customerId,
        bool invoiceId,
        bool repairJobId,
      })
    >;
typedef $$StockMovementsTableCreateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<int> id,
      required int productId,
      required String movementType,
      required double quantity,
      Value<double> unitPrice,
      Value<String?> referenceType,
      Value<int?> referenceId,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$StockMovementsTableUpdateCompanionBuilder =
    StockMovementsCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<String> movementType,
      Value<double> quantity,
      Value<double> unitPrice,
      Value<String?> referenceType,
      Value<int?> referenceId,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

final class $$StockMovementsTableReferences
    extends BaseReferences<_$AppDatabase, $StockMovementsTable, StockMovement> {
  $$StockMovementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.stockMovements.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StockMovementsTableFilterComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableFilterComposer({
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

  ColumnFilters<String> get movementType => $composableBuilder(
    column: $table.movementType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableOrderingComposer({
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

  ColumnOrderings<String> get movementType => $composableBuilder(
    column: $table.movementType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockMovementsTable> {
  $$StockMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get movementType => $composableBuilder(
    column: $table.movementType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockMovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockMovementsTable,
          StockMovement,
          $$StockMovementsTableFilterComposer,
          $$StockMovementsTableOrderingComposer,
          $$StockMovementsTableAnnotationComposer,
          $$StockMovementsTableCreateCompanionBuilder,
          $$StockMovementsTableUpdateCompanionBuilder,
          (StockMovement, $$StockMovementsTableReferences),
          StockMovement,
          PrefetchHooks Function({bool productId})
        > {
  $$StockMovementsTableTableManager(
    _$AppDatabase db,
    $StockMovementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockMovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String> movementType = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<String?> referenceType = const Value.absent(),
                Value<int?> referenceId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StockMovementsCompanion(
                id: id,
                productId: productId,
                movementType: movementType,
                quantity: quantity,
                unitPrice: unitPrice,
                referenceType: referenceType,
                referenceId: referenceId,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required String movementType,
                required double quantity,
                Value<double> unitPrice = const Value.absent(),
                Value<String?> referenceType = const Value.absent(),
                Value<int?> referenceId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StockMovementsCompanion.insert(
                id: id,
                productId: productId,
                movementType: movementType,
                quantity: quantity,
                unitPrice: unitPrice,
                referenceType: referenceType,
                referenceId: referenceId,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StockMovementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
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
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$StockMovementsTableReferences
                                    ._productIdTable(db),
                                referencedColumn:
                                    $$StockMovementsTableReferences
                                        ._productIdTable(db)
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

typedef $$StockMovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockMovementsTable,
      StockMovement,
      $$StockMovementsTableFilterComposer,
      $$StockMovementsTableOrderingComposer,
      $$StockMovementsTableAnnotationComposer,
      $$StockMovementsTableCreateCompanionBuilder,
      $$StockMovementsTableUpdateCompanionBuilder,
      (StockMovement, $$StockMovementsTableReferences),
      StockMovement,
      PrefetchHooks Function({bool productId})
    >;
typedef $$DailyWorkLogsTableCreateCompanionBuilder =
    DailyWorkLogsCompanion Function({
      Value<int> id,
      Value<DateTime> logDate,
      Value<int?> customerId,
      Value<String?> customerName,
      Value<int?> repairJobId,
      Value<String?> jobNumber,
      Value<String?> motorDetails,
      required String workPerformed,
      Value<String?> partsUsed,
      Value<double> labourCharges,
      Value<double> paymentReceived,
      Value<double> pendingAmount,
      Value<String?> workStatus,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });
typedef $$DailyWorkLogsTableUpdateCompanionBuilder =
    DailyWorkLogsCompanion Function({
      Value<int> id,
      Value<DateTime> logDate,
      Value<int?> customerId,
      Value<String?> customerName,
      Value<int?> repairJobId,
      Value<String?> jobNumber,
      Value<String?> motorDetails,
      Value<String> workPerformed,
      Value<String?> partsUsed,
      Value<double> labourCharges,
      Value<double> paymentReceived,
      Value<double> pendingAmount,
      Value<String?> workStatus,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
    });

final class $$DailyWorkLogsTableReferences
    extends BaseReferences<_$AppDatabase, $DailyWorkLogsTable, DailyWorkLog> {
  $$DailyWorkLogsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias(
        $_aliasNameGenerator(db.dailyWorkLogs.customerId, db.customers.id),
      );

  $$CustomersTableProcessedTableManager? get customerId {
    final $_column = $_itemColumn<int>('customer_id');
    if ($_column == null) return null;
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RepairJobsTable _repairJobIdTable(_$AppDatabase db) =>
      db.repairJobs.createAlias(
        $_aliasNameGenerator(db.dailyWorkLogs.repairJobId, db.repairJobs.id),
      );

  $$RepairJobsTableProcessedTableManager? get repairJobId {
    final $_column = $_itemColumn<int>('repair_job_id');
    if ($_column == null) return null;
    final manager = $$RepairJobsTableTableManager(
      $_db,
      $_db.repairJobs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_repairJobIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DailyWorkLogsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyWorkLogsTable> {
  $$DailyWorkLogsTableFilterComposer({
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

  ColumnFilters<DateTime> get logDate => $composableBuilder(
    column: $table.logDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jobNumber => $composableBuilder(
    column: $table.jobNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motorDetails => $composableBuilder(
    column: $table.motorDetails,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workPerformed => $composableBuilder(
    column: $table.workPerformed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partsUsed => $composableBuilder(
    column: $table.partsUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get labourCharges => $composableBuilder(
    column: $table.labourCharges,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get paymentReceived => $composableBuilder(
    column: $table.paymentReceived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pendingAmount => $composableBuilder(
    column: $table.pendingAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workStatus => $composableBuilder(
    column: $table.workStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RepairJobsTableFilterComposer get repairJobId {
    final $$RepairJobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairJobId,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableFilterComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyWorkLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyWorkLogsTable> {
  $$DailyWorkLogsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get logDate => $composableBuilder(
    column: $table.logDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jobNumber => $composableBuilder(
    column: $table.jobNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motorDetails => $composableBuilder(
    column: $table.motorDetails,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workPerformed => $composableBuilder(
    column: $table.workPerformed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partsUsed => $composableBuilder(
    column: $table.partsUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get labourCharges => $composableBuilder(
    column: $table.labourCharges,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get paymentReceived => $composableBuilder(
    column: $table.paymentReceived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pendingAmount => $composableBuilder(
    column: $table.pendingAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workStatus => $composableBuilder(
    column: $table.workStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RepairJobsTableOrderingComposer get repairJobId {
    final $$RepairJobsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairJobId,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableOrderingComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyWorkLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyWorkLogsTable> {
  $$DailyWorkLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get logDate =>
      $composableBuilder(column: $table.logDate, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get jobNumber =>
      $composableBuilder(column: $table.jobNumber, builder: (column) => column);

  GeneratedColumn<String> get motorDetails => $composableBuilder(
    column: $table.motorDetails,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workPerformed => $composableBuilder(
    column: $table.workPerformed,
    builder: (column) => column,
  );

  GeneratedColumn<String> get partsUsed =>
      $composableBuilder(column: $table.partsUsed, builder: (column) => column);

  GeneratedColumn<double> get labourCharges => $composableBuilder(
    column: $table.labourCharges,
    builder: (column) => column,
  );

  GeneratedColumn<double> get paymentReceived => $composableBuilder(
    column: $table.paymentReceived,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pendingAmount => $composableBuilder(
    column: $table.pendingAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workStatus => $composableBuilder(
    column: $table.workStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RepairJobsTableAnnotationComposer get repairJobId {
    final $$RepairJobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairJobId,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableAnnotationComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyWorkLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyWorkLogsTable,
          DailyWorkLog,
          $$DailyWorkLogsTableFilterComposer,
          $$DailyWorkLogsTableOrderingComposer,
          $$DailyWorkLogsTableAnnotationComposer,
          $$DailyWorkLogsTableCreateCompanionBuilder,
          $$DailyWorkLogsTableUpdateCompanionBuilder,
          (DailyWorkLog, $$DailyWorkLogsTableReferences),
          DailyWorkLog,
          PrefetchHooks Function({bool customerId, bool repairJobId})
        > {
  $$DailyWorkLogsTableTableManager(_$AppDatabase db, $DailyWorkLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyWorkLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyWorkLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyWorkLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> logDate = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<int?> repairJobId = const Value.absent(),
                Value<String?> jobNumber = const Value.absent(),
                Value<String?> motorDetails = const Value.absent(),
                Value<String> workPerformed = const Value.absent(),
                Value<String?> partsUsed = const Value.absent(),
                Value<double> labourCharges = const Value.absent(),
                Value<double> paymentReceived = const Value.absent(),
                Value<double> pendingAmount = const Value.absent(),
                Value<String?> workStatus = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => DailyWorkLogsCompanion(
                id: id,
                logDate: logDate,
                customerId: customerId,
                customerName: customerName,
                repairJobId: repairJobId,
                jobNumber: jobNumber,
                motorDetails: motorDetails,
                workPerformed: workPerformed,
                partsUsed: partsUsed,
                labourCharges: labourCharges,
                paymentReceived: paymentReceived,
                pendingAmount: pendingAmount,
                workStatus: workStatus,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> logDate = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<int?> repairJobId = const Value.absent(),
                Value<String?> jobNumber = const Value.absent(),
                Value<String?> motorDetails = const Value.absent(),
                required String workPerformed,
                Value<String?> partsUsed = const Value.absent(),
                Value<double> labourCharges = const Value.absent(),
                Value<double> paymentReceived = const Value.absent(),
                Value<double> pendingAmount = const Value.absent(),
                Value<String?> workStatus = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => DailyWorkLogsCompanion.insert(
                id: id,
                logDate: logDate,
                customerId: customerId,
                customerName: customerName,
                repairJobId: repairJobId,
                jobNumber: jobNumber,
                motorDetails: motorDetails,
                workPerformed: workPerformed,
                partsUsed: partsUsed,
                labourCharges: labourCharges,
                paymentReceived: paymentReceived,
                pendingAmount: pendingAmount,
                workStatus: workStatus,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DailyWorkLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({customerId = false, repairJobId = false}) {
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
                    if (customerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.customerId,
                                referencedTable: $$DailyWorkLogsTableReferences
                                    ._customerIdTable(db),
                                referencedColumn: $$DailyWorkLogsTableReferences
                                    ._customerIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (repairJobId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.repairJobId,
                                referencedTable: $$DailyWorkLogsTableReferences
                                    ._repairJobIdTable(db),
                                referencedColumn: $$DailyWorkLogsTableReferences
                                    ._repairJobIdTable(db)
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

typedef $$DailyWorkLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyWorkLogsTable,
      DailyWorkLog,
      $$DailyWorkLogsTableFilterComposer,
      $$DailyWorkLogsTableOrderingComposer,
      $$DailyWorkLogsTableAnnotationComposer,
      $$DailyWorkLogsTableCreateCompanionBuilder,
      $$DailyWorkLogsTableUpdateCompanionBuilder,
      (DailyWorkLog, $$DailyWorkLogsTableReferences),
      DailyWorkLog,
      PrefetchHooks Function({bool customerId, bool repairJobId})
    >;
typedef $$BusinessSettingsTableCreateCompanionBuilder =
    BusinessSettingsCompanion Function({
      Value<int> id,
      Value<String> shopName,
      Value<String> ownerName,
      Value<String> shopAddress,
      Value<String> mobileNumber,
      Value<String?> alternateMobile,
      Value<String?> gstin,
      Value<String> invoicePrefix,
      Value<String> jobPrefix,
      Value<double> defaultTaxRate,
      Value<bool> isGstEnabled,
      Value<String> currency,
      Value<String> defaultLanguage,
      Value<String?> pdfFooter,
      Value<String?> warrantyTerms,
      Value<String?> paymentInstructions,
      Value<bool> autoBackupEnabled,
      Value<String> backupScheduleTime,
      Value<int> backupRetentionCount,
      Value<DateTime?> lastBackupTimestamp,
      Value<String?> lastBackupStatus,
      Value<DateTime?> updatedAt,
    });
typedef $$BusinessSettingsTableUpdateCompanionBuilder =
    BusinessSettingsCompanion Function({
      Value<int> id,
      Value<String> shopName,
      Value<String> ownerName,
      Value<String> shopAddress,
      Value<String> mobileNumber,
      Value<String?> alternateMobile,
      Value<String?> gstin,
      Value<String> invoicePrefix,
      Value<String> jobPrefix,
      Value<double> defaultTaxRate,
      Value<bool> isGstEnabled,
      Value<String> currency,
      Value<String> defaultLanguage,
      Value<String?> pdfFooter,
      Value<String?> warrantyTerms,
      Value<String?> paymentInstructions,
      Value<bool> autoBackupEnabled,
      Value<String> backupScheduleTime,
      Value<int> backupRetentionCount,
      Value<DateTime?> lastBackupTimestamp,
      Value<String?> lastBackupStatus,
      Value<DateTime?> updatedAt,
    });

class $$BusinessSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $BusinessSettingsTable> {
  $$BusinessSettingsTableFilterComposer({
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

  ColumnFilters<String> get shopName => $composableBuilder(
    column: $table.shopName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerName => $composableBuilder(
    column: $table.ownerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopAddress => $composableBuilder(
    column: $table.shopAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mobileNumber => $composableBuilder(
    column: $table.mobileNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alternateMobile => $composableBuilder(
    column: $table.alternateMobile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gstin => $composableBuilder(
    column: $table.gstin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoicePrefix => $composableBuilder(
    column: $table.invoicePrefix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jobPrefix => $composableBuilder(
    column: $table.jobPrefix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultTaxRate => $composableBuilder(
    column: $table.defaultTaxRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isGstEnabled => $composableBuilder(
    column: $table.isGstEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultLanguage => $composableBuilder(
    column: $table.defaultLanguage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfFooter => $composableBuilder(
    column: $table.pdfFooter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warrantyTerms => $composableBuilder(
    column: $table.warrantyTerms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentInstructions => $composableBuilder(
    column: $table.paymentInstructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autoBackupEnabled => $composableBuilder(
    column: $table.autoBackupEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backupScheduleTime => $composableBuilder(
    column: $table.backupScheduleTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get backupRetentionCount => $composableBuilder(
    column: $table.backupRetentionCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastBackupTimestamp => $composableBuilder(
    column: $table.lastBackupTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastBackupStatus => $composableBuilder(
    column: $table.lastBackupStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BusinessSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $BusinessSettingsTable> {
  $$BusinessSettingsTableOrderingComposer({
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

  ColumnOrderings<String> get shopName => $composableBuilder(
    column: $table.shopName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerName => $composableBuilder(
    column: $table.ownerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopAddress => $composableBuilder(
    column: $table.shopAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mobileNumber => $composableBuilder(
    column: $table.mobileNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alternateMobile => $composableBuilder(
    column: $table.alternateMobile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gstin => $composableBuilder(
    column: $table.gstin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoicePrefix => $composableBuilder(
    column: $table.invoicePrefix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jobPrefix => $composableBuilder(
    column: $table.jobPrefix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultTaxRate => $composableBuilder(
    column: $table.defaultTaxRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isGstEnabled => $composableBuilder(
    column: $table.isGstEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultLanguage => $composableBuilder(
    column: $table.defaultLanguage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfFooter => $composableBuilder(
    column: $table.pdfFooter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warrantyTerms => $composableBuilder(
    column: $table.warrantyTerms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentInstructions => $composableBuilder(
    column: $table.paymentInstructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoBackupEnabled => $composableBuilder(
    column: $table.autoBackupEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backupScheduleTime => $composableBuilder(
    column: $table.backupScheduleTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get backupRetentionCount => $composableBuilder(
    column: $table.backupRetentionCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastBackupTimestamp => $composableBuilder(
    column: $table.lastBackupTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastBackupStatus => $composableBuilder(
    column: $table.lastBackupStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BusinessSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BusinessSettingsTable> {
  $$BusinessSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopName =>
      $composableBuilder(column: $table.shopName, builder: (column) => column);

  GeneratedColumn<String> get ownerName =>
      $composableBuilder(column: $table.ownerName, builder: (column) => column);

  GeneratedColumn<String> get shopAddress => $composableBuilder(
    column: $table.shopAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mobileNumber => $composableBuilder(
    column: $table.mobileNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get alternateMobile => $composableBuilder(
    column: $table.alternateMobile,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gstin =>
      $composableBuilder(column: $table.gstin, builder: (column) => column);

  GeneratedColumn<String> get invoicePrefix => $composableBuilder(
    column: $table.invoicePrefix,
    builder: (column) => column,
  );

  GeneratedColumn<String> get jobPrefix =>
      $composableBuilder(column: $table.jobPrefix, builder: (column) => column);

  GeneratedColumn<double> get defaultTaxRate => $composableBuilder(
    column: $table.defaultTaxRate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isGstEnabled => $composableBuilder(
    column: $table.isGstEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get defaultLanguage => $composableBuilder(
    column: $table.defaultLanguage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pdfFooter =>
      $composableBuilder(column: $table.pdfFooter, builder: (column) => column);

  GeneratedColumn<String> get warrantyTerms => $composableBuilder(
    column: $table.warrantyTerms,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentInstructions => $composableBuilder(
    column: $table.paymentInstructions,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get autoBackupEnabled => $composableBuilder(
    column: $table.autoBackupEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backupScheduleTime => $composableBuilder(
    column: $table.backupScheduleTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get backupRetentionCount => $composableBuilder(
    column: $table.backupRetentionCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastBackupTimestamp => $composableBuilder(
    column: $table.lastBackupTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastBackupStatus => $composableBuilder(
    column: $table.lastBackupStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BusinessSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BusinessSettingsTable,
          BusinessSetting,
          $$BusinessSettingsTableFilterComposer,
          $$BusinessSettingsTableOrderingComposer,
          $$BusinessSettingsTableAnnotationComposer,
          $$BusinessSettingsTableCreateCompanionBuilder,
          $$BusinessSettingsTableUpdateCompanionBuilder,
          (
            BusinessSetting,
            BaseReferences<
              _$AppDatabase,
              $BusinessSettingsTable,
              BusinessSetting
            >,
          ),
          BusinessSetting,
          PrefetchHooks Function()
        > {
  $$BusinessSettingsTableTableManager(
    _$AppDatabase db,
    $BusinessSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BusinessSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BusinessSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BusinessSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> shopName = const Value.absent(),
                Value<String> ownerName = const Value.absent(),
                Value<String> shopAddress = const Value.absent(),
                Value<String> mobileNumber = const Value.absent(),
                Value<String?> alternateMobile = const Value.absent(),
                Value<String?> gstin = const Value.absent(),
                Value<String> invoicePrefix = const Value.absent(),
                Value<String> jobPrefix = const Value.absent(),
                Value<double> defaultTaxRate = const Value.absent(),
                Value<bool> isGstEnabled = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> defaultLanguage = const Value.absent(),
                Value<String?> pdfFooter = const Value.absent(),
                Value<String?> warrantyTerms = const Value.absent(),
                Value<String?> paymentInstructions = const Value.absent(),
                Value<bool> autoBackupEnabled = const Value.absent(),
                Value<String> backupScheduleTime = const Value.absent(),
                Value<int> backupRetentionCount = const Value.absent(),
                Value<DateTime?> lastBackupTimestamp = const Value.absent(),
                Value<String?> lastBackupStatus = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => BusinessSettingsCompanion(
                id: id,
                shopName: shopName,
                ownerName: ownerName,
                shopAddress: shopAddress,
                mobileNumber: mobileNumber,
                alternateMobile: alternateMobile,
                gstin: gstin,
                invoicePrefix: invoicePrefix,
                jobPrefix: jobPrefix,
                defaultTaxRate: defaultTaxRate,
                isGstEnabled: isGstEnabled,
                currency: currency,
                defaultLanguage: defaultLanguage,
                pdfFooter: pdfFooter,
                warrantyTerms: warrantyTerms,
                paymentInstructions: paymentInstructions,
                autoBackupEnabled: autoBackupEnabled,
                backupScheduleTime: backupScheduleTime,
                backupRetentionCount: backupRetentionCount,
                lastBackupTimestamp: lastBackupTimestamp,
                lastBackupStatus: lastBackupStatus,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> shopName = const Value.absent(),
                Value<String> ownerName = const Value.absent(),
                Value<String> shopAddress = const Value.absent(),
                Value<String> mobileNumber = const Value.absent(),
                Value<String?> alternateMobile = const Value.absent(),
                Value<String?> gstin = const Value.absent(),
                Value<String> invoicePrefix = const Value.absent(),
                Value<String> jobPrefix = const Value.absent(),
                Value<double> defaultTaxRate = const Value.absent(),
                Value<bool> isGstEnabled = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> defaultLanguage = const Value.absent(),
                Value<String?> pdfFooter = const Value.absent(),
                Value<String?> warrantyTerms = const Value.absent(),
                Value<String?> paymentInstructions = const Value.absent(),
                Value<bool> autoBackupEnabled = const Value.absent(),
                Value<String> backupScheduleTime = const Value.absent(),
                Value<int> backupRetentionCount = const Value.absent(),
                Value<DateTime?> lastBackupTimestamp = const Value.absent(),
                Value<String?> lastBackupStatus = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => BusinessSettingsCompanion.insert(
                id: id,
                shopName: shopName,
                ownerName: ownerName,
                shopAddress: shopAddress,
                mobileNumber: mobileNumber,
                alternateMobile: alternateMobile,
                gstin: gstin,
                invoicePrefix: invoicePrefix,
                jobPrefix: jobPrefix,
                defaultTaxRate: defaultTaxRate,
                isGstEnabled: isGstEnabled,
                currency: currency,
                defaultLanguage: defaultLanguage,
                pdfFooter: pdfFooter,
                warrantyTerms: warrantyTerms,
                paymentInstructions: paymentInstructions,
                autoBackupEnabled: autoBackupEnabled,
                backupScheduleTime: backupScheduleTime,
                backupRetentionCount: backupRetentionCount,
                lastBackupTimestamp: lastBackupTimestamp,
                lastBackupStatus: lastBackupStatus,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BusinessSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BusinessSettingsTable,
      BusinessSetting,
      $$BusinessSettingsTableFilterComposer,
      $$BusinessSettingsTableOrderingComposer,
      $$BusinessSettingsTableAnnotationComposer,
      $$BusinessSettingsTableCreateCompanionBuilder,
      $$BusinessSettingsTableUpdateCompanionBuilder,
      (
        BusinessSetting,
        BaseReferences<_$AppDatabase, $BusinessSettingsTable, BusinessSetting>,
      ),
      BusinessSetting,
      PrefetchHooks Function()
    >;
typedef $$BackupHistoriesTableCreateCompanionBuilder =
    BackupHistoriesCompanion Function({
      Value<int> id,
      Value<DateTime> backupDate,
      required String fileName,
      required int fileSize,
      Value<String?> driveFileId,
      Value<String> backupType,
      required String status,
      Value<String?> errorMessage,
      Value<DateTime> createdAt,
    });
typedef $$BackupHistoriesTableUpdateCompanionBuilder =
    BackupHistoriesCompanion Function({
      Value<int> id,
      Value<DateTime> backupDate,
      Value<String> fileName,
      Value<int> fileSize,
      Value<String?> driveFileId,
      Value<String> backupType,
      Value<String> status,
      Value<String?> errorMessage,
      Value<DateTime> createdAt,
    });

class $$BackupHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $BackupHistoriesTable> {
  $$BackupHistoriesTableFilterComposer({
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

  ColumnFilters<DateTime> get backupDate => $composableBuilder(
    column: $table.backupDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get driveFileId => $composableBuilder(
    column: $table.driveFileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backupType => $composableBuilder(
    column: $table.backupType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BackupHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $BackupHistoriesTable> {
  $$BackupHistoriesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get backupDate => $composableBuilder(
    column: $table.backupDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get driveFileId => $composableBuilder(
    column: $table.driveFileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backupType => $composableBuilder(
    column: $table.backupType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BackupHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BackupHistoriesTable> {
  $$BackupHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get backupDate => $composableBuilder(
    column: $table.backupDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumn<String> get driveFileId => $composableBuilder(
    column: $table.driveFileId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backupType => $composableBuilder(
    column: $table.backupType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BackupHistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BackupHistoriesTable,
          BackupHistory,
          $$BackupHistoriesTableFilterComposer,
          $$BackupHistoriesTableOrderingComposer,
          $$BackupHistoriesTableAnnotationComposer,
          $$BackupHistoriesTableCreateCompanionBuilder,
          $$BackupHistoriesTableUpdateCompanionBuilder,
          (
            BackupHistory,
            BaseReferences<_$AppDatabase, $BackupHistoriesTable, BackupHistory>,
          ),
          BackupHistory,
          PrefetchHooks Function()
        > {
  $$BackupHistoriesTableTableManager(
    _$AppDatabase db,
    $BackupHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackupHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BackupHistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BackupHistoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> backupDate = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<int> fileSize = const Value.absent(),
                Value<String?> driveFileId = const Value.absent(),
                Value<String> backupType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BackupHistoriesCompanion(
                id: id,
                backupDate: backupDate,
                fileName: fileName,
                fileSize: fileSize,
                driveFileId: driveFileId,
                backupType: backupType,
                status: status,
                errorMessage: errorMessage,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> backupDate = const Value.absent(),
                required String fileName,
                required int fileSize,
                Value<String?> driveFileId = const Value.absent(),
                Value<String> backupType = const Value.absent(),
                required String status,
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BackupHistoriesCompanion.insert(
                id: id,
                backupDate: backupDate,
                fileName: fileName,
                fileSize: fileSize,
                driveFileId: driveFileId,
                backupType: backupType,
                status: status,
                errorMessage: errorMessage,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BackupHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BackupHistoriesTable,
      BackupHistory,
      $$BackupHistoriesTableFilterComposer,
      $$BackupHistoriesTableOrderingComposer,
      $$BackupHistoriesTableAnnotationComposer,
      $$BackupHistoriesTableCreateCompanionBuilder,
      $$BackupHistoriesTableUpdateCompanionBuilder,
      (
        BackupHistory,
        BaseReferences<_$AppDatabase, $BackupHistoriesTable, BackupHistory>,
      ),
      BackupHistory,
      PrefetchHooks Function()
    >;
typedef $$JobStatusHistoriesTableCreateCompanionBuilder =
    JobStatusHistoriesCompanion Function({
      Value<int> id,
      required int repairJobId,
      Value<String?> fromStatus,
      required String toStatus,
      Value<String?> notes,
      Value<DateTime> changedAt,
    });
typedef $$JobStatusHistoriesTableUpdateCompanionBuilder =
    JobStatusHistoriesCompanion Function({
      Value<int> id,
      Value<int> repairJobId,
      Value<String?> fromStatus,
      Value<String> toStatus,
      Value<String?> notes,
      Value<DateTime> changedAt,
    });

final class $$JobStatusHistoriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $JobStatusHistoriesTable,
          JobStatusHistory
        > {
  $$JobStatusHistoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RepairJobsTable _repairJobIdTable(_$AppDatabase db) =>
      db.repairJobs.createAlias(
        $_aliasNameGenerator(
          db.jobStatusHistories.repairJobId,
          db.repairJobs.id,
        ),
      );

  $$RepairJobsTableProcessedTableManager get repairJobId {
    final $_column = $_itemColumn<int>('repair_job_id')!;

    final manager = $$RepairJobsTableTableManager(
      $_db,
      $_db.repairJobs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_repairJobIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$JobStatusHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $JobStatusHistoriesTable> {
  $$JobStatusHistoriesTableFilterComposer({
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

  ColumnFilters<String> get fromStatus => $composableBuilder(
    column: $table.fromStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toStatus => $composableBuilder(
    column: $table.toStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RepairJobsTableFilterComposer get repairJobId {
    final $$RepairJobsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairJobId,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableFilterComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JobStatusHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $JobStatusHistoriesTable> {
  $$JobStatusHistoriesTableOrderingComposer({
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

  ColumnOrderings<String> get fromStatus => $composableBuilder(
    column: $table.fromStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toStatus => $composableBuilder(
    column: $table.toStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RepairJobsTableOrderingComposer get repairJobId {
    final $$RepairJobsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairJobId,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableOrderingComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JobStatusHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JobStatusHistoriesTable> {
  $$JobStatusHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fromStatus => $composableBuilder(
    column: $table.fromStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get toStatus =>
      $composableBuilder(column: $table.toStatus, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);

  $$RepairJobsTableAnnotationComposer get repairJobId {
    final $$RepairJobsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairJobId,
      referencedTable: $db.repairJobs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairJobsTableAnnotationComposer(
            $db: $db,
            $table: $db.repairJobs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JobStatusHistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JobStatusHistoriesTable,
          JobStatusHistory,
          $$JobStatusHistoriesTableFilterComposer,
          $$JobStatusHistoriesTableOrderingComposer,
          $$JobStatusHistoriesTableAnnotationComposer,
          $$JobStatusHistoriesTableCreateCompanionBuilder,
          $$JobStatusHistoriesTableUpdateCompanionBuilder,
          (JobStatusHistory, $$JobStatusHistoriesTableReferences),
          JobStatusHistory,
          PrefetchHooks Function({bool repairJobId})
        > {
  $$JobStatusHistoriesTableTableManager(
    _$AppDatabase db,
    $JobStatusHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobStatusHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobStatusHistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobStatusHistoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> repairJobId = const Value.absent(),
                Value<String?> fromStatus = const Value.absent(),
                Value<String> toStatus = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> changedAt = const Value.absent(),
              }) => JobStatusHistoriesCompanion(
                id: id,
                repairJobId: repairJobId,
                fromStatus: fromStatus,
                toStatus: toStatus,
                notes: notes,
                changedAt: changedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int repairJobId,
                Value<String?> fromStatus = const Value.absent(),
                required String toStatus,
                Value<String?> notes = const Value.absent(),
                Value<DateTime> changedAt = const Value.absent(),
              }) => JobStatusHistoriesCompanion.insert(
                id: id,
                repairJobId: repairJobId,
                fromStatus: fromStatus,
                toStatus: toStatus,
                notes: notes,
                changedAt: changedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$JobStatusHistoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({repairJobId = false}) {
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
                    if (repairJobId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.repairJobId,
                                referencedTable:
                                    $$JobStatusHistoriesTableReferences
                                        ._repairJobIdTable(db),
                                referencedColumn:
                                    $$JobStatusHistoriesTableReferences
                                        ._repairJobIdTable(db)
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

typedef $$JobStatusHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JobStatusHistoriesTable,
      JobStatusHistory,
      $$JobStatusHistoriesTableFilterComposer,
      $$JobStatusHistoriesTableOrderingComposer,
      $$JobStatusHistoriesTableAnnotationComposer,
      $$JobStatusHistoriesTableCreateCompanionBuilder,
      $$JobStatusHistoriesTableUpdateCompanionBuilder,
      (JobStatusHistory, $$JobStatusHistoriesTableReferences),
      JobStatusHistory,
      PrefetchHooks Function({bool repairJobId})
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      Value<DateTime> expenseDate,
      required String category,
      required double amount,
      Value<String> paymentMode,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      Value<DateTime> expenseDate,
      Value<String> category,
      Value<double> amount,
      Value<String> paymentMode,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
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

  ColumnFilters<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get expenseDate => $composableBuilder(
    column: $table.expenseDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get paymentMode => $composableBuilder(
    column: $table.paymentMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
          Expense,
          PrefetchHooks Function()
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> expenseDate = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> paymentMode = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                expenseDate: expenseDate,
                category: category,
                amount: amount,
                paymentMode: paymentMode,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> expenseDate = const Value.absent(),
                required String category,
                required double amount,
                Value<String> paymentMode = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExpensesCompanion.insert(
                id: id,
                expenseDate: expenseDate,
                category: category,
                amount: amount,
                paymentMode: paymentMode,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, BaseReferences<_$AppDatabase, $ExpensesTable, Expense>),
      Expense,
      PrefetchHooks Function()
    >;
typedef $$AuditLogsTableCreateCompanionBuilder =
    AuditLogsCompanion Function({
      Value<int> id,
      required String action,
      required String targetEntity,
      Value<int?> entityId,
      Value<String?> details,
      Value<DateTime> createdAt,
    });
typedef $$AuditLogsTableUpdateCompanionBuilder =
    AuditLogsCompanion Function({
      Value<int> id,
      Value<String> action,
      Value<String> targetEntity,
      Value<int?> entityId,
      Value<String?> details,
      Value<DateTime> createdAt,
    });

class $$AuditLogsTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
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

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetEntity => $composableBuilder(
    column: $table.targetEntity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
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

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetEntity => $composableBuilder(
    column: $table.targetEntity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get targetEntity => $composableBuilder(
    column: $table.targetEntity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AuditLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogsTable,
          AuditLog,
          $$AuditLogsTableFilterComposer,
          $$AuditLogsTableOrderingComposer,
          $$AuditLogsTableAnnotationComposer,
          $$AuditLogsTableCreateCompanionBuilder,
          $$AuditLogsTableUpdateCompanionBuilder,
          (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
          AuditLog,
          PrefetchHooks Function()
        > {
  $$AuditLogsTableTableManager(_$AppDatabase db, $AuditLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String> targetEntity = const Value.absent(),
                Value<int?> entityId = const Value.absent(),
                Value<String?> details = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AuditLogsCompanion(
                id: id,
                action: action,
                targetEntity: targetEntity,
                entityId: entityId,
                details: details,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String action,
                required String targetEntity,
                Value<int?> entityId = const Value.absent(),
                Value<String?> details = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AuditLogsCompanion.insert(
                id: id,
                action: action,
                targetEntity: targetEntity,
                entityId: entityId,
                details: details,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogsTable,
      AuditLog,
      $$AuditLogsTableFilterComposer,
      $$AuditLogsTableOrderingComposer,
      $$AuditLogsTableAnnotationComposer,
      $$AuditLogsTableCreateCompanionBuilder,
      $$AuditLogsTableUpdateCompanionBuilder,
      (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
      AuditLog,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$ProductCategoriesTableTableManager get productCategories =>
      $$ProductCategoriesTableTableManager(_db, _db.productCategories);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$RepairJobsTableTableManager get repairJobs =>
      $$RepairJobsTableTableManager(_db, _db.repairJobs);
  $$RepairJobPartsTableTableManager get repairJobParts =>
      $$RepairJobPartsTableTableManager(_db, _db.repairJobParts);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$InvoiceItemsTableTableManager get invoiceItems =>
      $$InvoiceItemsTableTableManager(_db, _db.invoiceItems);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$StockMovementsTableTableManager get stockMovements =>
      $$StockMovementsTableTableManager(_db, _db.stockMovements);
  $$DailyWorkLogsTableTableManager get dailyWorkLogs =>
      $$DailyWorkLogsTableTableManager(_db, _db.dailyWorkLogs);
  $$BusinessSettingsTableTableManager get businessSettings =>
      $$BusinessSettingsTableTableManager(_db, _db.businessSettings);
  $$BackupHistoriesTableTableManager get backupHistories =>
      $$BackupHistoriesTableTableManager(_db, _db.backupHistories);
  $$JobStatusHistoriesTableTableManager get jobStatusHistories =>
      $$JobStatusHistoriesTableTableManager(_db, _db.jobStatusHistories);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db, _db.auditLogs);
}
